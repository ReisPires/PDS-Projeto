<%@page import="Model.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

if (!usuario.getTipo().equals("E")) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

boolean success = (boolean)request.getAttribute("success");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Envio de notificação</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                padding: 15px;
            }
            
            .grupo {
                margin-bottom: 5px;
            }
            
            input[type=text], input[type=file], textarea {
                width: 260px;
            }
            
            #texto {
                height: 100px;
            
                resize: none;
            }
            
            input[type=button],input[type=submit] {
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
                Envio de notificação
            </div>
            <% if (success) { %>
            <div style="text-align: center; color: green">
                Notificação enviada com sucesso
            </div>
            <% } %>
            <form action="notificar" method="post">
                <div class="grupo">
                    <div><label for="texto">Texto:</label></div>
                    <div><textarea id="texto" name="texto"></textarea></div>
                </div>
                <div style="margin-top: 15px">
                    <input id="retornar" type="button" value="Retornar" onclick="window.location.href = 'atividades.jsp'"/>
                    <input id="enviar" type="submit" value="Enviar"/>
                </div>
            </form>
        </div>
    </body>
</html>