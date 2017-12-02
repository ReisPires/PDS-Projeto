<%@page import="java.util.ArrayList"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

String atividade = request.getParameter("atividade");
if (atividade == null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

String codigo = request.getParameter("codigo");
if (codigo == null) {
    request.getRequestDispatcher("atividade.jsp?codigo=" + atividade).forward(request, response);
    return;
}


%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Editar Postagem</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <style>
            .titulo {
                height: 28px;
            }
            
            .texto {
                height: 160px;
            }
            
            .midias {
                font-size: 16.667px;
                font-family: "Segoe UI";
                color: rgb(85, 85, 85);
                line-height: 1.2;
            }
        </style>
    </head>
    <body>
		<div class="cabecalho">
            <div class="container">
                <img class="logo" src="img/SistemaLogo.png"/>
                <div class="pagina pagina-centro">Editar Postagem</div>
            </div>
		</div>
        <div class="corpo">
            <div class="container">
                <form action="atividade.jsp" method="post">
                    <div class="painel">
                        <label class="label" for="titulo">Título:</label>
                        <input id="titulo" class="campo titulo" type="text"/>
                        <label class="label" for="texto">Texto:</label>
                        <textarea id="texto" class="campo texto"></textarea>
                        <label class="label" for="midia">Mídia:</label>
                        <input class="midias" type="file" multiple/>
                    </div>
                    <div class="botoes">
                        <input class="botao" type="button" value="Retornar" onclick="location.href = 'atividade.jsp'"/>
                        <input class="botao submeter" type="submit" value="Enviar"/>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>