<%@page import="Model.*"%>

<%
RelatorioCadastroCSV relatorio = (RelatorioCadastroCSV)request.getSession().getAttribute("relatorioCadastroCSV");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Cadastro por CSV</title>
        <link rel="stylesheet" type="text/css" href="styles/branco.css">
        <style>
            .error-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: left; 
                color: red;                             
            }
            
            .success-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: left; 
                color: green;                             
            }
        </style>
    </head>
    <body>
	<div class="frame">
            <img src="img/SistemaLogoGrande.png"/>
            <div class="pagina">Cadastro por CSV</div>
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
                    <label for="professores">Cadastro de Professores:</label>
                    <input id="professores" name="professores" type="file" accept=".csv"/>
                </div>
                <div class="grupo">
                    <label for="responsaveis-alunos">Cadastro de Responsáveis e Alunos:</label>
                    <input id="responsaveis-alunos" name="responsaveis-alunos" type="file" accept=".csv"/>
                </div>
                <div class="grupo">
                    <label for="atividades">Cadastro de Atividades:</label>
                    <input id="atividades" name="atividades" type="file" accept=".csv"/>
                </div>
                <div class="botoes">
                    <input type="button" value="Retornar" onclick="location.href = 'atividades.jsp'"/>
                    <input class="submeter" type="submit" value="Cadastrar"/>
                </div>
            </form>
	</div>
    </body>
</html>