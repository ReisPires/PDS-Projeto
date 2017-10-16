<%@page import="Model.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario != null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

boolean incorrect = request.getAttribute("incorrect") != null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Cadastro</title>
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
            
            input[type=text], input[type=email] {
                width: 170px;
            }
            
            input[type=button], input[type=submit] {
                width: 75px;
            }
            
            #cadastrar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Cadastro
            </div>
            <% if (incorrect) { %>
            <div style="text-align: center; color: red">
                Usuário não encontrado
            </div>
            <% } %>
            <form action="cadastrar" method="post">
                <div class="grupo">
                    <div><label for="identidade">CPF ou Matrícula:</label></div>
                    <div><input id="identidade" name="identidade" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="email">E-mail:</label></div>
                    <div><input id="email" name="email" type="email"/></div>
                </div>
                <div class="grupo">
                    <div><label for="senha">Nova senha:</label></div>
                    <div><input id="senha" name="senha" type="password"/></div>
                </div>
                <div style="margin-top: 15px">
                    <input id="retornar" type="button" value="Retornar"/>
                    <input id="cadastrar" type="submit" value="Cadastrar"/>
                </div>
            </form>
        </div>
        <script>
            retornar.onclick = function () {
                window.location.href = "index.jsp";
            };
        </script>
    </body>
</html>