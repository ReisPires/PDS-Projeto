<%@page import="Model.*"%>

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

if (!usuario.getTipo().equals("P")) {
    request.getRequestDispatcher("atividade.jsp?codigo=" + atividade).forward(request, response);
    return;
}
    
boolean success = request.getAttribute("success") != null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Realizar Postagem</title>
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
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
                <div class="pagina pagina-centro">Realizar Postagem</div>
            </div>
		</div>
        <div class="corpo">
            <div class="container">
                <form action="postar" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="atividade" value="<%= atividade %>"/>
                    <div class="painel">
                        <label class="label" for="titulo">Título:</label>
                        <input id="titulo" name="titulo" class="campo titulo" type="text"/>
                        <label class="label" for="texto">Texto:</label>
                        <textarea id="texto" name="texto" class="campo texto"></textarea>
                        <label class="label" for="midias">Mídia:</label>
                        <input id="midias" name="midias" class="midias" type="file" multiple/>
                    </div>
                    <div class="botoes">
                        <input class="botao" type="button" value="Retornar" onclick="location.href = 'atividade.jsp?codigo=<%= atividade %>'"/>
                        <input class="botao submeter" type="submit" value="Enviar"/>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>