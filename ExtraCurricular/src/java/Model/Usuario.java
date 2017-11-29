package Model;

public class Usuario {
    private Integer id;
    private String login;
    private String senha;
    private String tipo;    

    public Usuario(Integer id, String login, String senha, String tipo) {
        this.id = id;
        this.login = login;
        this.senha = senha;
        this.tipo = tipo;
    }

    public Usuario(Integer id, String tipo) {
        this.id = id;
        this.tipo = tipo;
    }        

    public Integer getId() {
        return id;
    }

    public String getLogin() {
        return login;
    }

    public String getSenha() {
        return senha;
    }

    public String getTipo() {
        return tipo;
    }    
}
