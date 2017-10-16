package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class csv_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");


// Verifica se o usuário não está logado
if (request.getSession().getAttribute("usuario") == null)
    request.getRequestDispatcher("index.jsp").forward(request, response);

      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <meta charset=\"utf-8\">\r\n");
      out.write("        <title>Cadastro por CSV</title>\r\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"styles/main.css\">\r\n");
      out.write("        <style>\r\n");
      out.write("            .janela {\r\n");
      out.write("                margin: auto;\r\n");
      out.write("                \r\n");
      out.write("                border: 1px solid black;\r\n");
      out.write("                \r\n");
      out.write("                padding: 15px;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            .grupo {\r\n");
      out.write("                margin-bottom: 5px;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            input[type=text], input[type=password] {\r\n");
      out.write("                width: 170px;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            input[type=button] {\r\n");
      out.write("                width: 130px;\r\n");
      out.write("            }\r\n");
      out.write("            \r\n");
      out.write("            #cadastrar {\r\n");
      out.write("                float: right;\r\n");
      out.write("            }\r\n");
      out.write("        </style>\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        <div class=\"janela\">\r\n");
      out.write("            <div style=\"text-align: center; margin-bottom: 10px\">\r\n");
      out.write("                Cadastro por CSV\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"grupo\">\r\n");
      out.write("                <div><label for=\"professores\">Cadastro de professores:</label></div>\r\n");
      out.write("                <div><input id=\"professores\" type=\"file\" accept=\".csv\"/></div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"grupo\">\r\n");
      out.write("                <div><label for=\"atividades\">Cadastro de atividades:</label></div>\r\n");
      out.write("                <div><input id=\"atividades\" type=\"file\" accept=\".csv\"/></div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"grupo\">\r\n");
      out.write("                <div><label for=\"pais-alunos\">Cadastro de pais e alunos:</label></div>\r\n");
      out.write("                <div><input id=\"pais-alunos\" type=\"file\" accept=\".csv\"/></div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div style=\"margin-top: 15px\">\r\n");
      out.write("                <input id=\"retornar\" type=\"button\" value=\"Retornar\"/>\r\n");
      out.write("                <input id=\"cadastrar\" type=\"button\" value=\"Cadastrar\"/>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </body>\r\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}