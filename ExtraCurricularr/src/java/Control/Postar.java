/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import DAO.*;
import Model.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Gustavo
 */
@WebServlet(name = "Postar", urlPatterns = {"/postar"})
@MultipartConfig
public class Postar extends HttpServlet {

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
        String professor = request.getParameter("professor");
        String atividade = request.getParameter("atividade");
        String titulo = request.getParameter("titulo");
        String texto = request.getParameter("texto");
        
        Part parte = request.getPart("midia");
        String midia = null;        
        
        if (!"".equals(parte.getSubmittedFileName())) {            
            String arquivo = Paths.get(parte.getSubmittedFileName()).getFileName().toString();
            String caminho = "C:/Users/Gustavo/Arquivos/UFSCar/6º Semestre/Matérias/Projeto e Desenvolvimento de Sistemas/Projeto/PDS-Projeto/ExtraCurricular/web/media";
            midia = caminho + "/" + arquivo;
            
            Files.copy(parte.getInputStream(), Paths.get(midia), REPLACE_EXISTING);
        }
        
        DAOUsuario daoUsuario = new DAOUsuario();               
        new DAOAtividade().insereInformacao(new Informacao(daoUsuario.recuperaProfessor(new Professor(new Usuario(Integer.valueOf(professor)))).getCodigo(), atividade, titulo, texto, midia));
        
        request.setAttribute("success", true);
        request.getRequestDispatcher("postar.jsp?atividade=" + atividade).forward(request, response);
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
