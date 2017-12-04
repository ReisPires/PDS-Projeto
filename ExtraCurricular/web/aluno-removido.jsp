<% 
    String nome = (String)request.getSession().getAttribute("nomeRemovido");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Aluno Removido</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">                
        <style>
            .titulo {
                font-size: 29px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
                                                                                                   
            .retornar {
                position: fixed;
                
                right: 30px;
                bottom: 30px;
            }                        
        </style>
    </head>
    <body>
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>   
                <div class="pagina pagina-centro"><%= nome %></div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame" style="text-align: center">
                    <div class="painel" style="margin: 0 auto; width: 600px; text-align: center">                                       
                        <div class="titulo">Usuário removido com sucesso</div>                        
                    </div> 
                </div>
            </div>
        </div>
        <input class="botao retornar" type="button" value="Retornar" onclick="location.href = 'atividades.jsp'"/>
    </body>
</html>
      