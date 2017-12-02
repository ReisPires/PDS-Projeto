<% request.getSession().setAttribute("resultadoCadastro", null); %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Atividades</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <style>
            .painel {
                padding-top: 8px;
                padding-bottom: 12px;
                
                text-align: center;
                
                text-decoration: none;
                
                font-size: 41.667px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
        </style>
    </head>
    <body>
	<div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
		<span class="pagina pagina-centro">Cadastros</span>
            </div>
	</div>
        <div class="corpo">
            <div class="container">
                <div class="atividades">
                    <a class="painel" href="cadastro-professor.jsp">Cadastro de professor</a>
                    <a class="painel" href="cadastro-responsavel.jsp">Cadastro de responsável</a>
                    <a class="painel" href="cadastro-aluno.jsp">Cadastro de aluno</a>
                    <a class="painel" href="cadastro-csv.jsp">Cadastro por csv</a>
                </div>
            </div>
        </div>
    </body>
</html>