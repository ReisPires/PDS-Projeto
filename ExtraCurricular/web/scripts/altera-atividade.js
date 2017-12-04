function preencherAlunos() {            
    $("#selecao-aluno").val("");
    $("#selecoes-aluno").html("Nenhum aluno selecionado");    
    $("#selecao-aluno").autocomplete({lookup: listaAlunos, onSelect: selecionarAluno});
}

function preencherProfessores() {            
    $("#selecao-professor").val("");
    $("#selecoes-professor").html("Nenhum professor selecionado");    
    $("#selecao-professor").autocomplete({lookup: listaProfessores, onSelect: selecionarProfessor});
}

function selecionarAluno() {
    var value = $("#selecao-aluno").val();
    $("#selecao-aluno").val("");

    $("#selecao-aluno").focus();

    var found = null;
    var array = listaAlunos;
    for (var i in array)
        if (value === array[i].value) {
            found = array[i];
            break;
        }
    if (!found)
        return;

    var selecionado = false;
    $(".selecao-aluno").each(function () {
        if (value === this.innerText) {
            selecionado = true;
            return false;
        }
    });
    if (selecionado)
        return;

    if ($(".selecao-aluno").length === 0)
        $("#selecoes-aluno").html("");

    $("<div class='selecao-aluno' onclick='deselecionarAluno(this)'>" +
        found.value +
        "<input type='hidden' name='selecao-aluno' value='" + found.data + "'/>" + 
    "</div>").appendTo("#selecoes-aluno");
}

function deselecionarAluno(elem) {
    $(elem).remove();

    if ($(".selecao-aluno").length === 0)
        $("#selecoes-aluno").html("Nenhum aluno selecionado");

    $("#selecao-aluno").focus();
}

function selecionarProfessor() {
    var value = $("#selecao-professor").val();
    $("#selecao-professor").val("");

    $("#selecao-professor").focus();

    var found = null;
    var array = listaProfessores;
    for (var i in array)
        if (value === array[i].value) {
            found = array[i];
            break;
        }
    if (!found)
        return;

    var selecionado = false;
    $(".selecao-professor").each(function () {
        if (value === this.innerText) {
            selecionado = true;
            return false;
        }
    });
    if (selecionado)
        return;

    if ($(".selecao-professor").length === 0)
        $("#selecoes-professor").html("");

    $("<div class='selecao-professor' onclick='deselecionarProfessor(this)'>" +
        found.value +
        "<input type='hidden' name='selecao-professor' value='" + found.data + "'/>" + 
    "</div>").appendTo("#selecoes-professor");
}

function deselecionarProfessor(elem) {
    $(elem).remove();

    if ($(".selecao-professor").length === 0)
        $("#selecoes-professor").html("Nenhum professor selecionado");

    $("#selecao-professor").focus();
}