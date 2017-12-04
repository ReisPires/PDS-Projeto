<%@page import="java.util.ArrayList"%>
<%@page import="DAO.*"%>
<%@page import="Model.*"%>

<%
    Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
    if (usuario == null || !(usuario.getTipo().equals("P") || usuario.getTipo().equals("E"))) {
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

    Integer resultadoAltera = (Integer)request.getSession().getAttribute("resultadoAltera");
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Atividade</title>                
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.4.5/jquery.autocomplete.min.js"></script>
        <script src="scripts/altera-atividade.js"></script>        
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
                font-size: 16px;
                font-family: "Segoe UI";
                text-align: left; 
                color: red;                             
                margin-right: 2px;                
            }

            .success-msg {
                font-size: 16px;
                font-family: "Segoe UI";
                text-align: left; 
                color: green;   
                margin-right: 2px;                
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
                <div class="pagina pagina-centro"><%= atividade.getNome() %></div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel" style="margin: 0 auto; width: 570px">                                       
                        <form class="formulario" action="alterarAtividade" method="post">                                                                                                                                                                                                                                                                                                            
                            <input type="hidden" id="codigo" name="codigo" value="<%= codigo %>">
                            
                            <label class="label" for="ano" style="width: 130px">Ano</label>
                            <label class="label" for="semestre" style="width: 210px" >Semestre</label>
                            <label class="label" for="semestre">Situação</label>
                            
                            <br style="clear:both" />                            
                            
                            <input class="campo" id="ano" name="ano" style="width: 130px" min="1990" type="number" value="<%= atividade.getAno() == 0 ? "" : Integer.toString(atividade.getAno()) %>">
                            <input class="campo" id="semestre" name="semestre" maxlength="5" style="width: 200px; margin-right: 0px" type="text" value="<%= atividade.getSemestre() == null ? "" : atividade.getSemestre() %>" spellcheck="false">                                                        
                            <label class="campo" style="border: none; margin-left: 20px; width: 120px"><input type="checkbox" id="concluida" name="concluida" value="concluida" <% if (atividade.isConcluida()) { %> checked <% } %>>   Concluída</label>
                            
                            <br style="clear:both" />                            
                            
                            <label class="label" for="horario">Horário</label>                                                        
                                                                                                                
                            <br style="clear:both" />   
                            
                            <input class="campo" id="horario" name="horario" maxlength="200" style="width: 514px" type="text" value="<%= atividade.getHorario() == null ? "" : atividade.getHorario() %>" spellcheck="false">                                                                                                                                     
                            
                            <br style="clear:both" /> 
                            
                            <% if (usuario.getTipo().equals("E")) { %>
                                                                                    
                            <label class="label">Associar novos professores</label>                                                        
                            <br style="clear:both" />                                                                                                                    
                            <input id="selecao-professor" class="campo" type="text" style="width: 514px; float:left" onkeydown="if (event.keyCode == 13) return false;"/>                            
                            <br style="clear:both" />
                            <div id="selecoes-professor" style="float: left; width: 514px">
                                Nenhum professor selecionado
                            </div>                                                                                                                                       
                            
                            <label class="label">Matricular novos alunos</label>                            
                            <br style="clear:both" />                            
                            <input id="selecao-aluno" class="campo" type="text" style="width: 514px; float: left" onkeydown="if (event.keyCode == 13) return false;"/>                            
                            <br style="clear:both" />                            
                            <div id="selecoes-aluno" style="float: left; width: 514px">
                                Nenhum aluno selecionado
                            </div>        
                            <br style="clear:both" />
                            <% } %>
                            
                            <div class="botoes" style="clean: both">  
                                <% if (resultadoAltera != null) { %>
                                    <% if (resultadoAltera == 0) { %>                                        
                                        <label class="success-msg">Atividade atualizada com sucesso</label>                                        
                                    <% } else if (resultadoAltera == 26) { %>
                                        <label class="error-msg">Erro: atividade não encontrada</label>                                                                                                                 
                                    <% } %>
                                <% } %>
                                <input class="botao" style="margin-top: 20px" type="button" value="Retornar" onclick="location.href = 'atividade.jsp?codigo=<%= codigo %>'"/>
                                <input class="botao submeter" style="margin-top: 20px" type="submit" value="Salvar"/>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <% if (usuario.getTipo().equals("E")) { %>
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
        <% } %>
    </body>
</html>