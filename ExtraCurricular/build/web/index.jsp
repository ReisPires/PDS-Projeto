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
        <title>ExtraCurricular - Login</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                padding: 15px;
            }
            
            form {
                margin: 0px;
            }
            
            .grupo {
                margin-bottom: 5px;
            }
            
            input[type=text], input[type=password] {
                width: 170px;
            }
            
            input[type=submit], input[type=button] {
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
                Sistema
            </div>
            <% if (incorrect) { %>
            <div style="text-align: center; color: red">
                Usuário ou senha incorretos
            </div>
            <% } %>
            <form action="entrar" method="post">
                <div class="grupo">
                    <div><label for="usuario">Login:</label></div>
                    <div><input id="login" name="login" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="senha">Senha:</label></div>
                    <div><input id="senha" name="senha" type="password"/></div>
                </div>
                <div style="margin-top: 15px">
                    <input id="entrar" type="submit" value="Entrar"/>
                    <input id="cadastrar" type="button" value="Cadastrar" onclick="window.location.href = 'cadastro.jsp'"/>
                </div>
            </form>
        </div>
    </body>
</html>