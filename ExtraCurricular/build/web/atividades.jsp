    <%@page import="java.util.ArrayList"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

DAOAtividade daoAtividade = new DAOAtividade();
ArrayList<Atividade> listaAtividades = daoAtividade.listaAtividades(usuario);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Atividades</title>
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
            
            .titulo {
                
            }
            
            .data {
                color: #808080;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="margin-bottom: 15px">
                <form action="sair" method="post">
                    <input type="submit" value="Sair" style="width: 100%"/>
                </form>
            </div>
            <% if (usuario.getTipo().equals("E")) { %>
            <input id="csv" type="button" value="Cadastrar por CSV" style="margin-bottom: 15px; width: 100%"/>
            <input id="notificacao" type="button" value="Enviar notificação" style="margin-bottom: 15px; width: 100%"/>
            <% } %>
            <input id="notificacoes" type="button" value="Ver notificações" style="margin-bottom: 15px; width: 100%"/>
            <div class="pagina">Lista de atividades</div>
            <% if (listaAtividades.isEmpty()) { %>
            <div class="vazio">
                Não existem atividades cadastradas
            </div>
            <% } %>
            <table>
                <% for (Atividade atividade : listaAtividades) { %>
                    <tr>
                        <td>
                            <a class="atividade" href="atividade.jsp?codigo=<%= atividade.getCodigo() %>">
                                <div class="titulo"><%= atividade.getNome() %></div>                                    
                            </a>
                        </td>
                    </tr>
                <% } %>
            </table>
        </div>
        <script>
            csv.onclick = function () {
                window.location.href = "csv.jsp";
            };
            notificacao.onclick = function () {
                window.location.href = "notificacao.jsp";
            };
            notificacoes.onclick = function () {
                window.location.href = "notificacoes.jsp";
            };
        </script>
    </body>
</html>