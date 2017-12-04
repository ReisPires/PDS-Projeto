package Model;

public class Responsavel {        
    private Usuario dadosUsuario;
    private DadosPessoais dadosPessoais;    

    public Responsavel(Usuario dadosUsuario, DadosPessoais dadosPessoais) {
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;        
    }      

    public Usuario getDadosUsuario() {
        return dadosUsuario;
    }

    public DadosPessoais getDadosPessoais() {
        return dadosPessoais;
    }  
    
}
