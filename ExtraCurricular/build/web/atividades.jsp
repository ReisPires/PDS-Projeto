<%
// Verifica se o usu�rio n�o est� logado
if (request.getSession().getAttribute("usuario") == null)
    request.getRequestDispatcher("index.jsp").forward(request, response);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Lista de Atividades</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                width: 500px;
                
                padding: 15px;
            }
            
            .lista-atividades {
                margin-bottom: 15px;
                
                border: 1px solid black;
                
                padding: 10px 0px;
            
                font-size: 25px;
                font-weight: bold;
                text-align: center;
            }
            
            table {
                width: 100%;
                
                border-collapse: collapse;
            }
            
            td {
                border: 1px solid black;
                
                width: 100%;
                
                padding: 5px 0px;
                text-align: center;
            }
            
            .data {
                color: #808080;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 15px">
                <form action="sair" method="post">
                    <input type="submit" value="Sair" style="width: 100%"/>
                </form>
            </div>
            <div class="lista-atividades">Lista de atividades</div>
            <table>
                <tr><td>
                    <div class="atividade">VII Festa Junina</div>
                    <div class="data">13/06/2017</div>
                </td></tr>
                <tr><td>
                    <div class="atividade">III Campeonato de Futebol</div>
                    <div class="data">02/04/2017</div>
                </td></tr>
            </table>
        </div>
    </body>
</html>