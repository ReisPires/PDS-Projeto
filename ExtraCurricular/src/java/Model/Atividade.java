package Model;

public class Atividade {

    private String codigo;
    private String nome;
    private int ano;
    private String semestre;
    private String horario;
    private boolean concluida;

    public Atividade(String codigo, String nome, int ano, String semestre, String horario, boolean concluida) {
        this.codigo = codigo;
        this.nome = nome;
        this.ano = ano;
        this.semestre = semestre;
        this.horario = horario;
        this.concluida = concluida;
    }

    /* Usado para a lista de atividades */
    public Atividade(String codigo, String nome, boolean concluida) {
        this.codigo = codigo;
        this.nome = nome;
        this.concluida = concluida;
    }

    /* Usado para cadastro */
    public Atividade(String codigo, String nome) {
        this.codigo = codigo;
        this.nome = nome;
    }        

    public String getCodigo() {
        return codigo;
    }

    public String getNome() {
        return nome;
    }

    public int getAno() {
        return ano;
    }

    public String getSemestre() {
        return semestre;
    }

    public String getHorario() {
        return horario;
    }

    public boolean isConcluida() {
        return concluida;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public void setConcluida(boolean concluida) {
        this.concluida = concluida;
    }
    
    
}