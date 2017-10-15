/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import DAO.*;
import Model.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo
 */
@WebServlet(name = "Entrar", urlPatterns = {"/entrar"})
public class Entrar extends HttpServlet {

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
        // Verifica se o usuário já está logado
        if (request.getSession().getAttribute("usuario") != null) {
            request.getRequestDispatcher("atividades.jsp").forward(request, response);
            
            return;
        }
        
        // Caso não estiver logado, tentar logar
        String usuario = (String)request.getParameter("usuario");
        String senha = (String)request.getParameter("senha");
        
        DAOLogin daoLogin = new DAOLogin();
        Usuario u = daoLogin.realizaLogin(new Usuario(usuario, senha));
        
        // Verifica se o usuário conseguiu logar
        if (u != null) {
            request.getSession().setAttribute("usuario", u.getId());
            if ("E".equals(u.getTipo())) {
                request.getRequestDispatcher("csv.jsp").forward(request, response);
            } else {                
                request.getRequestDispatcher("atividades.jsp").forward(request, response);
            }
            return;
        }
        
        // O usuário não conseguiu logar
        request.setAttribute("incorrect", new Boolean(true));
        request.getRequestDispatcher("index.jsp").forward(request, response);
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
