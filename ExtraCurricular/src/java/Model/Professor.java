package Model;

public class Professor {
    // Exclusivo do professor        
    private String codigo;    
    private String atividades;
    // Gerais
    private Usuario dadosUsuario;
    private DadosPessoais dadosPessoais;    

    public Professor(String codigo, Usuario dadosUsuario, DadosPessoais dadosPessoais) {
        this.codigo = codigo;
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;        
    }             

    /* Para a listagem nas mensagens */
    public Professor(Usuario dadosUsuario, String codigo, String atividades, DadosPessoais dadosPessoais) {        
        this.dadosUsuario = dadosUsuario;
        this.codigo = codigo;
        this.atividades = atividades;
        this.dadosPessoais = dadosPessoais;
    }  

    /* Professores nas atividades */
    public Professor(Usuario dadosUsuario, DadosPessoais dadosPessoais) {
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;
    }        

    public String getCodigo() {
        return codigo;
    }

    public Usuario getDadosUsuario() {
        return dadosUsuario;
    }

    public DadosPessoais getDadosPessoais() {
        return dadosPessoais;
    }

    public String getAtividades() {
        return atividades;
    }
    
    
  
}
