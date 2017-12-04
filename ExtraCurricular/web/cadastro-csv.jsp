<%@page import="Model.*"%>

<%
RelatorioCadastroCSV relatorio = (RelatorioCadastroCSV)request.getSession().getAttribute("relatorioCadastroCSV");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Cadastro por CSV</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <style>
            .titulo {
                font-size: 29px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .label {                
                font-size: 25px;
                margin-right: 10px;                                
                margin-top: 5px; 
            }
            
            .campo {
                margin-top: 5px;
                margin-bottom: 10px;                
                font-size: 18px;   
                border-style: none;
            } 
            
            .error-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: right; 
                color: red;                             
            }
            
            .success-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: right; 
                color: green;                             
            }
        </style>
    </head>
    <body>
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>   
                <div class="pagina pagina-centro" style="font-size:44px">Cadastro por CSV</div>
            </div>
        </div> 
	<div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel" style="margin: 0 auto; width: 570px">                         
                        <form class="formulario" action="cadastrarCSV" method="post" enctype="multipart/form-data">
                            <% if (relatorio != null) { %>
                                <% if (relatorio.successProfessor > 0) { %>                        
                                    <div class="success-msg"><% out.print(relatorio.successProfessor); %> professores cadastrados com sucesso</div>
                                <% } if (relatorio.errorProfessor > 0) { %>
                                    <div class="error-msg"><% out.print(relatorio.errorProfessor); %> professores com erro no cadastro</div>
                                <% } if (relatorio.successAluno > 0) { %>                        
                                    <div class="success-msg"><% out.print(relatorio.successAluno); %> alunos cadastrados com sucesso</div>
                                <% } if (relatorio.errorAluno > 0) { %>
                                    <div class="error-msg"><% out.print(relatorio.errorAluno); %> alunos com erro no cadastro</div>
                                <% } if (relatorio.successResponsavel > 0) { %>                        
                                    <div class="success-msg"><% out.print(relatorio.successResponsavel); %> responsáveis cadastrados com sucesso</div>
                                <% } if (relatorio.errorResponsavel > 0) { %>
                                    <div class="error-msg"><% out.print(relatorio.errorResponsavel); %> responsáveis com erro no cadastro</div>
                                <% } if (relatorio.successAtividade > 0) { %>                        
                                    <div class="success-msg"><% out.print(relatorio.successAtividade); %> atividades cadastrados com sucesso</div>
                                <% } if (relatorio.errorAtividade > 0) { %>
                                    <div class="error-msg"><% out.print(relatorio.errorAtividade); %> atividades com erro no cadastro</div>
                                  <% } %>
                            <% } %>
                            <div class="grupo">
                                <label class="label" for="professores">Cadastro de Professores:</label>
                                <input class="campo" id="professores" name="professores" type="file" accept=".csv"/>
                            </div>
                            <div class="grupo">
                                <label class="label" for="responsaveis-alunos">Cadastro de Responsáveis e Alunos:</label>
                                <input class="campo" id="responsaveis-alunos" name="responsaveis-alunos" type="file" accept=".csv"/>
                            </div>
                            <div class="grupo">
                                <label class="label" for="atividades">Cadastro de Atividades:</label>
                                <input class="campo" id="atividades" name="atividades" type="file" accept=".csv"/>
                            </div>
                            <div class="botoes">
                                <input class="botao" type="button" value="Retornar" onclick="location.href = 'cadastros.jsp'"/>
                                <input class="botao submeter" type="submit" value="Cadastrar"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
	</div>
    </body>
</html>