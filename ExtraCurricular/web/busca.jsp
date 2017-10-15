<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Busca de registro</title>
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
            
            input[type=text], input[type=email] {
                width: 170px;
            }
            
            input[type=button] {
                width: 75px;
            }
            
            #buscar {
                float: right;
            }
        </style>
    </head>
    <body>
        <div class="janela">
            <div style="text-align: center; margin-bottom: 10px">
                Busca de registro
            </div>
            <div class="grupo">
                <div><label for="identidade">CPF ou Matrícula:</label></div>
                <div><input id="identidade" type="text"/></div>
            </div>
            <div class="grupo">
                <div><label for="email">E-mail:</label></div>
                <div><input id="email" type="email"/></div>
            </div>
            <div style="margin-top: 15px">
                <input id="retornar" type="button" value="Retornar"/>
                <input id="buscar" type="button" value="Buscar"/>
            </div>
        </div>
    </body>
</html>