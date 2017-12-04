function preencherAlunos() {        
    $("#selecao-grupo").show();
    $("#selecao").val("");
    $("#selecoes").html("Nenhum aluno selecionado");
    $("#selecao-label").html("Alunos");        
    $("#selecao").autocomplete({lookup: listaAlunos, onSelect: selecionar});
}

function selecionar() {
    var value = selecao.value;
    selecao.value = "";

    $("#selecao").focus();

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
    $(".selecao").each(function () {
        if (value === this.innerText) {
            selecionado = true;
            return false;
        }
    });
    if (selecionado)
        return;

    if ($(".selecao").length === 0)
        $("#selecoes").html("");

    $("<div class='selecao' onclick='deselecionar(this)'>" +
        found.value +
        "<input type='hidden' name='selecao' value='" + found.data + "'/>" + 
    "</div>").appendTo("#selecoes");
}

function deselecionar(elem) {
    $(elem).remove();

    if ($(".selecao").length === 0)
        $("#selecoes").html("Nenhum aluno selecionado");

    $("#selecao").focus();
}