<%
// Verifica se o usu·rio n„o est· logado
if (request.getSession().getAttribute("usuario") == null)
    request.getRequestDispatcher("index.jsp").forward(request, response);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Tela de Atividade</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            #retornar {
                display: block;
                
                margin-bottom: 15px;
                
                width: 100%;
                
                padding: 5px 0px;
                
                font-size: 15px;
            }
            
            .atividade {
                margin-bottom: 15px;
            
                border: 1px solid black;
                
                padding: 10px 0px;
            
                font-size: 25px;
                font-weight: bold;
                text-align: center;
            }
            
            .post {
                margin-top: 10px;
                
                border: 1px solid black;
                
                padding: 10px;
            }
            
            .titulo {
                font-weight: bold;
            }
            
            .data {
                color: #a0a0a0;
                margin-bottom: 8px;
            }
            
            .legenda {
                margin-bottom: 4px;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <input id="retornar" type="button" value="Retornar √† lista de atividades"/>
            <div class="atividade">VII Festa Junina</div>
            <div class="post">
                <div class="titulo">Adicione um t√≠tulo aqui</div>
                <div class="data">13/06/2017 - 21:07</div>
                <div class="legenda">In√≠cio da VII Festa Junina</div>
                <div><img src="posts/foto-2.jpg"/></div>
            </div>
            <div class="post">
                <div class="titulo">Adicione um t√≠tulo aqui</div>
                <div class="data">13/06/2017 - 15:49</div>
                <div class="legenda">Treinamento do caracol para a VII Festa Junina</div>
                <div><img src="posts/foto-1.jpg"/></div>
            </div>
        </div>
    </body>
</html>