package Model;

public class DadosPessoais {
    private String cpf;
    private String email;
    private String telefone;
    private String nome;
    private String sexo;

    public DadosPessoais(String cpf, String email, String telefone, String nome, String sexo) {
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
        this.nome = nome;
        this.sexo = sexo;
    }
    
    // Cadastro de alunos por CSV
    public DadosPessoais(String email, String nome) {
        this.cpf = null;
        this.email = email;
        this.telefone = null;
        this.nome = nome;
        this.sexo = null;
    }
    
    // Cadastro de responsavel por CSV
    public DadosPessoais(String cpf, String email, String telefone) {
        this.cpf = cpf;
        this.email = email;
        this.telefone = telefone;
        this.nome = null;
        this.sexo = null;
    }
        
    public String getCpf() {
        return cpf;
    }

    public void setCpf(String cpf) {
        this.cpf = cpf;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTelefone() {
        return telefone;
    }

    public void setTelefone(String telefone) {
        this.telefone = telefone;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSexo() {
        return sexo;
    }

    public void setSexo(String sexo) {
        this.sexo = sexo;
    }
    
    
}
