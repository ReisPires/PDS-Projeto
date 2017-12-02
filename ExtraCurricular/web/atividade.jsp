<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ListIterator"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%!
boolean isImage(String fileName) {
    if (fileName == null)
        return false;
    
    String extension = fileName.substring(fileName.lastIndexOf('.'));
    
    return ".png".equals(extension) || ".jpg".equals(extension) || ".bmp".equals(extension);
}

boolean isVideo(String fileName) {
    if (fileName == null)
        return false;
    
    String extension = fileName.substring(fileName.lastIndexOf('.'));
    
    return ".mp4".equals(extension) || ".avi".equals(extension) || ".wmv".equals(extension);
}

boolean isAudio(String fileName) {
    if (fileName == null)
        return false;
    
    String extension = fileName.substring(fileName.lastIndexOf('.'));
    
    return ".mp3".equals(extension) || ".wav".equals(extension);
}
%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

String codigo = request.getParameter("codigo");
if (codigo == null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

DAOAtividade daoAtividade = new DAOAtividade();
Atividade atividade = new Atividade(codigo, "");
daoAtividade.recuperaAtividade(atividade);

ArrayList<Postagem> postagens = daoAtividade.listaPostagens(atividade);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Atividade</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <script src="scripts/atividade.js"></script>
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
            
            .busca {
                width: 50%;
                
                font-size: 18px;
            }
            
            .frame {
                display: inline-block;
                
                width: 768px;
            }
        
            .postagens {
                margin-top: 20px;
            }
            
            .editar {
                float: right;
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
            
                font-size: 14.583px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .nenhum {
                margin-top: 50px;
            
                font-size: 20px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .retornar {
                position: fixed;
                
                right: 30px;
                bottom: 30px;
            }
            
            .midias {
                display: flex;
                
                flex-wrap: wrap;
            }
            
            .midia {
                margin-top: 15px;
            
                outline: 1px solid #c0c0c0;
            
                width: 227px;
                height: 227px;
                
                overflow: hidden;
            }
            
            .midia:not(:nth-child(3n)) {
                margin-right: 15px;
            }
            
            .midia > * {
                left: 50%;
                top: 50%;
                
                width: 100%;
                height: 100%;
                
                object-fit: cover;
                object-position: center;
            }
            
            #fundo {
                position: fixed;
                left: 0px;
                top: 0px;
                width: 100vw;
                height: 100vh;
                zIndex: 9999;
                
                background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7));
            }
        </style>
    </head>
    <body>
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
                <span class="pagina pagina-centro"><%= atividade.getNome() %></span>
                <div class="menu">
                    <a class="opcao" href="postar.jsp?atividade=<%= codigo %>">
                        <img src="img/CadastrosIcone.png"/>
                        <div>Realizar Postagem</div>
                    </a>
                </div>
            </div>
        </div>
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div><input id="busca" class="busca" type="text" placeholder="Busca"/></div>
                    <div class="postagens">
                        <% for (ListIterator i = postagens.listIterator(postagens.size()); i.hasPrevious();) { %>
                            <% Postagem postagem = (Postagem)i.previous(); %>
                        <div class="painel">
                            <% if (usuario.getTipo().equals("P")) { %>
                            <a href="editar-post.jsp?atividade=<%= codigo %>&codigo=<%= postagem.getId() %>"><img class="editar" src="img/EditarPostagemIcone.png"/></a>
                            <% } %>
                            <div class="autor">Postado por <%--= postagem.getAutor() --%></div>
                            <div class="titulo"><%= postagem.getTitulo() %></div>
                            <div class="data"><%= postagem.getDia() %> - <%= postagem.getHorario() %></div>
                            <div class="texto"><%= postagem.getTexto() %></div>
                            <div class="midias">
                                <% for (String midia: postagem.getMidias()) { %>
                                    <% if (isImage(midia)) { %>
                                    <div class="midia"><img src="<%= midia %>"/></div>
                                    <% } else if (isVideo(midia)) { %>
                                <div class="midia"><video src="<%= midia %>" controls></video></div>
                                    <% } else if (isAudio(midia)) { %>
                                <div class="midia"><audio src="<%= midia %>" controls></audio></div>
                                    <% } %>
                                <% } %>
                            </div>
                        </div>
                        <% } %>
                        <div class="nenhum" style="display: none">Nenhum resultado encontrado.</div>
                    </div>
                </div>
            </div>
        </div>
        <input class="botao retornar" type="button" value="Retornar" onclick="location.href = 'atividades.jsp'"/>
        <div id="fundo" style="display: none"></div>
    </body>
</html>