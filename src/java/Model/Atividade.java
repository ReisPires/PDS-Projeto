package Model;

public class Atividade {

    private String codigo;
    private String nome;
    private int ano;
    private String semestre;
    private String horario;    

    public Atividade(String codigo, String nome, int ano, String semestre, String horario) {
        this.codigo = codigo;
        this.nome = nome;
        this.ano = ano;
        this.semestre = semestre;
        this.horario = horario;        
    }

    public Atividade(String codigo, String nome) {
        this.codigo = codigo;
        this.nome = nome;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public int getAno() {
        return ano;
    }

    public void setAno(int ano) {
        this.ano = ano;
    }

    public String getSemestre() {
        return semestre;
    }

    public void setSemestre(String semestre) {
        this.semestre = semestre;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }
                
}