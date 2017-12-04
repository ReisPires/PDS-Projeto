package Model;

import java.util.ArrayList;

public class AlunoAtividade {
    private String aluno;
    private ArrayList<String> atividade;

    public AlunoAtividade(String aluno, ArrayList<String> atividade) {
        this.aluno = aluno;
        this.atividade = atividade;
    }      

    public String getAluno() {
        return aluno;
    }

    public ArrayList<String> getAtividade() {
        return atividade;
    }
    
}
