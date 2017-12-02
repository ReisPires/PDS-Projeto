package Control;

import DAO.DAOAtividade;
import DAO.DAOLogin;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
        
        DAOLogin daoLogin = new DAOLogin();
        Usuario usuario = null;
        
        String id = (String)request.getParameter("id");
        if (id != null) {
            usuario = daoLogin.realizaLoginFacebook(id);            
        } else {
            String login = (String)request.getParameter("login");
            String senha = (String)request.getParameter("senha");               
            usuario = daoLogin.realizaLogin(new Usuario(login, senha));
        }                
                
        // Verifica se o usuário conseguiu logar
        if (usuario == null) {
            // O usuário não conseguiu logar
            request.setAttribute("incorrect", true);
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }              
        
        request.getSession().setAttribute("usuario", usuario);
        request.getRequestDispatcher("atividades.jsp").forward(request, response);
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
