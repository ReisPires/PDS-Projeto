package Control;

import DAO.DAOAtividade;
import Model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "AlterarAtividade", urlPatterns = {"/alterarAtividade"})
public class AlterarAtividade extends HttpServlet {

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
        if (usuario == null || usuario.getTipo().equals("R") || usuario.getTipo().equals("A")) {
            request.getRequestDispatcher("index.jsp").forward(request, response);
            return;
        }                
        
        DAOAtividade dAOAtividade = new DAOAtividade();
                
        String codigo = request.getParameter("codigo");        
        Integer ano = request.getParameter("ano").equals("") ? 0 : Integer.parseInt(request.getParameter("ano"));
        String semestre = request.getParameter("semestre");
        String horario = request.getParameter("horario");
        String concluida = request.getParameter("concluida");
        String[] professores;
        professores = request.getParameterValues("selecao-professor");
        String[] alunos;
        alunos = request.getParameterValues("selecao-aluno");
        
        int resultadoAltera = dAOAtividade.atualizaAtividade(new Atividade(codigo, "", ano, semestre, horario, concluida != null));
        
        if (resultadoAltera == 0) {        
            if (professores != null)
                for (String p : professores)
                    dAOAtividade.associaProfessor(new ProfessorAtividade(codigo, p));                                    
            if (alunos != null)
                for (String a : alunos) {
                    ArrayList<String> atv = new ArrayList<>();
                    atv.add(codigo);
                    dAOAtividade.matriculaAluno(new AlunoAtividade(a, atv));
                }
        }
        
        request.getSession().setAttribute("resultadoAltera", resultadoAltera);
        request.getRequestDispatcher("altera-atividade.jsp?codigo=" + codigo).forward(request, response);
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
