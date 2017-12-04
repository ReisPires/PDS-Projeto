<%@page import="Model.*"%>

<%
request.getSession().setAttribute("errmsg", null);
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario != null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

boolean incorrect = request.getAttribute("incorrect") != null;
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Login</title>
        <link rel="stylesheet" type="text/css" href="styles/branco.css">
        <style>
            .facebook {
                    margin-top: 10px;
            }

            .primeiro-acesso {
                display: block;

                clear: both;

                margin-top: 15px;    

                text-align: center;
                text-decoration: none;
                font-size: 18px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);  
            }

            .ouline {
                line-height: 1.5;
                text-align: center;
                margin: auto;
            }

            .straightline {
                display: block;
                height: 1px;
                border: 0;
                border-top: 1px solid #ccc;
                margin: 1em 0;
                padding: 0;
                width: 43%;
                float: left;
            }

            .ou {
                font-size: 18px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);   
                width: 14%;     
                float: left;
            }
            
            .error-msg {
                font-size: 18px;
                font-family: "Segoe UI";
                text-align: center; 
                color: red;                             
            }
        </style>
    </head>
    <body>
        <div id="fb-root"></div>
        <script>
            (function(d, s, id) {
              var js, fjs = d.getElementsByTagName(s)[0];
              if (d.getElementById(id)) return;
              js = d.createElement(s); js.id = id;
              js.src = 'https://connect.facebook.net/pt_BR/sdk.js#xfbml=1&version=v2.11&appId=690889244441145';
              fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
            
            function onLogin() {
                FB.getLoginStatus(function(response) {
                    if (response.status === 'connected')
                        location.href = "entrar?id=" + FB.getUserID();
                });
            }
        </script>
        
        <div class="frame">
        	<div>
            	<img src="img/SistemaLogoGrande.png"/>            
            </div>
            <form class="formulario" action="entrar" method="post">
                <div class="fb-login-button" data-width="260" data-max-rows="1" data-size="medium" data-button-type="login_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false" onlogin="onLogin()"></div>          	
            	<div class="ouline">        
            		<div class="straightline"></div>
            		<div class="ou">ou</div>
            		<div class="straightline"></div>
            	</div>
                <% if (incorrect) { %>
                    <div class="error-msg">Usuário ou senha incorretos!</div>
                <% } %>
                <input id="login" name="login" class="campo" type="text" placeholder="Usuário" spellcheck="false"/>
                <input id="senha" name="senha" class="campo" type="password" placeholder="Senha"/>
                <div class="botoes">
                    <input class="submeter" style="width: 100%" type="submit" value="Entrar"/>                    
                </div>     
                <a class="primeiro-acesso" href='primeiro-acesso.jsp'>É seu primeiro acesso?</a>
            </form>
        </div>
    </body>
</html>