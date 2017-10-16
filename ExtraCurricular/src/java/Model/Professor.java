package Model;

public class Professor {
    // Exclusivo do professor        
    private String codigo;    
    // Gerais
    private Usuario dadosUsuario;
    private DadosPessoais dadosPessoais;
    private Endereco endereco;

    public Professor(String codigo, Usuario dadosUsuario, DadosPessoais dadosPessoais, Endereco endereco) {
        this.codigo = codigo;
        this.dadosUsuario = dadosUsuario;
        this.dadosPessoais = dadosPessoais;
        this.endereco = endereco;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
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
