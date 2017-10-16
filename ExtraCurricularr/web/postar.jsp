<%@page import="Model.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

String atividade = request.getParameter("atividade");
if (atividade == null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

if (!usuario.getTipo().equals("P")) {
    request.getRequestDispatcher("atividade.jsp?codigo=" + atividade).forward(request, response);
    return;
}
    
boolean success = request.getAttribute("success") != null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Realizar postagem</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                padding: 15px;
                
                width: 315px;
            }
            
            form {
                margin: 0px;
            }
            
            .grupo {
                margin-bottom: 5px;
            }
            
            input[type=text], input[type=file], textarea {
                width: 100%;
            }
            
            #texto {
                height: 100px;
            
                resize: none;
            }
            
            input[type=button], input[type=submit] {
                width: 120px;
            }
            
            #enviar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Realizar postagem
            </div>
            <% if (success) { %>
            <div style="text-align: center; color: green">
                Postagem realizada com sucesso
            </div>
            <% } %>
            <form action="postar" method="post" enctype="multipart/form-data">
                <input type="hidden" name="professor" value="<%= usuario.getId() %>"/>
                <input type="hidden" name="atividade" value="<%= atividade %>"/>
                <div class="grupo">
                    <div><label for="titulo">Título:</label></div>
                    <div><input id="titulo" name="titulo" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="texto">Texto:</label></div>
                    <div><textarea id="texto" name="texto"></textarea></div>
                </div>
                <div class="grupo">
                    <div><label for="midia">Mídia:</label></div>
                    <div><input id="midia" name="midia" type="file" accept="image/*, video/*"/></div>
                </div>
                <div style="margin-top: 15px">
                    <input id="retornar" type="button" value="Retornar"/>
                    <input id="enviar" type="submit" value="Enviar"/>
                </div>
            </form>
        </div>
        <script>
            retornar.onclick = function () {
                window.location.href = "atividade.jsp?codigo=<%= atividade %>";
            };
        </script>
    </body>
</html>