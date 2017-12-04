<%@page import="Model.*"%>

<%    
    Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
    if (usuario == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }
    
    Integer resultadoMudancaSenha = (Integer)request.getSession().getAttribute("resultadoMudancaSenha");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Mudança de senha</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <style>
            .titulo {
                font-size: 29px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .label {                
                font-size: 20px;
                margin-right: 10px;                                
                margin-top: 5px; 
            }
            
            .campo {
                margin-top: 5px;
                margin-bottom: 3px;                
                font-size: 20px;                
            }                           
            
            .error-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: left; 
                color: red;                             
                margin-right: 15px;                
            }

            .success-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: left; 
                color: green;   
                margin-right: 15px;                
            }                        
        </style>
    </head>
    <body>                         
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>   
                <div class="pagina pagina-centro">Mudança de senha</div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel" style="margin: 0 auto; width: 570px">                                       
                        <form class="formulario" action="atualizarSenha" method="post">                                                                                    
                            <label class="label" for="antiga">Senha antiga</label>                            
                            <input class="campo" id="antiga" name="antiga" maxlength="50" style="width: 514px" type="password" value="" required>                           
                            
                            <label class="label" for="nova">Nova senha</label>
                            <input class="campo" id="nova" name="nova" maxlength="50" style="width: 514px" type="password" value="" required> 
                            
                            <label class="label" for="confirmacao">Confirmação da nova senha</label>
                            <input class="campo" id="confirmacao" name="confirmacao" maxlength="50" style="width: 514px" type="password" value="" required>                            
                                                       
                            <div class="botoes" style="clean: both">    
                                <% if (resultadoMudancaSenha != null) { %>
                                    <% if (resultadoMudancaSenha == 0) { %>                                        
                                        <label class="success-msg">Senha alterada com sucesso</label>                                        
                                    <% } else if (resultadoMudancaSenha == 37) { %>
                                        <label class="error-msg">Erro: senha antiga incorreta</label>                                    
                                    <% } else if (resultadoMudancaSenha == 38) { %>
                                        <label class="error-msg">Erro: senha nova inválida</label>
                                    <% } else if (resultadoMudancaSenha == 39) { %>
                                        <label class="error-msg">Erro: senhas não batem</label>                                           
                                    <% } %>
                                <% } %>
                                <input class="botao" type="button" value="Retornar" onclick="location.href = 'perfil.jsp'"/>
                                <input class="botao submeter" type="submit" value="Mudar"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>