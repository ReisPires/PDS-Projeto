package Control;

import DAO.DAOLogin;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "EntrarPrimeiroAcesso", urlPatterns = {"/entrarPrimeiroAcesso"})
public class EntrarPrimeiroAcesso extends HttpServlet {

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
        DAOLogin daoLogin = new DAOLogin();
        
        String login = request.getParameter("login");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String confirmacao = request.getParameter("confirmacao");
        
        if (!senha.equals(confirmacao)) {
            request.getSession().setAttribute("errmsg", 0);
            request.getRequestDispatcher("primeiro-acesso.jsp").forward(request, response);
            return;
        }        
        
        Usuario usuario = daoLogin.realizaPrimeiroAcesso(login, email, senha);
        
        if (usuario == null) {
            request.getSession().setAttribute("errmsg", 1);
            request.getRequestDispatcher("primeiro-acesso.jsp").forward(request, response);
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
