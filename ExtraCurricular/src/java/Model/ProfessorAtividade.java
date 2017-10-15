package Model;

public class ProfessorAtividade {
    private String atividade;
    private String professor;

    public ProfessorAtividade(String atividade, String professor) {
        this.atividade = atividade;
        this.professor = professor;
    }    
    
    public String getAtividade() {
        return atividade;
    }

    public void setAtividade(String atividade) {
        this.atividade = atividade;
    }

    public String getProfessor() {
        return professor;
    }

    public void setProfessor(String professor) {
        this.professor = professor;
    }
    
    
}
