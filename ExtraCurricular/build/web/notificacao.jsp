<%
// Verifica se o usu�rio n�o est� logado
if (request.getSession().getAttribute("usuario") == null)
    request.getRequestDispatcher("index.jsp").forward(request, response);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Envio de notificação</title>
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
            
            input[type=button] {
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
            <div class="grupo">
                <div><label for="destino">Destinatário:</label></div>
                <div><input id="destino" type="text"/></div>
            </div>
            <div class="grupo">
                <div><label for="texto">Texto:</label></div>
                <div><textarea id="texto"></textarea></div>
            </div>
            <div style="margin-top: 15px">
                <input id="retornar" type="button" value="Retornar"/>
                <input id="enviar" type="button" value="Enviar"/>
            </div>
        </div>
    </body>
</html>