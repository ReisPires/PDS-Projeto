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
        <title>Sistema London - Cadastro de Respons�vel</title>
        <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.devbridge-autocomplete/1.4.5/jquery.autocomplete.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">
        <script src="scripts/cadastro-responsavel.js"></script> 
        <script type="text/javascript" >

            $(document).ready(function() {

                function limpa_formul�rio_cep() {
                    // Limpa valores do formul�rio de cep.
                    $("#rua").val("");
                    $("#bairro").val("");
                    $("#cidade").val("");
                    $("#estado").val("");                    
                }

                //Quando o campo cep perde o foco.
                $("#cep").blur(function() {

                    //Nova vari�vel "cep" somente com d�gitos.
                    var cep = $(this).val().replace(/\D/g, '');

                    //Verifica se campo cep possui valor informado.
                    if (cep != "") {

                        //Express�o regular para validar o CEP.
                        var validacep = /^[0-9]{8}$/;

                        //Valida o formato do CEP.
                        if(validacep.test(cep)) {

                            //Preenche os campos com "..." enquanto consulta webservice.
                            $("#rua").val("...");
                            $("#bairro").val("...");
                            $("#cidade").val("...");
                            $("#estado").val("...");                            

                            //Consulta o webservice viacep.com.br/
                            $.getJSON("//viacep.com.br/ws/"+ cep +"/json/?callback=?", function(dados) {

                                if (!("erro" in dados)) {
                                    //Atualiza os campos com os valores da consulta.
                                    $("#rua").val(dados.logradouro);
                                    $("#bairro").val(dados.bairro);
                                    $("#cidade").val(dados.localidade);
                                    $("#estado").val(dados.uf);                                    
                                } //end if.
                                else {
                                    //CEP pesquisado n�o foi encontrado.
                                    limpa_formul�rio_cep();
                                    alert("CEP n�o encontrado.");
                                }
                            });
                        } //end if.
                        else {
                            //cep � inv�lido.
                            limpa_formul�rio_cep();
                            alert("Formato de CEP inv�lido.");
                        }
                    } //end if.
                    else {
                        //cep sem valor, limpa formul�rio.
                        limpa_formul�rio_cep();
                    }
                });
            });
        </script>        
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
            
            .radiolabel {
                font-family: "Segoe UI";                
                margin-top: 3px; 
                margin-right: 15px;
                font-size: 20px;                
                color: rgb(71, 70, 70);
                float: left;                
            }
            
            radio {                
                margin-top: 100px;                 
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
                <div class="pagina pagina-centro" style="font-size: 45px">Cadastro de Respons�vel</div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel">                                       
                        <form class="formulario" action="cadastrarResponsavel" method="post">                            
                            <label class="label" for="nome">Nome</label>
                            
                            <br style="clear:both" />
                                                        
                            <input class="campo" id="nome" name="nome" maxlength="100" style="width:958px" type="text" spellcheck="false" required>
                                                
                            <br style="clear:both" />
                                                        
                            <div class="grupo" id="selecao-grupo">
                                <label id="selecao-label" class="label" for="selecao"></label>
                                <input id="selecao" class="campo" type="text" style="width: 958px" onkeydown="if (event.keyCode == 13) return false;"/>
                                <br style="clear:both" />
                                <div id="selecoes">
                                    Nenhum aluno selecionado
                                </div>
                            </div>                                                        
                                                       
                            <label class="label" for="email" style="width: 570px">E-mail</label>
                            <label class="label" for="cpf" style="width: 170px">CPF</label>
                            <label class="label" for="telefone">Telefone</label>
                            
                            <br style="clear:both" />                            
                            
                            <input class="campo" id="email" name="email" maxlength="80" style="width: 570px" type="email" spellcheck="false" required>
                            <input class="campo" id="cpf" name="cpf" maxlength="11" style="width: 170px" type="text" spellcheck="false">                                                        
                            <input class="campo" id="telefone" name="telefone" maxlength="14" style="width: 192px" type="text" spellcheck="false"> 
                            
                            <br style="clear:both" />
                                                        
                            <label class="label" for="gender" style="width: 244px">Sexo</label>
                            <label class="label" for="pais" style="width: 280px">Pa�s</label>
                            <label class="label" for="cep" style="width: 120px">CEP</label>                            
                            <label class="label" for="estado">Estado</label>
                            
                            <br style="clear:both" />
                                                        
                            <label class="radiolabel"><input type="radio" id="masc" name="sexo" value="masc">   Masculino</label>
                            <label class="radiolabel"><input type="radio" id="fem" name="sexo" value="fem">   Feminino</label>                            
                            <input class="campo" id="pais" name="pais" maxlength="50" style="width: 280px" type="text" spellcheck="false">                                                        
                            <input class="campo" id="cep" name="cep" maxlength="10" style="width: 120px" type="text" spellcheck="false">                         
                            <input class="campo" id="estado" name="estado" maxlength="50" style="width: 277px" type="text" spellcheck="false"> 
                            
                            <br style="clear:both" />                                                                                                                                                                                                    
                                                                                    
                            <label class="label" for="cidade" style="width: 472px">Cidade</label>
                            <label class="label" for="bairro">Bairro</label>                            
                            
                            <br style="clear:both" />
                            
                            <input class="campo" id="cidade" name="cidade" maxlength="50" style="width: 472px" type="text" spellcheck="false">                         
                            <input class="campo" id="bairro" name="bairro" maxlength="50" style="width: 472px" type="text" spellcheck="false">                         
                            
                            <br style="clear:both" />
                            
                            <label class="label" for="rua" style="width: 475px">Rua</label>
                            <label class="label" for="numero" style="width: 80px">N�</label>
                            <label class="label" for="complemento">Complemento</label>                                                                                    
                            
                            <br style="clear:both" />
                            
                            <input class="campo" id="rua" name="rua" maxlength="100" style="width: 472px" type="text" spellcheck="false">                         
                            <input class="campo" id="numero" name="numero" maxlength="6" style="width: 80px" type="text" spellcheck="false"> 
                            <input class="campo" id="complemento" name="complemento" maxlength="80" style="width: 380px" type="text" spellcheck="false">   
                                                        
                            <br style="clear:both" />
                            
                            <div class="botoes" style="clean: both">
                                <% if (resultadoCadastro != null) { %>
                                    <% if (resultadoCadastro == 0) { %>                                        
                                        <label class="success-msg">Respons�vel cadastrado com sucesso</label>                                                                                                          
                                    <% } else if (resultadoCadastro == 13) { %>
                                        <label class="error-msg">Erro: CPF j� cadastrado</label>
                                    <% } else if (resultadoCadastro == 15) { %>
                                        <label class="error-msg">Erro: e-mail j� cadastrado</label> 
                                    <% } else if (resultadoCadastro == 21) { %>
                                        <label class="error-msg">Erro: selecione um aluno</label>
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
            var listaAlunos = [
            <%  DAOMensagem daoMensagem = new DAOMensagem();                
                for (Aluno aluno: daoMensagem.listaAlunos(usuario)) { %>
                {value: "<%= aluno.getMatricula() %> - <%= aluno.getDadosPessoais().getNome() %>", data: "<%= aluno.getMatricula() %>"},
                <% } %>
            ];            
            preencherAlunos();
        </script>
    </body>
</html>