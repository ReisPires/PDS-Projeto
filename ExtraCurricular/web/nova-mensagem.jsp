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
ListaAtividades atividades = daoAtividade.listaAtividades(usuario);

DAOMensagem daoMensagem = new DAOMensagem();
ArrayList<Professor> professores = daoMensagem.listaProfessor(usuario);
ArrayList<Aluno> alunos = daoMensagem.listaAlunos(usuario);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Nova Mensagem</title>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.4.5/jquery.autocomplete.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <script src="scripts/nova-mensagem.js"></script>
        <style>
            .autocomplete-suggestions { border: 1px solid #999; background: #FFF; overflow: auto; user-select: none}
            .autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; }
            .autocomplete-selected { background: #F0F0F0; }
            .autocomplete-suggestions strong { font-weight: normal; color: #3399FF; }
            .autocomplete-group { padding: 2px 5px; }
            .autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
            
            .frame {
                display: inline-block;
                
                width: 768px;
            }
        
            .texto {
                height: 140px;
            }
            
            .selecao {
                display: inline-block;
                
                border-radius: 5px;
                
                margin: 0px 2px;
                margin-top: 5px;
                
                padding: 5px;
                
                background-color: rgb(120, 185, 245);
                
                color: white;
                
                cursor: pointer;
                
                user-select: none;
            }
        </style>
    </head>
    <body>
		<div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>
                <div class="pagina pagina-centro">Nova Mensagem</div>
            </div>
		</div>
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <form action="nova-mensagem" method="post">
                        <div class="painel">
                            <div class="grupo">
                                <label class="label" for="titulo">Título:</label>
                                <input id="titulo" name="titulo" class="campo" type="text"/>
                            </div>
                            <% if (usuario.getTipo().equals("E") || usuario.getTipo().equals("P")) { %>
                            <div class="grupo">
                                <label class="label">Destino:</label>
                                <% if (usuario.getTipo().equals("E")) { %>
                                <label for="todos"><input id="todos" name="destino" type="radio" value="todos" checked/> Todos</label>
                                <% } %>
                                <label for="atividades"><input id="atividades" name="destino" type="radio" value="atividades"/> Atividades</label>
                                <% if (!usuario.getTipo().equals("P")) { %>
                                <label for="professores"><input id="professores" name="destino" type="radio" value="professores"/> Professores</label>
                                <% } %>
                                <label for="responsaveis"><input id="responsaveis" name="destino" type="radio" value="responsaveis"/> Responsáveis</label>
                                <label for="alunos"><input id="alunos" name="destino" type="radio" value="alunos"/> Alunos</label>
                            </div>
                            <% } %>
                            <div class="grupo" id="selecao-grupo" style="display: none">
                                <label id="selecao-label" class="label" for="selecao"></label>
                                <input id="selecao" class="campo" type="text" onkeydown="if (event.keyCode == 13) return false;"/>
                                <div id="selecoes">
                                    Nenhum destinatário selecionado
                                </div>
                            </div>
                            <div class="grupo">
                                <label class="label" for="texto">Texto:</label>
                                <textarea id="texto" name="texto" class="campo texto"></textarea>
                            </div>
                        </div>
                        <div class="botoes">
                            <input class="botao" type="button" value="Retornar" onclick="location.href = 'mensagens.jsp'"/>
                            <input class="botao submeter" type="submit" value="Enviar"/>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        
        <script>
            <% if (usuario.getTipo().equals("R") || usuario.getTipo().equals("A")) { %>
            $("#selecao-grupo").show();
            <% } %>
        
            <% if (usuario.getTipo().equals("E") || usuario.getTipo().equals("P")) { %>
            var listaAtividades = [
                <% for (Atividade atividade: atividades.atividades) { %>
                {value: "<%= atividade.getCodigo() %> - <%= atividade.getNome() %>", data: "<%= atividade.getCodigo() %>"},
                <% } %>
            ];
            var listaResponsaveis = [
                {value: "Erlang", data: "Erlang"},
                {value: "Fortran", data: "Fortran"},
                {value: "Groovy", data: "Groovy"},
                {value: "Haskell", data: "Haskell"},
                {value: "Java", data: "Java"}
            ];
            var listaAlunos = [
                <% for (Aluno aluno: alunos) { %>
                {value: "<%= aluno.getDadosUsuario().getId() %> - <%= aluno.getDadosPessoais().getNome() %>", data: "<%= aluno.getDadosUsuario().getId() %>"},
                <% } %>
            ];
            <% } %>
            <% if (!usuario.getTipo().equals("P")) { %>
            var listaProfessores = [
                <% for (Professor professor: professores) { %>
                {value: "<%= professor.getCodigo() %> - <%= professor.getDadosPessoais().getNome() %>", data: "<%= professor.getCodigo() %>"},
                <% } %>
            ];
            <% } %>
            
            <% if (usuario.getTipo().equals("E") || usuario.getTipo().equals("P")) { %>
            $("input[type=radio][name=destino]").change(function () {
                mudarDestino($(this).val());
            });
            <% } else { %>
            mudarDestino("professores"); 
            <% } %>
                
            <% if (usuario.getTipo().equals("P")) { %>
            $("#atividades").prop("checked", true); 
            mudarDestino("atividades"); 
            <% } %>
        </script>
    </body>
</html>