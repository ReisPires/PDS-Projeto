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

    public void setMatricula(String matricula) {
        this.matricula = matricula;
    }

    public String getTurma() {
        return turma;
    }

    public void setTurma(String turma) {
        this.turma = turma;
    }

    public Usuario getDadosUsuario() {
        return dadosUsuario;
    }

    public void setDadosUsuario(Usuario dadosUsuario) {
        this.dadosUsuario = dadosUsuario;
    }

    public DadosPessoais getDadosPessoais() {
        return dadosPessoais;
    }

    public void setDadosPessoais(DadosPessoais dadosPessoais) {
        this.dadosPessoais = dadosPessoais;
    }

    public Endereco getEndereco() {
        return endereco;
    }

    public void setEndereco(Endereco endereco) {
        this.endereco = endereco;
    }
    
    
}
