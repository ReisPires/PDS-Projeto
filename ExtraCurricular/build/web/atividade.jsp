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

request.getSession().setAttribute("resultadoAltera", null);

String codigo = request.getParameter("codigo");
if (codigo == null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

DAOAtividade daoAtividade = new DAOAtividade();
Atividade atividade = new Atividade(codigo, "");
atividade = daoAtividade.recuperaAtividade(atividade);
ArrayList<Postagem> postagens = daoAtividade.listaPostagens(atividade);
ArrayList<Professor> professores = daoAtividade.listaProfessoresAtividade(atividade);

DAOUsuario daoUsuario = new DAOUsuario();
String facebookId = daoUsuario.recuperaFacebook(usuario);
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
                
                cursor: pointer;
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
            
            .info {                
                box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.23);                
                margin: 0 auto;                
                margin-top: -20px;
                margin-bottom: 20px;
                padding: 10px;
                background-color: rgb(245, 243, 243);                
                width: 50%;                
            }
        </style>
    </head>
    <body>
        <div id="fb-root"></div>
            <script>(function(d, s, id) {
              var js, fjs = d.getElementsByTagName(s)[0];
              if (d.getElementById(id)) return;
              js = d.createElement(s); js.id = id;
              js.src = 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.11&appId=690889244441145';
              fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));</script>
        
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
                <span class="pagina pagina-centro"><%= atividade.getNome() %></span>
                <div class="menu">
                    <% if (usuario.getTipo().equals("P")) { %>
                        <a class="opcao" href="postar.jsp?atividade=<%= codigo %>">
                            <img src="img/CadastrosIcone.png"/>
                            <div>Realizar Postagem</div>
                        </a>
                    <% } %>
                </div>
            </div>
        </div>
        <div class="corpo">
            <div class="container">                
                    <div class="info">
                        <% if (atividade.getAno() > 0 && atividade.getSemestre() != null) { %>
                            <div class="label" style="font-size: 16px"><%= atividade.getAno() == 0 ? "" : Integer.toString(atividade.getAno()) %><%= atividade.getAno() > 0 && atividade.getSemestre() != null ? "/" : "" %><%= atividade.getSemestre() == null ? "" : atividade.getSemestre() %></div>
                        <% } %>
                        <div class="label" style="font-size: 16px">                            
                            <% if (professores != null) {
                                for (int i = 0; i < professores.size(); ++i) { %>
                                    <a style="color:rgb(111, 110, 110); font-size: 16px; text-decoration: none" href="usuario.jsp?id=<%= professores.get(i).getDadosUsuario().getId() %>">Prof. <%= professores.get(i).getDadosPessoais().getNome() %></a> 
                                    <% if (i < professores.size() - 1) { %>
                                        -
                                    <% } %>
                                <% } %>
                            <% } %>
                        </div>
                        <% if (atividade.getHorario() != null) { %>
                            <div class="label" style="font-size: 16px"><%= atividade.getHorario() %></div>  
                        <% } %>
                        <% if (usuario.getTipo().equals("P") || usuario.getTipo().equals("E")) { %>
                            <input class="botao submeter" type="button" style="margin-top: 10px; width: 220px; height: 25px; font-size: 16px; margin-right: 10px; margin-bottom: 5px" value="Alterar dados da atividade" onclick="location.href = 'altera-atividade.jsp?codigo=<%= codigo %>'"/>
                        <% } %>
                        <input class="botao submeter" type="button" style="margin-top: 10px; width: 220px; height: 25px; font-size: 16px" value="Ver inscritos" onclick="location.href = 'inscritos.jsp?codigo=<%= codigo %>'"/>
                    </div>                
                <div class="frame">
                    <div><input id="busca" class="busca" type="text" placeholder="Busca"/></div>
                    <div class="postagens">
                        <% for (ListIterator i = postagens.listIterator(postagens.size()); i.hasPrevious();) { %>
                            <% Postagem postagem = (Postagem)i.previous(); %>
                        <div class="painel">
                            <% if (usuario.getTipo().equals("P")) { %>
                            <a href="editar-post.jsp?atividade=<%= codigo %>&codigo=<%= postagem.getId() %>"><img class="editar" src="img/EditarPostagemIcone.png"/></a>
                            <% } %>
                            <div class="autor">Postado por <%= postagem.getProfessor() %></div>
                            <div class="titulo"><%= postagem.getTitulo() %></div>
                            <div class="data"><%= postagem.getDia() %> - <%= postagem.getHorario() %></div>
                            <div class="texto"><%= postagem.getTexto() %></div>
                            <div class="midias">
                                <% for (String midia: postagem.getMidias()) { %>
                                    <% if (isImage(midia)) { %>
                                    <div class="midia"><img src="<%= "media/" + midia %>"/></div>
                                    <% } else if (isVideo(midia)) { %>
                                <div class="midia"><video src="<%= "media/" + midia %>" controls></video></div>
                                    <% } else if (isAudio(midia)) { %>
                                <div class="midia"><audio src="<%= "media/" + midia %>" controls></audio></div>
                                    <% } %>
                                <% } %>
                            </div>    
                            <% if (facebookId != null) { %>
                            <div style="text-align: right">
                                <div style="margin-top: 15px" class="fb-like" data-href="http://c5993641.ngrok.io/PDS-Projeto/postagem.jsp?id=<%= Integer.toString(postagem.getId()) %>" data-layout="button_count" data-action="like" data-size="large" data-show-faces="false" data-share="true"></div>
                            </div>
                            <% } %>
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