/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import DAO.*;
import Model.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo
 */
@WebServlet(name = "CSV", urlPatterns = {"/csv"})
@MultipartConfig
public class CSV extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DAOUsuario daoUsuario = new DAOUsuario();
        DAOAtividade daoAtividade = new DAOAtividade();   
        
        // Professores
        try {
            InputStream inputStream = request.getPart("professores").getInputStream();
            InputStreamReader streamReader = new InputStreamReader(inputStream, "UTF-8");
            BufferedReader fileReader = new BufferedReader(streamReader);
            String line = fileReader.readLine();
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                
                // Le a linha do CSV
                String codigo = csvReader.next();
                String nome = csvReader.next();
                String email = csvReader.next();
               
                // Cadastra o professor
                Professor professor = new Professor(codigo, new Usuario(codigo, null), new DadosPessoais(email, nome), new Endereco());
                daoUsuario.cadastraProfessor(professor);                

            }          
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        // Atividades
        try {
            InputStream inputStream = request.getPart("atividades").getInputStream();
            InputStreamReader streamReader = new InputStreamReader(inputStream, "UTF-8");
            BufferedReader fileReader = new BufferedReader(streamReader);
            String line = fileReader.readLine();
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                
                // Le a linha do CSV
                String codigo = csvReader.next();
                String nomeAtividade = csvReader.next();
                String codProfessor = csvReader.next();
                String codAluno = csvReader.next();
                                                
                // Cadastra a atividade
                String[] professores = codProfessor.replace(" ", "").replace("\"", "").split("/");
                String[] alunos = codAluno.replace(" ", "").replace("\"", "").split("/");
                
                Atividade atividade = new Atividade(codigo, nomeAtividade);                
                daoAtividade.cadastraAtividade(atividade);
                
                for (String prof : professores)                   
                    daoAtividade.associaProfessor(new ProfessorAtividade(codigo, prof));                 
                
                for (String aluno : alunos)                   
                    daoAtividade.matriculaAluno(new AlunoAtividade(aluno, codigo));
                
            }
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        // Pais e alunos
        try {
            InputStream inputStream = request.getPart("pais-alunos").getInputStream();
            InputStreamReader streamReader = new InputStreamReader(inputStream, "UTF-8");
            BufferedReader fileReader = new BufferedReader(streamReader);
            String line = fileReader.readLine();
            
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                
                // Le a linha do CSV
                String rm = csvReader.next();
                String nome = csvReader.next();
                String turma = csvReader.next();
                String emailAluno = csvReader.next();
                String cpfPai = csvReader.next();
                String emailPai = csvReader.next();
                String telefonePai = csvReader.next();
                String cpfMae = csvReader.next();
                String emailMae = csvReader.next();
                String telefoneMae = csvReader.next();  
                
                // Cadastra o aluno
                Aluno aluno = new Aluno(rm, turma, new Usuario(rm), new DadosPessoais(emailAluno, nome), new Endereco());
                daoUsuario.cadastraAluno(aluno);    
                
                // Cadastra o pai
                if (!cpfPai.trim().isEmpty()) {
                    Responsavel pai = new Responsavel(new Usuario(cpfPai), new DadosPessoais(cpfPai, emailPai, telefonePai), new Endereco());
                    daoUsuario.cadastraResponsavel(pai, aluno);
                }                
                // Cadastra a mae
                if (!cpfMae.trim().isEmpty()) {
                    Responsavel mae = new Responsavel(new Usuario(cpfMae), new DadosPessoais(cpfMae, emailMae, telefoneMae), new Endereco());
                    daoUsuario.cadastraResponsavel(mae, aluno);
                }
            }          
        } catch (Exception ex) {
            System.out.println(ex);
        }
        
        request.setAttribute("success", true);
        request.getRequestDispatcher("csv.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
