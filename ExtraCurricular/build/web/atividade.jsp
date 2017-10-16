<%@page import="java.util.ArrayList"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%!
boolean isImage(String fileName) {
    if (fileName == null)
        return false;
    
    String extension = fileName.substring(fileName.lastIndexOf('.'));
    
    return extension == ".png" || extension == ".jpg" || extension == ".bmp";
}

boolean isVideo(String fileName) {
    if (fileName == null)
        return false;
    
    String extension = fileName.substring(fileName.lastIndexOf('.'));
    
    return extension == ".mp4" || extension == ".avi" || extension == ".wmv";
}
%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

String codigo = request.getParameter("codigo");
if (codigo == null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

DAOAtividade daoAtividade = new DAOAtividade();
ArrayList<Informacao> informacoes = daoAtividade.exibeInformacoesAtividade(new Atividade(codigo, null));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Atividade</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                width: 500px;
                
                padding: 15px;
            }
            
            input[type=button] {
                display: block;
                
                margin-bottom: 15px;
                
                width: 100%;
            }
            
            .atividade {
                margin-bottom: 15px;
            
                border: 1px solid black;
                
                padding: 10px 0px;
            
                font-size: 25px;
                font-weight: bold;
                text-align: center;
            }
            
            .vazio {
                border: 1px solid black;
                
                padding: 10px 0px;
                
                text-align: center;
            }
            
            .post {
                margin-top: 10px;
                
                border: 1px solid black;
                
                padding: 10px;
            }
            
            .titulo {
                font-weight: bold;
            }
            
            .data {
                color: #a0a0a0;
                margin-bottom: 8px;
            }
            
            .legenda {
                margin-bottom: 4px;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <input id="retornar" type="button" value="Retornar � lista de atividades"/>
            <% if (usuario.getTipo().equals("P")) { %>
            <input id="postar" type="button" value="Realizar postagem"/>
            <% } %>
            <div class="atividade">T�tulo da atividade</div>
            <% if (informacoes.isEmpty()) { %>
            <div class="vazio">
                N�o foram realizadas postagens nesta atividade.
            </div>
            <% } %>
            <% for (Informacao informacao : informacoes) { %>
            <div class="post">
                <div class="titulo"><%= informacao.getTitulo() %></div>
                <div class="data"><%= informacao.getDia() %> - <%= informacao.getHorario() %></div>
                <div class="legenda"><%= informacao.getTexto()%></div>
                <% if (isImage(informacao.getMidia())) { %>
                <div><img src="posts/<%= informacao.getMidia() %>"/></div>
                <% } else if (isVideo(informacao.getMidia())) { %>
                <div><video src="posts/<%= informacao.getMidia() %>"></video></div>
                <% } %>
            </div>
            <% } %>
        </div>
        <script>
            retornar.onclick = function () {
                window.location.href = "atividades.jsp";
            };
            postar.onclick = function () {
                window.location.href = "postar.jsp?atividade=<%= codigo %>";
            };
        </script>
    </body>
</html>