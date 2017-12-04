const MAX_ALUNOS = 5;
var proxAluno = 2;

function adicionarAluno() {
    if ($("[name=alunos]").length === MAX_ALUNOS)
        return;
    
    if ($("[name=alunos]").length === 1) {
        $("[name=alunos]").css("width", "calc(260px - 8px - 28px)");
        $(".deletar").css("display", "");
    }
        
    $("#alunos").append(
        '<div id="aluno' + proxAluno + '">' +
            '<input class="deletar" type="button" value="-" onclick="deletarAluno(' + proxAluno++ + ')"/>' +
            '<input name="alunos" class="campo" type="text" placeholder="Aluno" spellcheck="false" style="width: calc(260px - 8px - 28px)"/>' +
        '</div>'
    );
    
    if ($("[name=alunos]").length === MAX_ALUNOS)
        $(".adicionar").css("display", "none");
}

function deletarAluno(id) {
    if ($("[name=alunos]").length === MAX_ALUNOS)
        $(".adicionar").css("display", "");
        
    $("#aluno" + id).remove();
    
    if ($("[name=alunos]").length === 1) {
        $("[name=alunos]").css("width", "260px");
        $(".deletar").css("display", "none");
   }
}