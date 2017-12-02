package Model;

public class DadosPessoais {
    private String cpf;
    private String email;
    private String telefone;
    private String nome;
    private String sexo;
    private Endereco endereco;

    public DadosPessoais(String cpf, String email, String telefone, String nome, String sexo, Endereco endereco) {
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
        this.nome = nome;
        this.sexo = sexo;
        this.endereco = endereco;
    }   

    /* Perfil */
    public DadosPessoais(String email, String telefone, String sexo, Endereco endereco) {        
        this.email = email;
        this.telefone = telefone;
        this.sexo = sexo;
        this.endereco = endereco;
    }       

    /* Listagem nas mensagens */
    public DadosPessoais(String nome) {
        this.nome = nome;
    }       

    /* Cadastro por csv de professor */
    public DadosPessoais(String cpf, String email, String nome) {
        this.cpf = cpf;
        this.email = email;
        this.nome = nome;
        this.endereco = new Endereco();
    }        

    /* Cadastro por csv de aluno */
    public DadosPessoais(String email, String nome) {
        this.email = email;
        this.nome = nome;
        this.endereco = new Endereco();
    }        
    
    /* Cadastro por csv de responsavel */
    public DadosPessoais(String cpf, String email, String telefone, String nome) {
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
        this.nome = nome;
        this.endereco = new Endereco();
    }
    

    public String getCpf() {
        return cpf;
    }

    public String getEmail() {
        return email;
    }

    public String getTelefone() {
        return telefone;
    }

    public String getNome() {
        return nome;
    }

    public String getSexo() {
        return sexo;
    }

    public Endereco getEndereco() {
        return endereco;
    }            
}
