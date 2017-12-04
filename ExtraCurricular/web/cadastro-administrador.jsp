<%@page import="Model.*"%>

<%    
    Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
    if (usuario == null || !usuario.getTipo().equals("E")) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }
    
    Integer resultadoCadastro = (Integer)request.getSession().getAttribute("resultadoCadastro");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Cadastro de Administrador</title>
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
                <div class="pagina pagina-centro" style="font-size:44px">Cadastro de Administrador</div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel" style="margin: 0 auto; width: 570px">                                       
                        <form class="formulario" action="cadastrarAdmin" method="post">                                                                                    
                            <label class="label" for="username">Nome de usuário</label>                            
                            <input class="campo" id="username" name="username" maxlength="11" style="width: 514px" type="text" value="" required>                           
                            
                            <label class="label" for="email">E-mail</label>                            
                            <input class="campo" id="email" name="email" maxlength="80" style="width: 514px" type="email" value="" required>                           
                            
                            <label class="label" for="senha">Senha</label>
                            <input class="campo" id="senha" name="senha" maxlength="50" style="width: 514px" type="password" value="" required> 
                            
                            <label class="label" for="confirmacao">Confirmação de senha</label>
                            <input class="campo" id="confirmacao" name="confirmacao" maxlength="50" style="width: 514px" type="password" value="" required>                            
                                                       
                            <div class="botoes" style="clean: both">    
                                <% if (resultadoCadastro != null) { %>
                                    <% if (resultadoCadastro == 0) { %>                                        
                                        <label class="success-msg">Admnistrador cadastrado com sucesso</label>                                        
                                    <% } else if (resultadoCadastro == 14) { %>
                                        <label class="error-msg">Erro: usuário já cadastrado</label>                                    
                                    <% } else if (resultadoCadastro == 15) { %>
                                        <label class="error-msg">Erro: e-mail já cadastrado</label>
                                    <% } else if (resultadoCadastro == 39) { %>
                                        <label class="error-msg">Erro: senhas não batem</label>                                           
                                    <% } %>
                                <% } %>
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