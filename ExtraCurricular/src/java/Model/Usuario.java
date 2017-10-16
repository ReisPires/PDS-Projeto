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
    
    public Usuario(Integer id, String senha) {
        this.id = id;        
        this.senha = senha;        
    }

    public Usuario(String login, String senha) {
        this.id = null;
        this.login = login;
        this.senha = senha;
        this.tipo = null;
    }

    public Usuario(Integer id, String login, String tipo) {
        this.id = id;
        this.login = login;
        this.senha = null;
        this.tipo = tipo;
    }          

    public Usuario(Integer id) {
        this.id = id;
    }

    public Usuario(String login) {
        this.login = login;
    }        
            
    public int getId() {
        return (id != null ? id : -1);
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
    
    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getLogin() {
        return login;
    }

    public void setLogin(String login) {
        this.login = login;
    }
    
    
        
}
