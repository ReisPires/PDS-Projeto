<%
// Verifica se o usuário não está logado
if (request.getSession().getAttribute("usuario") == null)
    request.getRequestDispatcher("index.jsp").forward(request, response);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Cadastro por CSV</title>
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
            
            input[type=text], input[type=password] {
                width: 170px;
            }
            
            input[type=button] {
                width: 130px;
            }
            
            #cadastrar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Cadastro por CSV
            </div>
            <div class="grupo">
                <div><label for="professores">Cadastro de professores:</label></div>
                <div><input id="professores" type="file" accept=".csv"/></div>
            </div>
            <div class="grupo">
                <div><label for="atividades">Cadastro de atividades:</label></div>
                <div><input id="atividades" type="file" accept=".csv"/></div>
            </div>
            <div class="grupo">
                <div><label for="pais-alunos">Cadastro de pais e alunos:</label></div>
                <div><input id="pais-alunos" type="file" accept=".csv"/></div>
            </div>
            <div style="margin-top: 15px">
                <input id="retornar" type="button" value="Retornar"/>
                <input id="cadastrar" type="button" value="Cadastrar"/>
            </div>
        </div>
    </body>
</html>