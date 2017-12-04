<%@page import="java.util.ArrayList"%>
<%@page import="DAO.DAOUsuario"%>
<%@page import="Model.*"%>

<%
    Usuario usuario = (Usuario)request.getSession().getAttribute("usuario");    
    if (usuario == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }

    Integer id = Integer.parseInt(request.getParameter("id"));
    DAOUsuario daoUsuario = new DAOUsuario();    
    String tipo = daoUsuario.recuperaTipo(new Usuario(id));
    
    if (tipo == null || tipo.equals("E") || ((usuario.getTipo().equals("A") || usuario.getTipo().equals("R")) && !tipo.equals("P"))) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }   
   
    Aluno aluno = null; 
    ArrayList<DadosPessoais> responsaveis = null;
    if (tipo.equals("A")) {
        aluno = daoUsuario.recuperaAluno(new Usuario(id));                 
    }
    DadosPessoais dadosPessoais = daoUsuario.recuperaDadosPessoais(new Usuario(id));
    if (dadosPessoais == null) {
        request.getRequestDispatcher("index.jsp").forward(request, response);
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Sistema London - Usuário</title>
        <link rel="stylesheet" type="text/css" href="styles/cinza.css">                
        <style>
            .titulo {
                font-size: 29px;
                font-family: "Segoe UI";
                color: rgb(71, 70, 70);
                line-height: 1.2;
            }
            
            .label {
                display: inline-block;
                font-size: 16px;    
                width: 83px;                
            }                                               
            
            .info {
                display: inline-block;
                font-size: 20px;     
                width: 230px;
            }    
                        
            
            .linha {
                margin-bottom: 5px;
            }
            
            .retornar {
                position: fixed;
                
                right: 30px;
                bottom: 30px;
            }                        
        </style>
    </head>
    <body>
        <div class="cabecalho">
            <div class="container">
                <a href="atividades.jsp"><img class="logo" src="img/SistemaLogo.png"/></a>   
                <div class="pagina pagina-centro"><%= dadosPessoais.getNome() %></div>
            </div>
        </div>        
        <div class="corpo">
            <div class="container">
                <div class="frame">
                    <div class="painel">               
                        <div class="linha">
                            <% if (aluno != null) { %>
                                <label class="label">Matrícula: </label>
                                <label class="info"><%= aluno.getMatricula() %></label>
                                <% if (aluno.getTurma() != null) { %>
                                    <label class="label">Turma: </label>
                                    <label class="info"><%= aluno.getTurma()%></label>
                                <% } %>
                            <% } %>                                                                       
                        </div>
                        <div class="linha">
                            <% if (dadosPessoais.getCpf() != null && usuario.getTipo().equals("E")) { %>
                                <label class="label">CPF: </label>
                                <label class="info"><%= dadosPessoais.getCpf() %></label>
                            <% } %>
                            <label class="label">E-mail: </label>
                            <label class="info"><%= dadosPessoais.getEmail() %></label>                                                      
                        </div>
                        <div class="linha">
                            <% if (dadosPessoais.getTelefone()!= null) { %>
                                <label class="label">Telefone </label>
                                <label class="info"><%= dadosPessoais.getTelefone() %></label>
                            <% } %>
                            <% if (dadosPessoais.getSexo() != null) { %>
                                <label class="label">Sexo: </label>
                                <label class="info"><%= dadosPessoais.getSexo().equals("M") ? "Masculino" : "Feminino" %></label>
                            <% } %>
                        </div>
                        <% if (usuario.getTipo().equals("E")) { %>
                            <div class="linha">                            
                                <% if (dadosPessoais.getEndereco().getPais() != null) { %>
                                <label class="label">País: </label>
                                <label class="info"><%= dadosPessoais.getEndereco().getPais() %></label>
                                <% } %>
                                <% if (dadosPessoais.getEndereco().getCep()!= null) { %>
                                    <label class="label">CEP: </label>
                                    <label class="info"><%= dadosPessoais.getEndereco().getCep()%></label>
                                <% } %>             
                                <% if (dadosPessoais.getEndereco().getEstado()!= null) { %>
                                    <label class="label">Estado: </label>
                                    <label class="info"><%= dadosPessoais.getEndereco().getEstado()%></label>
                                <% } %>
                            </div>                        
                            <div class="linha">                                 
                                <% if (dadosPessoais.getEndereco().getCidade()!= null) { %>
                                    <label class="label">Cidade: </label>
                                    <label class="info"><%= dadosPessoais.getEndereco().getCidade()%></label>
                                <% } %>
                                <% if (dadosPessoais.getEndereco().getBairro()!= null) { %>
                                    <label class="label">Bairro: </label>
                                    <label class="info"><%= dadosPessoais.getEndereco().getBairro()%></label>
                                <% } %>
                            </div>
                            <div class="linha">     
                                <% if (dadosPessoais.getEndereco().getRua()!= null) { %>
                                    <label class="label">Rua: </label>
                                    <label class="info" style="width: auto"><%= dadosPessoais.getEndereco().getRua()%></label>
                                <% } %>
                                <% if (dadosPessoais.getEndereco().getNumero() != null) { %>                                
                                    <label class="info" style="width: auto">, <%= dadosPessoais.getEndereco().getNumero()%></label>
                                <% } %>
                                <% if (dadosPessoais.getEndereco().getComplemento()!= null) { %>                                
                                    <label class="info" style="width: auto"> - <%= dadosPessoais.getEndereco().getComplemento()%></label>
                                <% } %>
                            </div>                            
                            <% if (usuario.getTipo().equals("E")) { %>
                            <form action="removerUsuario" method="post" >
                                <div class="botoes" style="clean: both">
                                    <input type="hidden" id="idusuario" name="idusuario" value="<%= id %>">
                                    <input class="botao" style="background-color: rosybrown; width: 200px; font-size: 18px" type="submit" value="Remover do sistema"/>
                                </div>                            
                            </form>
                            <% } %>
                        <% } %>                        
                    </div>
                    <% if (tipo.equals("A")) {
                        ArrayList<Integer> rids = daoUsuario.recuperaResponsavelAluno(new Usuario(id));
                        if (rids != null ) { %>   
                        <div class="painel" style="margin-top: 10px">
                        <div style="text-align: left">
                            <label style="color: rgb(70, 70, 70); font-size: 30px; text-align: left">Responsáveis</label>                                
                        </div>
                    <%      for (Integer rid : rids) {
                               DadosPessoais dadosResponsavel = daoUsuario.recuperaDadosPessoais(new Usuario(rid)); %>
                               <div class="linha" style="margin-top: 10px">                                                                                
                                    <a href="usuario.jsp?id=<%= rid %>" class="info" style="text-decoration: none; color: rgb(70,70,71); width: auto"><%= dadosResponsavel.getNome() %></a>                                        
                                </div>                                
                    <%        }
                        }
                    } %>                                                                                                                                                                                                                      
                </div>
            </div>
        </div>
        <input class="botao retornar" type="button" value="Retornar" onclick="window.history.back()"/>
    </body>
</html>


        