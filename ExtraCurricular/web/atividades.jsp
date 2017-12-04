<%@page import="java.util.ArrayList"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Atividades</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <script src="scripts/atividades.js"></script> 
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
            
            .atividades {
                float: left;
            
                width: 768px;
                
                padding: 0px 15px;
            }
            
            .painel {
                padding-top: 8px;
                padding-bottom: 12px;
                
                text-align: center;
            }
            
            .titulo {
                font-size: 35px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .alunos {
                margin-top: 5px;
            
                font-size: 13px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
            }
            
            .filtros {
                float: right;
                
                width: calc(1024px - 768px);
                
                padding: 0px 15px;
                
                text-align: left;
            }
            
            .filtro {
                box-shadow: 0px 3px 7px 0px rgba(0, 0, 0, 0.23);
                
                padding: 15px 30px;
                
                background-color: rgb(245, 243, 243);
            }
            
            .filtro:not(:first-child) {
                margin-top: 15px;
            }
            
            .checklist {
                margin-top: 5px;
            }
            
            .checkbox {
                display: block;
                
                user-select: none;
            }
        </style>
    </head>
    <body>
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
		<span class="pagina pagina-centro">Atividades</span>
		<div class="menu">
                    <% if (usuario.getTipo().equals("E")) { %>
                    <a class="opcao" href="cadastros.jsp">
                        <img src="img/CadastrosIcone.png"/>
                        <div>Cadastros</div>
                    </a>
                    <% } %>
                    <a class="opcao" href="mensagens.jsp">
                        <% DAOMensagem daoMensagem = new DAOMensagem();
                        int msgsNaoLidas = daoMensagem.exibeMensagensNaoLidas(usuario);
                        if (msgsNaoLidas > 0) { %>
                            <img src="img/MensagensIconeOn.png"/>
                            <div>Mensagens(<%= Integer.toString(msgsNaoLidas) %>)</div>
                        <% } else { %>
                            <img src="img/MensagensIconeOff.png"/>
                            <div>Mensagens</div>
                        <% } %>                        
                    </a>
                    <% if (!usuario.getTipo().equals("E")) { %>
                    <a class="opcao" href="recuperarPerfil">
                        <img src="img/EditarPerfilIcone.png"/>
                        <div>Editar perfil</div>
                    </a>                                    
                    <% } %>
                    <a class="opcao" href="sair">                    
                        <img src="img/SairIcone.png"/>                        
                        <div>Sair</div>
                    </a>                                        
                </div>
            </div>
	</div>
        <div class="corpo">
            <div class="container">
                <div class="atividades"></div>
                <div class="filtros">
                    <% if (usuario.getTipo().equals("R")) { %>
                    <div class="filtro">
                        <div class="label">Alunos</div>
                        <div id="alunos" class="checklist"></div>
                    </div>
                    <% } %>
                    <div class="filtro">
                        <div class="label">Atividades</div>
                        <div class="checklist">
                            <label class="checkbox" for="em-andamento">
                                <input id="em-andamento" type="checkbox" onchange="atualizarAtividades()" checked/>
                                <span>Em andamento</span>
                            </label>
                            <label class="checkbox" for="concluidas">
                                <input id="concluidas" type="checkbox" onchange="atualizarAtividades()"/>
                                <span>Concluídas</span>
                            </label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            <%
            DAOAtividade daoAtividade = new DAOAtividade();
            ListaAtividades listaAtividades = daoAtividade.listaAtividades(usuario);
            %>
                 
            <% if (listaAtividades.getAlunos() != null) { %>
                <% for (AlunoAtividade aluno: listaAtividades.getAlunos()) { %>
                    adicionarAluno("<%= aluno.getAluno() %>", [
                    <% boolean first = true; %>
                    <% for (String atividade: aluno.getAtividade()) { %>
                        <% if (!first) { %>, <% } %>
                        <% first = false; %>
                        <%= atividade %> 
                    <% } %>
                    ]);
                <% } %>
            <% } %>
            
            <% for (Atividade atividade: listaAtividades.getAtividades()) { %>
                adicionarAtividade(
                    <%= atividade.getCodigo() %>,
                    "<%= atividade.getNome() %>",
                    <%= atividade.isConcluida() %>);
            <% } %>
        </script>
    </body>
</html>