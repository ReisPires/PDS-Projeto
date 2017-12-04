<%@page import="java.util.ListIterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

DAOMensagem daoMensagem = new DAOMensagem();
daoMensagem.leMensagens(usuario);

ArrayList<Mensagem> mensagens = daoMensagem.listaMensagens(usuario);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Mensagens</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <style>
            .menu {
                position: absolute;
                
                right: 10px;
                bottom: 5px;
            }
            
            .opcao {
                display: inline-block;
    
                line-height: 1.1;
                font-size: 14px;
                color: #707070;
            }
            
            .opcao:not(:first-child) {
                margin-left: 10px;
            }
            
            .frame {
                display: inline-block;
                
                width: 768px;
            }
        
            .titulo {
                font-size: 29px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .data {
                font-size: 21px;
                font-family: "Segoe UI";
                color: rgb(111, 110, 110);
                line-height: 1.2;
            }
            
            .texto {
                margin-top: 10px;
                
                text-align: left;
            
                font-size: 14.583px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .retornar {
                position: fixed;
                
                right: 30px;
                bottom: 30px;
            }
        </style>
    </head>
    <body>
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
                <span class="pagina pagina-centro">Mensagens</span>
                <div class="menu">
                    <a class="opcao" href="nova-mensagem.jsp">
                        <img src="img/NovaMensagemIcone.png"/>
                        <div>Nova mensagem</div>
                    </a>
                </div>
            </div>
        </div>
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <% for (ListIterator i = mensagens.listIterator(mensagens.size()); i.hasPrevious();) { %>
                        <% Mensagem mensagem = (Mensagem)i.previous(); %>
                    <div class="painel">
                        <div class="autor">Enviado por <%= mensagem.getNomeRemetente() == null ? "Escola" : mensagem.getNomeRemetente() %></div>
                        <div class="titulo"><%= mensagem.getTitulo() %></div>
                        <div class="data"><%= mensagem.getDia() %> - <%= mensagem.getHorario() %></div>
                        <div class="texto"><%= mensagem.getTexto() %></div>
                    </div>
                    <% } %>
                </div>
            </div>
        </div>
        <input class="botao retornar" type="button" value="Retornar" onclick="location.href = 'atividades.jsp'"/>
    </body>
</html>