package Model;

public class Responsavel {        
    private Usuario dadosUsuario;
    private DadosPessoais dadosPessoais;
    private Endereco endereco;

    public Responsavel(Usuario dadosUsuario, DadosPessoais dadosPessoais, Endereco endereco) {
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;
        this.endereco = endereco;
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
