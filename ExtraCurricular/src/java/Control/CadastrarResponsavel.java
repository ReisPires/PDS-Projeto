package Control;

import DAO.DAOUsuario;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CadastrarResponsavel", urlPatterns = {"/cadastrarResponsavel"})
public class CadastrarResponsavel extends HttpServlet {

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
        if (usuario == null || !usuario.getTipo().equals("E")) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }                
        
        DAOUsuario daoUsuario = new DAOUsuario();
                
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String cpf = request.getParameter("cpf");
        String telefone = request.getParameter("telefone");
        String sexo = ("masc".equals(request.getParameter("sexo")) ? "M" : ("fem".equals(request.getParameter("sexo")) ? "F" : null));        
        String pais = request.getParameter("pais");
        String cep = request.getParameter("cep");
        String estado = request.getParameter("estado");
        String cidade = request.getParameter("cidade");
        String bairro = request.getParameter("bairro");
        String rua = request.getParameter("rua");
        String numero = request.getParameter("numero");
        String complemento = request.getParameter("complemento");        
        String[] selecao;
        selecao = request.getParameterValues("selecao");
                
        if (selecao == null)
            request.getSession().setAttribute("resultadoCadastro", 21);
        else {
            ArrayList<Aluno> alunos = new ArrayList<>();        
            for (int i = 0; i < selecao.length; ++i)
                alunos.add(new Aluno(selecao[i]));        

            request.getSession().setAttribute("resultadoCadastro", daoUsuario.cadastraResponsavel(new Responsavel(new Usuario(cpf, cpf), new DadosPessoais(cpf, email, telefone, nome, sexo, new Endereco(pais, cep, estado, cidade, bairro, rua, numero, complemento))), alunos));
        }
        
        request.getRequestDispatcher("cadastro-responsavel.jsp").forward(request, response);
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