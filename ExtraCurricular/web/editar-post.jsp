<%@page import="java.util.ArrayList"%>
<%@page import="Model.*"%>
<%@page import="DAO.*"%>

<%
Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");
if (usuario == null) {
    request.getRequestDispatcher("index.jsp").forward(request, response);
    return;
}

String atividade = request.getParameter("atividade");
if (atividade == null) {
    request.getRequestDispatcher("atividades.jsp").forward(request, response);
    return;
}

String codigo = request.getParameter("codigo");
if (codigo == null) {
    request.getRequestDispatcher("atividade.jsp?codigo=" + atividade).forward(request, response);
    return;
}

DAOAtividade daoAtividade = new DAOAtividade();
Postagem postagem = daoAtividade.recuperaPostagem(Integer.parseInt(codigo));
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Editar Postagem</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">          
        <script type="text/javascript" >

            $(document).ready(function() {

                function limpa_formulário_cep() {
                    // Limpa valores do formulário de cep.
                    $("#rua").val("");
                    $("#bairro").val("");
                    $("#cidade").val("");
                    $("#estado").val("");                    
                }

                //Quando o campo cep perde o foco.
                $("#cep").blur(function() {

                    //Nova variável "cep" somente com dígitos.
                    var cep = $(this).val().replace(/\D/g, '');

                    //Verifica se campo cep possui valor informado.
                    if (cep != "") {

                        //Expressão regular para validar o CEP.
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
                                    //CEP pesquisado não foi encontrado.
                                    limpa_formulário_cep();
                                    alert("CEP não encontrado.");
                                }
                            });
                        } //end if.
                        else {
                            //cep é inválido.
                            limpa_formulário_cep();
                            alert("Formato de CEP inválido.");
                        }
                    } //end if.
                    else {
                        //cep sem valor, limpa formulário.
                        limpa_formulário_cep();
                    }
                });
            });
        </script>
        <style>
            .titulo {
                height: 28px;
            }
            
            .texto {
                height: 160px;
            }
            
            .midias {
                font-size: 16.667px;
                font-family: "Segoe UI";
                color: rgb(85, 85, 85);
                line-height: 1.2;
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
                <img class="logo" src="img/SistemaLogo.png"/>
                <div class="pagina pagina-centro">Editar Postagem</div>
            </div>
		</div>
        <div class="corpo">
            <div class="container">
                <form action="editar-post" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="atividade" value="<%= atividade %>"/>
                    <input type="hidden" name="codigo" value="<%= codigo %>"/>
                    <div class="painel">
                        <label class="label" for="titulo">Título:</label>
                        <input id="titulo" name="titulo" class="campo titulo" type="text" value="<%= postagem.getTitulo() %>"/>
                        <label class="label" for="texto">Texto:</label>
                        <textarea id="texto" name="texto" class="campo texto"><%= postagem.getTexto() %></textarea>
                        <label class="label" for="midias">Manter:</label>
                        <div>
                            <% for (String mantido: postagem.getMidias()) { %>
                            <div class='selecao' onclick='$(this).remove()'>
                                <%= mantido %>
                                <input type='hidden' name='mantidos' value='<%= mantido %>'/>
                            </div>
                            <% } %>
                        </div>
                        <label class="label" for="midias">Adicionar:</label>
                        <input id="midias" name="midias" class="midias" type="file" multiple/>
                    </div>
                    <div class="botoes">
                        <input class="botao" type="button" value="Retornar" onclick="location.href = 'atividade.jsp?codigo=<%= atividade %>'"/>
                        <input class="botao submeter" type="submit" value="Enviar"/>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>