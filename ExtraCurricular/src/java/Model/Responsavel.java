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
