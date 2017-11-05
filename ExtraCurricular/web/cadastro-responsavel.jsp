<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ExtraCurricular - Cadastro</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                width: 320px;
                
                padding: 15px;
            }
            
            .grupo {
                margin-bottom: 5px;
            }
            
            input[type=text], input[type=email], input[type=password] {
                width: 100%;
            }
            
            input[type=button], input[type=submit] {
                width: 130px;
            }
            
            .aluno {
                display: flex;
            }
            
            .aluno:not(:first-child) {
                margin-top: 5px;
            }
            
            .deletar {
                margin-left: 10px;
            
                width: 25px !important;
            }
            
            #adicionar {
                margin-top: 10px;
            
                width: 100%;
            }
            
            #cadastrar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Cadastro de responsável
            </div>
            <form action="cadastrar" method="post">
                <div class="grupo">
                    <div><label for="nome">Nome:</label></div>
                    <div><input id="nome" name="nome" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="cpf">CPF:</label></div>
                    <div><input id="cpf" name="cpf" type="text"/></div>
                </div>
                <div class="grupo">
                    <div><label for="email">E-mail:</label></div>
                    <div><input id="email" name="email" type="email"/></div>
                </div>
                <div class="grupo">
                    <div><label for="senha">Senha:</label></div>
                    <div><input id="senha" name="senha" type="password"/></div>
                </div>
                <div class="grupo">
                    <div><label>Alunos:</label></div>
                    <div id="alunos">
                        <div id="aluno1" class="aluno">
                            <input name="alunos" type="text"/>
                            <input class="deletar" type="button" value="-" onclick="deletarAluno(1)" style="display: none"/>
                        </div>
                    </div>
                    <div><input id="adicionar" type="button" value="Adicionar aluno" onclick="adicionarAluno()"/></div>
                </div>
                <div style="margin-top: 15px">
                    <input id="retornar" type="button" value="Retornar" onclick="window.location.href = 'index.jsp'"/>
                    <input id="cadastrar" type="submit" value="Cadastrar"/>
                </div>
            </form>
        </div>
        
        <script>
            var proxAluno = 2;
        
            function adicionarAluno() {
                if ($("[name=alunos]").length === 5)
                    return;
                
                if ($("[name=alunos]").length === 1)
                    $(".deletar").css("display", "");
                    
                $("#alunos").append(
                    '<div id="aluno' + proxAluno + '" class="aluno">' +
                        '<input name="alunos" type="text"/>' +
                        '<input class="deletar" type="button" value="-" onclick="deletarAluno(' + proxAluno++ + ')"/>' +
                    '</div>'
                );
                
                if ($("[name=alunos]").length === 5)
                    $("#adicionar").css("display", "none");
            }
            
            function deletarAluno(id) {
                if ($("[name=alunos]").length === 5)
                    $("#adicionar").css("display", "");
                    
                $("#aluno" + id).remove();
                
                if ($("[name=alunos]").length === 1)
                    $(".deletar").css("display", "none");
            }
        </script>
    </body>
</html>