<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Cadastro de Conta</title>
        <link rel="stylesheet" type="text/css" href="styles/main.css">
        <style>
            .janela {
                margin: auto;
                
                border: 1px solid black;
                
                padding: 15px;
            }
            
            .grupo {
                margin-bottom: 5px;
            }
            
            input[type=password] {
                width: 160px;
            }
            
            input[type=button] {
                width: 70px;
            }
            
            #cadastrar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Cadastro de conta
            </div>
            <div class="grupo">
                <div><label for="senha">Nova senha:</label></div>
                <div><input id="senha" type="password"/></div>
            </div>
            <div style="margin-top: 15px">
                <input id="retornar" type="button" value="Retornar"/>
                <input id="cadastrar" type="button" value="Cadastrar"/>
            </div>
        </div>
    </body>
</html>