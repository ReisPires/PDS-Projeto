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

boolean success = request.getAttribute("success") != null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Cadastro por CSV</title>
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
            
            input[type=button], input[type=submit] {
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
            <% if (success) { %>
            <div style="text-align: center; color: green">
                Cadastro realizado com sucesso.
            </div>
            <% } %>
            <form action="csv" method="post" enctype="multipart/form-data">
                <div class="grupo">
                    <div><label for="professores">Cadastro de professores:</label></div>
                    <div><input id="professores" name="professores" type="file" accept=".csv"/></div>
                </div>
                <div class="grupo">
                    <div><label for="pais-alunos">Cadastro de pais e alunos:</label></div>
                    <div><input id="pais-alunos" name="pais-alunos" type="file" accept=".csv"/></div>
                </div>
                <div class="grupo">
                    <div><label for="atividades">Cadastro de atividades:</label></div>
                    <div><input id="atividades" name="atividades" type="file" accept=".csv"/></div>
                </div>                
                <div style="margin-top: 15px">
                    <input id="retornar" type="button" value="Retornar" onclick="window.location.href = 'atividades.jsp'"/>
                    <input id="cadastrar" type="submit" value="Cadastrar"/>
                </div>
            </form>
        </div>
    </body>
</html>