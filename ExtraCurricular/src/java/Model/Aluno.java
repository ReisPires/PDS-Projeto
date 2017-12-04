package Model;

public class Aluno {
    // Exclusivo do aluno    
    private String matricula;
    private String turma;    
    // Gerais
    private Usuario dadosUsuario;
    private DadosPessoais dadosPessoais;    

    public Aluno(String matricula, String turma, Usuario dadosUsuario, DadosPessoais dadosPessoais) {
        this.matricula = matricula;
        this.turma = turma;
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;        
    }         

    /* Retorno das mensagens */
    public Aluno(String matricula, Usuario dadosUsuario, DadosPessoais dadosPessoais) {
        this.matricula = matricula;
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;
    }       
            
    public Aluno(String matricula) {
        this.matricula = matricula;
    }        
    
    /* Dados pessoais */
    public Aluno(String matricula, String turma) {
        this.matricula = matricula;
        this.turma = turma;
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
}
