package Model;

public class Administrador {
    // Exclusivo do administrador    
    private String email;
    // Gerais
    private Usuario dadosUsuario;

    public Administrador(String email, Usuario dadosUsuario) {
        this.email = email;
        this.dadosUsuario = dadosUsuario;
    }           

    public String getEmail() {
        return email;
    }

    public Usuario getDadosUsuario() {
        return dadosUsuario;
    }
    
    
}
