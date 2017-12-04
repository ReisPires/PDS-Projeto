var alunos = new Map();
var atividades = new Map();

var id = 1;

function adicionarAluno(nome, atividadesAluno) {
    alunos.set(id, {nome: nome, atividades: atividadesAluno, elem: 
        $('<label class="checkbox" for="aluno' + id + '">' +
            '<input id="aluno' + id + '" type="checkbox" onchange="atualizarAtividades()" checked/>' +
            '<span>' + nome + '</span>' +
        '</label>').appendTo("#alunos")});
    
    for (var i in atividadesAluno) {
        var atividade = atividades.get(atividadesAluno[i]);
        if (atividade == null) {
            atividade = {alunos: []};
            atividades.set(atividadesAluno[i], atividade);
        }
        
        atividade.alunos.push(id);
    }
        
    ++id;
}

function adicionarAtividade(id, nome, concluida) {
    var atividade = atividades.get(id);
    
    if (atividade == null) {
        atividade = {alunos: []};
        atividades.set(id, atividade);
    }
    
    if ("elem" in atividade)
        return;
    
    var nomes = [];
    for (var i in atividade.alunos)
        nomes.push(alunos.get(atividade.alunos[i]).nome);
        
    atividade.nome = nome;
    atividade.concluida = concluida;
    atividade.elem =
        $('<a class="painel" href="atividade.jsp?codigo=' + id + '" style="display: ' + (concluida ? 'none' : 'block') + '">' +
            '<div class="titulo">' + nome + '</div>' +
            '<div class="alunos">' + nomes.join(", ") + '</div>' +
        '</a>').appendTo(".atividades");
}

function atualizarAtividades() {
    var visiveis = new Set();
    
    for (var aluno of alunos)
        if ($("#aluno" + aluno[0]).prop("checked"))
            for (var i of aluno[1].atividades) {
                var atividade = atividades.get(i);
                
                if (!atividade.concluida && !$("#em-andamento").prop("checked"))
                    continue;
                if (atividade.concluida && !$("#concluidas").prop("checked"))
                    continue;
                
                visiveis.add(i);
            }
            
    if (alunos.size === 0) {
        for (var atividade of atividades) {
            if (!atividade[1].concluida && !$("#em-andamento").prop("checked"))
                continue;
            if (atividade[1].concluida && !$("#concluidas").prop("checked"))
                continue;

            visiveis.add(atividade[0]);
        }
    }
            
    var invisiveis = new Set();
    for (var atividade of atividades.keys())
        if (!visiveis.has(atividade))
            invisiveis.add(atividade);
            
    for (var i of visiveis)
        atividades.get(i).elem.show();
    for (var i of invisiveis)
        atividades.get(i).elem.hide();
}