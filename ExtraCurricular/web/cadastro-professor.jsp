<%
boolean successNotNull = request.getAttribute("success") != null;
boolean success = false;
if (successNotNull) 
     success = (boolean)request.getAttribute("success");
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
                Cadastro de professor
            </div>
            <form action="cadastrarProfessor" method="post">
                <% if (successNotNull && success) { %>
                <div style="text-align: center; color: green">
                    Cadastro realizado com sucesso
                </div>
                <% } else if (successNotNull) { %>
                <div style="text-align: center; color: red">
                    Houve um problema com o cadastro
                </div>
                <% } %>
                <div class="grupo">
                    <div><label for="nome">Nome:</label></div>
                    <div><input id="nome" name="nome" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="codigo">Código:</label></div>
                    <div><input id="codigo" name="codigo" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="email">E-mail:</label></div>
                    <div><input id="email" name="email" type="email"/></div>
                </div>
                <div class="grupo">
                    <div><label for="senha">Senha:</label></div>
                    <div><input id="senha" name="senha" type="password"/></div>
                </div>
                <div class="grupo">
                    
                </div>
                <div style="margin-top: 15px">
                    <input id="retornar" type="button" value="Retornar" onclick="window.location.href = 'index.jsp'"/>
                    <input id="cadastrar" type="submit" value="Cadastrar"/>
                </div>
            </form>
        </div>
    </body>
</html>