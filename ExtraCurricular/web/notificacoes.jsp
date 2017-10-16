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
ArrayList<Mensagem> mensagens = daoMensagem.todasMensagens();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Notificações</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                width: 500px;
                
                padding: 15px;
            }
            
            .pagina {
                margin-bottom: 15px;
                
                border: 1px solid black;
                
                padding: 10px 0px;
            
                font-size: 25px;
                font-weight: bold;
                text-align: center;
            }
            
            .vazio {
                border: 1px solid black;
                
                padding: 10px 0px;
                
                text-align: center;
            }
            
            table {
                width: 100%;
                
                border-collapse: collapse;
            }
            
            td {
                border: 1px solid black;
                
                width: 100%;
                
                text-align: center;
            }
            
            .atividade {
                display: block;
                
                padding: 5px 0px;
                
                width: 100%;
                height: 100%;
                
                text-decoration: none;
            }
            
            .texto {
                
            }
            
            .data {
                color: #808080;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <input id="retornar" type="button" value="Retornar" style="margin-bottom: 15px; width: 100%"/>
            <div class="pagina">Notificações</div>
            <% if (mensagens == null || mensagens.isEmpty()) { %>
            <div class="vazio">
                Não existem notificações.
            </div>
            <% } else {%>
            <table>
                <% for (Mensagem mensagem : mensagens) { %>
                    <tr>
                        <td>
                            <div class="texto"><%= mensagem.getTexto() %></div>
                            <div class="data"><%= mensagem.getDia() %> - <%= mensagem.getHorario() %></div>    
                        </td>
                    </tr>
                <% } %>
            </table>
            <% } %>
        </div>
        <script>
            retornar.onclick = function () {
                window.location.href = "atividades.jsp";
            };
        </script>
    </body>
</html>