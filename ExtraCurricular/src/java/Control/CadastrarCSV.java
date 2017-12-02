package Control;

import DAO.*;
import Model.*;

import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CadastrarCSV", urlPatterns = {"/cadastrarCSV"})
@MultipartConfig
public class CadastrarCSV extends HttpServlet {

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
        RelatorioCadastroCSV relatorio = new RelatorioCadastroCSV();        
        
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
                String cpf = csvReader.next();
                String email = csvReader.next();
               
                // Cadastra o professor
                Professor professor = new Professor(codigo, new Usuario(codigo, codigo), new DadosPessoais(cpf, email, nome));
                if (daoUsuario.cadastraProfessor(professor) == 0)
                    relatorio.successProfessor++;
                else
                    relatorio.errorProfessor++;
            }          
        } catch (Exception e) {
            System.out.println(e);
        }
        
        // Pais e alunos
        try {
            InputStream inputStream = request.getPart("responsaveis-alunos").getInputStream();
            InputStreamReader streamReader = new InputStreamReader(inputStream, "UTF-8");
            BufferedReader fileReader = new BufferedReader(streamReader);
            String line = fileReader.readLine();
            
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                
                // Le a linha do CSV
                String matricula = csvReader.next();
                String nomeAluno = csvReader.next();
                String turma = csvReader.next();
                String emailAluno = csvReader.next();
                String nomePai = csvReader.next();
                String cpfPai = csvReader.next();
                String emailPai = csvReader.next();
                String telefonePai = csvReader.next();
                String nomeMae = csvReader.next();
                String cpfMae = csvReader.next();
                String emailMae = csvReader.next();
                String telefoneMae = csvReader.next();  
                
                // Cadastra o aluno
                Aluno aluno = new Aluno(matricula, turma, new Usuario(matricula, matricula), new DadosPessoais(emailAluno, nomeAluno));
                if (daoUsuario.cadastraAluno(aluno) == 0)
                    relatorio.successAluno++;
                else
                    relatorio.errorAluno++;
                
                ArrayList<Aluno> alunoLista = new ArrayList<>();
                alunoLista.add(aluno);
                
                // Cadastra o pai
                if (!cpfPai.trim().isEmpty()) {
                    Responsavel pai = new Responsavel(new Usuario(cpfPai, cpfPai), new DadosPessoais(cpfPai, emailPai, telefonePai, nomePai));
                    if (daoUsuario.cadastraResponsavel(pai, alunoLista) == 0)
                        relatorio.successResponsavel++;
                    else
                        relatorio.errorResponsavel++;
                }                
                // Cadastra a mae
                if (!cpfMae.trim().isEmpty()) {
                    Responsavel mae = new Responsavel(new Usuario(cpfMae, cpfMae), new DadosPessoais(cpfMae, emailMae, telefoneMae, nomeMae));
                    if (daoUsuario.cadastraResponsavel(mae, alunoLista) == 0)
                        relatorio.successResponsavel++;
                    else
                        relatorio.errorResponsavel++;                    
                }
            }          
        } catch (Exception e) {
            System.out.println(e);
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
                boolean sucessoAtividade = daoAtividade.cadastraAtividade(atividade) == 0;                
                boolean atualizacaoAtividade = false;
                
                for (String prof : professores)
                    atualizacaoAtividade = atualizacaoAtividade || daoAtividade.associaProfessor(new ProfessorAtividade(codigo, prof)) == 0;
                
                ArrayList<String> atividades = new ArrayList<>();
                atividades.add(codigo);
                
                for (String aluno : alunos)
                    daoAtividade.matriculaAluno(new AlunoAtividade(aluno, atividades));                              
                
                if (sucessoAtividade && atualizacaoAtividade)
                    relatorio.successAtividade++;
                else if (!atualizacaoAtividade)
                    relatorio.errorAtividade++;
            }
        } catch (Exception e) {
            System.out.println(e);
        } 
        
        request.getSession().setAttribute("relatorioCadastroCSV", relatorio);
        request.getRequestDispatcher("cadastro-csv.jsp").forward(request, response);
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
