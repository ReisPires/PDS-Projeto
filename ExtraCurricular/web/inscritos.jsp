<%@page import="java.util.ArrayList"%>
<%@page import="java.util.ListIterator"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

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
    ArrayList<Aluno> alunos = daoAtividade.listaDadosAlunosAtividade(atividade);    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Atividade</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <script src="scripts/inscritos.js"></script>
        <style>
            .menu {
                position: absolute;
                
                right: 10px;
                bottom: 5px;
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
            
            .label {
                display: inline;
                font-size: 22px;                  
            }
            
            .icone {      
                float: right;
                height: 40px; 
                width: 40px;                 
            }
        </style>
    </head>
    <body>                
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
                <span class="pagina pagina-centro"><%= atividade.getNome() %></span>                
            </div>
        </div>
        <div class="corpo">
            <div class="container">                                                    
                <div class="frame">
                    <div><input id="busca" class="busca" type="text" placeholder="Busca"/></div>
                    <div class="postagens">                        
                            <% for (Aluno aluno : alunos) { %>
                            <div class="painel">                            
                                <label class="label" style="width: 150px; font-size: 15px"><%= aluno.getMatricula() %></label>
                                <label class="label" style="width: 120px; margin-left: 20px; font-size: 15px"><%= aluno.getTurma() == null ? "" : aluno.getTurma() %></label>
                                <label class="label" style="width: 120px; margin-left: 20px"><%= aluno.getDadosPessoais().getNome() %></label>                                                                                                
                                <label class="label" style="font-size: 18px; margin-left: 20px"><%= aluno.getDadosPessoais().getEmail() %></label>                                                       
                                <% if (usuario.getTipo().equals("P") || usuario.getTipo().equals("E")) { %>
                                    <a href="usuario.jsp?id=<%= aluno.getDadosUsuario().getId() %>">
                                        <img class="icone" src="img/IconLupa.png" />
                                    </a>    
                                <% } %>
                                <br style="clear:both" />
                            </div>                        
                        <% } %>
                        <div class="nenhum" style="display: none">Nenhum aluno encontrado.</div>
                    </div>
                </div>
            </div>
        </div>
        <input class="botao retornar" type="button" value="Retornar" onclick="location.href = 'atividade.jsp?codigo=<%= codigo %>'"/>
        <div id="fundo" style="display: none"></div>
    </body>
</html>