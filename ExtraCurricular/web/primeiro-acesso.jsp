<%@page import="Model.*"%>

<%
    Integer errmsg = (Integer)request.getSession().getAttribute("errmsg");   
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Primeiro acesso</title>
        <link rel="stylesheet" type="text/css" href="styles/branco.css">
        <style>
            .error-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: center; 
                color: red;                             
            }
        </style>
    </head>
    <body>
        <div class="frame">
            <img src="img/SistemaLogoGrande.png"/>
            <div class="pagina">Primeiro acesso</div>
            <form class="formulario" action="entrarPrimeiroAcesso" method="post">
                    <% if (errmsg != null) { %>                        
                        <% if (errmsg == 0) { %>                        
                            <div class="error-msg">As senhas não batem</div>                        
                        <% } else { %>    
                            <div class="error-msg">Dados não encontrados</div>                       
                            <div class="error-msg">Verifique com a escola</div>                                                   
                        <% } %>    
                    <% } %>                            
                    <input class="campo" id="login" name="login" maxlength="11" type="text" placeholder="Matrícula, CPF ou Código" spellcheck="false" required>
                    <input class="campo" id="email" name="email" maxlength="80" type="email" placeholder="E-mail" spellcheck="false" required>
                    <input class="campo" id="senha" name="senha" maxlength="50" type="password" placeholder="Senha" required>
                    <input class="campo" id="confirmacao" name="confirmacao" maxlength="50" type="password" placeholder="Confirmar senha" required>
                    <div class="botoes">
                        <input type="button" value="Retornar" onclick="location.href = 'index.jsp'"/>
                        <input class="submeter" type="submit" value="Cadastrar"/>
                    </div>
            </form>
        </div>
    </body>
</html>