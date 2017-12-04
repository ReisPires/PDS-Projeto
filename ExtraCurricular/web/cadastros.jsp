<% 
    request.getSession().setAttribute("resultadoCadastro", null); 
    request.getSession().setAttribute("relatorioCadastroCSV", null);
%>

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
                
                font-size: 35px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
                
                height: 62px;
                width: 420px;
                float: left;
                margin-right: 15px;
            }
            
            .icone {
                float: left; 
                height: 62px; 
                width: 62px; 
                margin-right: 10px;
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
                    <img class="icone" src="img/IconAdmin.png" />
                    <a class="painel" href="cadastro-administrador.jsp">Administrador</a>                    
                    <a class="painel" href="cadastro-aluno.jsp">Aluno</a>
                    <img class="icone" src="img/IconUsuarioBranco.png" />
                    
                    <br style="clear:both" />
                    
                    <img class="icone" src="img/Professor.png" />                    
                    <a class="painel" href="cadastro-professor.jsp">Professor</a>                                       
                    <a class="painel" href="cadastro-responsavel.jsp">Responsável</a>                
                    <img class="icone" src="img/Responsavel.png" />
                    
                    <br style="clear:both" />
                    
                    <img class="icone" src="img/Atividades.png" />
                    <a class="painel" href="cadastro-atividade.jsp">Atividade</a>                    
                    <a class="painel" href="cadastro-csv.jsp">CSV</a>            
                    <img class="icone" src="img/CSV.png" />
                </div>
            </div>
        </div>
    </body>
</html>