<%@page import="DAO.*"%>
<%@page import="Model.*"%>

<%
    Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");    
    if (usuario == null || !usuario.getTipo().equals("E")) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }    
    Integer resultadoCadastro = (Integer)request.getSession().getAttribute("resultadoCadastro");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Cadastro de Atividade</title>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.4.5/jquery.autocomplete.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <script src="scripts/cadastro-atividade.js"></script>        
        <style>
            .autocomplete-suggestions { border: 1px solid #999; background: #FFF; overflow: auto; user-select: none}
            .autocomplete-suggestion { padding: 2px 5px; white-space: nowrap; overflow: hidden; }
            .autocomplete-selected { background: #F0F0F0; }
            .autocomplete-suggestions strong { font-weight: normal; color: #3399FF; }
            .autocomplete-group { padding: 2px 5px; }
            .autocomplete-group strong { display: block; border-bottom: 1px solid #000; }
            
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
            
            .selecao-aluno, .selecao-professor {                 
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
                <div class="pagina pagina-centro" style="font-size: 45px">Cadastro de Atividade</div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel">                                       
                        <form class="formulario" action="cadastrarAtividade" method="post">                            
                            <label class="label" for="cdigo" style="width:200px">Código</label>
                            <label class="label" for="nome">Nome</label>
                            
                            <br style="clear:both" />
                                                                                                        
                            <input class="campo" id="nome" name="codigo" maxlength="20" style="width: 200px" type="text" spellcheck="false" required>
                            <input class="campo" id="nome" name="nome" maxlength="100" style="width: 744px" type="text" spellcheck="false" required>
                            
                            <br style="clear:both" />        
                            
                            <label class="label" for="ano" style="width: 150px">Ano</label>
                            <label class="label" for="semestre" style="width: 150px">Semestre</label>
                            <label class="label" for="horario">Horário</label>
                            
                            <br style="clear:both" />                            
                            
                            <input class="campo" id="ano" name="ano" style="width: 150px" min="1990" type="number" spellcheck="false">
                            <input class="campo" id="semestre" name="semestre" maxlength="5" style="width: 150px" type="text" spellcheck="false">                                                        
                            <input class="campo" id="horario" name="horario" maxlength="200" style="width: 632px" type="text" spellcheck="false">                                                         
                                                
                            <br style="clear:both" />
                            
                            <label class="label" style="width:472px">Professores</label>
                            <label class="label">Alunos</label>
                            
                            <br style="clear:both" />
                                                                                                                    
                            <input id="selecao-professor" class="campo" type="text" style="width: 472px; float:left" onkeydown="if (event.keyCode == 13) return false;"/>
                            <input id="selecao-aluno" class="campo" type="text" style="width: 472px; float: left" onkeydown="if (event.keyCode == 13) return false;"/>
                            
                            <br style="clear:both" />
                            <div id="selecoes-professor" style="float: left; width: 484px">
                                Nenhum professor selecionado
                            </div>                                                                                                                                       
                            <div id="selecoes-aluno" style="float: right; width: 484px">
                                Nenhum aluno selecionado
                            </div>        
                            <br style="clear:both" />                    
                            
                            <div class="botoes" style="clean: both">
                                <% if (resultadoCadastro != null) { %>
                                    <% if (resultadoCadastro == 0) { %>                                        
                                        <label class="success-msg">Ativiadade cadastrada com sucesso</label>                                                                                                          
                                    <% } else if (resultadoCadastro == 16) { %>
                                        <label class="error-msg">Erro: Código já cadastrado</label>                                    
                                    <% } %>
                                <% } %>
                                <input class="botao" style="margin-top: 20px" type="button" value="Retornar" onclick="location.href = 'cadastros.jsp'"/>
                                <input class="botao submeter" style="margin-top: 20px" type="submit" value="Cadastrar"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
                                
        <script>   
            var listaProfessores = [
            <%  DAOMensagem daoMensagem = new DAOMensagem();                
                for (Professor professor : daoMensagem.listaProfessor(usuario)) { %>
                {value: "<%= professor.getDadosPessoais().getNome() %>", data: "<%= professor.getCodigo() %>"},
                <% } %>
            ];            
            preencherProfessores();
            
            var listaAlunos = [           
                <% for (Aluno aluno: daoMensagem.listaAlunos(usuario)) { %>
                {value: "<%= aluno.getMatricula() %> - <%= aluno.getDadosPessoais().getNome() %>", data: "<%= aluno.getMatricula() %>"},
                <% } %>
            ];            
            preencherAlunos();
        </script>
    </body>
</html>