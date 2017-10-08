package Model;

public class Usuario {
    private Integer id;
    private String senha;

    public Usuario(Integer id, String senha) {
        this.id = id;
        this.senha = senha;
    }
    
    public Usuario(String senha) {
        this.id = null;
        this.senha = senha;
    }

    public int getId() {
        return (id != null ? id : 0);
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
        
}
