function obterDestino() {
    if ($("input[type=radio][name=destino]").length === 0)
        return "professores";
    
    return $("input[type=radio][name=destino]:checked").val();
}

function arraySelecao() {
    switch (obterDestino()) {
    case "atividades":
        return listaAtividades;
    case "professores":
        return listaProfessores;
    case "responsaveis":
        return listaResponsaveis;
    case "alunos":
        return listaAlunos;
    }
    return null; 
}

function mudarDestino() {
    var destino = obterDestino();
    
    if (destino === "todos") {
        $("#selecao-grupo").hide();
        return;
    }

    $("#selecao-grupo").show();
    $("#selecao").val("");
    $("#selecoes").html("Nenhum destinatario selecionado");

    switch (destino) {
    case "atividades":
        $("#selecao-label").html("Atividades:");
        break;
    case "professores": 
        $("#selecao-label").html("Professores:");
        break;
    case "responsaveis":
        $("#selecao-label").html("Responsaveis:");
        break;
    case "alunos":
        $("#selecao-label").html("Alunos:");
        break;
    }

    $("#selecao").autocomplete({lookup: arraySelecao(), onSelect: selecionar});
}

function selecionar() {
    var value = selecao.value;
    selecao.value = "";

    $("#selecao").focus();

    var found = null;
    var array = arraySelecao();
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
        $("#selecoes").html("Nenhum destinatario selecionado");

    $("#selecao").focus();
}