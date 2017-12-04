package Control;

import DAO.DAOAtividade;
import Model.Atividade;
import Model.Postagem;
import Model.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import static java.nio.file.StandardCopyOption.REPLACE_EXISTING;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet(name = "EditarPost", urlPatterns = {"/editar-post"})
@MultipartConfig
public class EditarPost extends HttpServlet {

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

        String codigo = request.getParameter("atividade");
        String post = request.getParameter("codigo");
        String titulo = request.getParameter("titulo");
        String texto = request.getParameter("texto");
        String[] mantidos = request.getParameterValues("mantidos");
        if (mantidos == null)
            mantidos = new String[0];
        ArrayList<String> midias = new ArrayList<>();
        
        for (int i = 0; i < mantidos.length; ++i)
            midias.add(mantidos[i]);
        
        Collection<Part> parts = request.getParts();
        for (Part part: parts) {
            if (!part.getName().equals("midias"))
                continue;
            
            if (!"".equals(part.getSubmittedFileName())) {            
                String arquivo = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                //String caminho = "C:/Users/Pedro Pires/Documents/GitHub/PDS-Projeto/ExtraCurricular/web/media";
                String caminho = "C:/Users/Gustavo/Arquivos/UFSCar/6º Semestre/Matérias/Projeto e Desenvolvimento de Sistemas/Projeto/PDS-Projeto/ExtraCurricular/web/media";
                String midia = caminho + "/" + arquivo;
                
                midias.add(arquivo);

                Files.copy(part.getInputStream(), Paths.get(midia), REPLACE_EXISTING);
            }
        }
        
        Atividade atividade = new Atividade(codigo, "");
        Postagem postagem = new Postagem(Integer.parseInt(post), titulo, texto, midias);
        
        DAOAtividade daoAtividade = new DAOAtividade();               
        daoAtividade.atualizaPostagem(postagem);
        
        request.setAttribute("success", true);          
        response.sendRedirect("atividade.jsp?codigo=" + codigo);
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
