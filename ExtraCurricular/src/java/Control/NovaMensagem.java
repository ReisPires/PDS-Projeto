/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Control;

import DAO.DAOMensagem;
import Model.Mensagem;
import Model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Gustavo
 */
@WebServlet(name = "NovaMensagem", urlPatterns = {"/nova-mensagem"})
public class NovaMensagem extends HttpServlet {

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
        Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
        if (usuario == null) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }
        
        DAOMensagem daoMensagem = new DAOMensagem();
        
        String titulo = request.getParameter("titulo");
        String destino = null;
        String[] selecao;
        selecao = request.getParameterValues("selecao");
        String texto = request.getParameter("texto");
        
        ArrayList<Integer> destinatarios = new ArrayList<>();
        
        if (usuario.getTipo().equals("E") || usuario.getTipo().equals("P")) {
            destino = request.getParameter("destino");
            
            if (destino.equals("todos")) {
                // Adicionar todo mundo aos destinatários
            } else if (destino.equals("atividades")) {
                // Adicionar todo mundo das atividades aos destinatários
            } else {
                // Adicionar selecionados aos destinatários
                for (int i = 0; i < selecao.length; ++i)
                    destinatarios.add(Integer.parseInt(selecao[i]));
            }
        } else {
            // Adicionar todos os professores selecionados aos destinatários
            for (int i = 0; i < selecao.length; ++i)
                destinatarios.add(Integer.parseInt(selecao[i]));
        }
        
        Mensagem mensagem = new Mensagem(usuario.getId(), destinatarios, titulo, texto);
        
        daoMensagem.enviaMensagem(mensagem);
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
