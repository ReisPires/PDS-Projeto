<%
boolean incorrect = request.getAttribute("incorrect") != null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Busca de registro</title>
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
            
            input[type=button] {
                width: 75px;
            }
            
            #buscar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Busca de registro
            </div>
            <% if (incorrect) { %>
            <div style="text-align: center; color: red">
                Usuário não encontrado
            </div>
            <% } %>
            <form action="buscar" method="post">
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
                    <input id="buscar" type="submit" value="Buscar"/>
                </div>
            </form>
        </div>
    </body>
</html>