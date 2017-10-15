package Model;

public class AlunoAtividade {
    private String aluno;
    private String atividade;

    public AlunoAtividade(String aluno, String atividade) {
        this.aluno = aluno;
        this.atividade = atividade;
    }

    public String getAluno() {
        return aluno;
    }

    public void setAluno(String aluno) {
        this.aluno = aluno;
    }

    public String getAtividade() {
        return atividade;
    }

    public void setAtividade(String atividade) {
        this.atividade = atividade;
    }
    
    
}
