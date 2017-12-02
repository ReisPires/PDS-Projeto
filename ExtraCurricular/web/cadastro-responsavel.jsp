<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>Sistema London - Cadastro de Responsável</title>
        <link rel="stylesheet" type="text/css" href="styles/branco.css"/>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <style>
            .deletar {
                float: right;
                
                margin-left: 8px;
                
                border: none;
                
                width: 28px;
                height: 28px;
                
                background-color: #ff8080;
    
                font-size: 21px;
                font-family: "Segoe UI";
                color: rgb(255, 255, 255);
                line-height: 1.2;
            }
            
            .adicionar {
                margin-top: 10px;
                
                border: none;
                
                width: 260px;
                height: 33px;
    
                font-size: 21px;
                font-family: "Segoe UI";
                color: #404040;
                line-height: 1.2;
            }
        </style>
        <script src="scripts/alunos.js"></script>
    </head>
    <body>
		<div class="frame">
			<img src="img/SistemaLogoGrande.png"/>
			<div class="pagina">Cadastro de Responsável</div>
			<form class="formulario" action="cadastros.html" method="post">
				<input class="campo" type="text" placeholder="CPF" spellcheck="false"/>
				<input class="campo" type="email" placeholder="E-mail" spellcheck="false"/>
				<input class="campo" type="password" placeholder="Senha"/>
				<div id="alunos">
                    <div id="aluno1">
                        <input class="deletar" type="button" value="-" style="display: none" onclick="deletarAluno(1)">
                        <input name="alunos" class="campo" type="text" placeholder="Aluno" spellcheck="false"/>
                    </div>
                </div>
                <input class="adicionar" type="button" value="Adicionar aluno" onclick="adicionarAluno()">
				<div class="botoes">
					<input type="button" value="Retornar" onclick="location.href = 'cadastros.html'"/>
					<input class="submeter" type="submit" value="Cadastrar"/>
				</div>
			</form>
		</div>
    </body>
</html>