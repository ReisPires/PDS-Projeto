package Model;

public class Aluno {
    // Exclusivo do aluno    
    private String matricula;
    private String turma;    
    // Gerais
    private Usuario dadosUsuario;
    private DadosPessoais dadosPessoais;
    private Endereco endereco;

    public Aluno(String matricula, String turma, Usuario dadosUsuario, DadosPessoais dadosPessoais, Endereco endereco) {
        this.matricula = matricula;
        this.turma = turma;
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;
        this.endereco = endereco;
    }            

    public String getMatricula() {
        return matricula;
    }

    public String getTurma() {
        return turma;
    }

    public Usuario getDadosUsuario() {
        return dadosUsuario;
    }

    public DadosPessoais getDadosPessoais() {
        return dadosPessoais;
    }

    public Endereco getEndereco() {
        return endereco;
    }
    
    
}
