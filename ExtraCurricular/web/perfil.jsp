<%@page import="Model.*"%>

<%    
    DadosPessoais dadosPessoais = (DadosPessoais)request.getSession().getAttribute("dadosPessoais");
    String facebookId = (String)request.getSession().getAttribute("facebookId");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Perfil</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <style>
            .titulo {
                font-size: 29px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .label {
                float: left;
                font-size: 20px;
                margin-right: 10px;                                
                margin-top: 5px; 
            }
            
            .campo {
                margin-top: 5px;
                margin-bottom: 3px;
                margin-right: 12px;
                font-size: 20px;
                float: left;
            }
            
            .radiolabel {
                font-family: "Segoe UI";                
                margin-top: 3px; 
                margin-right: 15px;
                font-size: 20px;                
                color: rgb(71, 70, 70);
                float: left;                
            }
            
            radio {                
                margin-top: 100px;                 
            }   
            
            .error-msg {
                font-size: 22px;
                font-family: "Segoe UI";
                text-align: left; 
                color: red;                             
                margin-right: 30px;                
            }

            .success-msg {
                font-size: 22px;
                font-family: "Segoe UI";
                text-align: left; 
                color: green;   
                margin-right: 30px;                
            }
        </style>
    </head>
    <body>
        <div id="fb-root"></div>
        <script>(function(d, s, id) {
          var js, fjs = d.getElementsByTagName(s)[0];
          if (d.getElementById(id)) return;
          js = d.createElement(s); js.id = id;
          js.src = 'https://connect.facebook.net/pt_BR/sdk.js#xfbml=1&version=v2.11&appId=690889244441145';
          fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk')); 
        
            function onLogin() {
                FB.getLoginStatus(function(response) {
                    if (response.status === 'connected')
                        document.getElementById('fbid').value = FB.getUserID();
                    else
                        document.getElementById('fbid').value = "";
                });
            }                        
        </script>
                 
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>   
                <div class="pagina pagina-centro">Perfil</div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel">                                       
                        <form class="formulario" action="atualizarDados" method="post">                                                                                    
                            <label class="label" for="email" style="width: 668px">E-mail</label>                            
                            <label class="label" for="telefone">Telefone</label>
                            
                            <br style="clear:both" />                            
                            
                            <input class="campo" id="email" name="email" maxlength="80" style="width: 668px" type="email" spellcheck="false" value="<%= dadosPessoais.getEmail() == null ? "" : dadosPessoais.getEmail()%>" required>                            
                            <input class="campo" id="telefone" name="telefone" maxlength="14" style="width: 275px" type="text" value="<%= dadosPessoais.getTelefone()== null ? "" : dadosPessoais.getTelefone()%>" spellcheck="false"> 
                            
                            <br style="clear:both" />
                                                        
                            <label class="label" for="gender" style="width: 244px">Sexo</label>
                            <label class="label" for="pais" style="width: 280px">País</label>
                            <label class="label" for="cep" style="width: 120px">CEP</label>                            
                            <label class="label" for="estado">Estado</label>
                            
                            <br style="clear:both" />
                                   
                            <% if (dadosPessoais.getSexo().equals("M")) { %>
                                <label class="radiolabel"><input type="radio" id="masc" name="sexo" value="masc" checked>   Masculino</label>
                                <label class="radiolabel"><input type="radio" id="fem" name="sexo" value="fem">   Feminino</label>                            
                            <% } else if (dadosPessoais.getSexo().equals("F")) { %>
                                <label class="radiolabel"><input type="radio" id="masc" name="sexo" value="masc">   Masculino</label>
                                <label class="radiolabel"><input type="radio" id="fem" name="sexo" value="fem" checked>   Feminino</label>                            
                            <% } else { %>
                                <label class="radiolabel"><input type="radio" id="masc" name="sexo" value="masc">   Masculino</label>
                                <label class="radiolabel"><input type="radio" id="fem" name="sexo" value="fem">   Feminino</label>                            
                            <% } %>
                            
                            <input class="campo" id="pais" name="pais" maxlength="50" style="width: 280px" type="text" value="<%= dadosPessoais.getEndereco().getPais() == null ? "" : dadosPessoais.getEndereco().getPais() %>" spellcheck="false">                                                        
                            <input class="campo" id="cep" name="cep" maxlength="10" style="width: 120px" type="text" value="<%= dadosPessoais.getEndereco().getCep() == null ? "" : dadosPessoais.getEndereco().getCep()%>" spellcheck="false">                         
                            <input class="campo" id="estado" name="estado" maxlength="50" style="width: 277px" type="text" value="<%= dadosPessoais.getEndereco().getEstado() == null ? "" : dadosPessoais.getEndereco().getEstado()%>" spellcheck="false"> 
                            
                            <br style="clear:both" />                                                                                                                                                                                                    
                                                                                    
                            <label class="label" for="cidade" style="width: 472px">Cidade</label>
                            <label class="label" for="bairro">Bairro</label>                            
                            
                            <br style="clear:both" />
                            
                            <input class="campo" id="cidade" name="cidade" maxlength="50" style="width: 472px" type="text" value="<%= dadosPessoais.getEndereco().getCidade() == null ? "" : dadosPessoais.getEndereco().getCidade() %>" spellcheck="false">                         
                            <input class="campo" id="bairro" name="bairro" maxlength="50" style="width: 472px" type="text" value="<%= dadosPessoais.getEndereco().getBairro() == null ? "" : dadosPessoais.getEndereco().getBairro() %>" spellcheck="false">                         
                            
                            <br style="clear:both" />
                            
                            <label class="label" for="rua" style="width: 475px">Rua</label>
                            <label class="label" for="numero" style="width: 80px">Nº</label>
                            <label class="label" for="complemento">Complemento</label>                                                                                    
                            
                            <br style="clear:both" />
                            
                            <input class="campo" id="rua" name="rua" maxlength="100" style="width: 472px" type="text" value="<%= dadosPessoais.getEndereco().getRua()== null ? "" : dadosPessoais.getEndereco().getRua() %>" spellcheck="false">                         
                            <input class="campo" id="numero" name="numero" maxlength="6" style="width: 80px" type="text" value="<%= dadosPessoais.getEndereco().getNumero() == null ? "" : dadosPessoais.getEndereco().getNumero() %>" spellcheck="false"> 
                            <input class="campo" id="complemento" name="complemento" maxlength="80" style="width: 380px" type="text" value="<%= dadosPessoais.getEndereco().getComplemento() == null ? "" : dadosPessoais.getEndereco().getComplemento() %>" spellcheck="false">   
                                                        
                            <br style="clear:both" />
                            
                            <label class="label" style="margin-bottom: 5px">Facebook</label>                                                   
                            <br style="clear:both" />
                            <% if (facebookId == null) { %>                                                                                                 
                                <div class="fb-login-button" data-width="220" data-max-rows="1" data-size="medium" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false" onlogin="onLogin()"></div>                                    
                            <% } else { %>                                   
                                <div class="fb-login-button" data-width="220" data-max-rows="1" data-size="medium" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="true" data-use-continue-as="false" onlogin="onLogin()"></div>                                
                            <% } %>              
                            <input id="fbid" name="fbid" type="hidden" value="<%= facebookId %>"/>
                            <div class="botoes" style="clean: both">                                    
                                <input class="botao" type="button" value="Retornar" onclick="location.href = 'cadastros.jsp'"/>
                                <input class="botao submeter" type="submit" value="Salvar"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>