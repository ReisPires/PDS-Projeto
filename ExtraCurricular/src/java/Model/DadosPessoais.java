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
    
    
}
