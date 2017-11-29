package DAO;

import Model.*;
import java.sql.*;

public class DAOLogin extends DAOConnection {    
    
    public DAOLogin() {
        initConnection();
    }
    
    public Usuario realizaLogin(Usuario usuario) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call realizaLogin(?, ?) }");
            // Recupera os dados
            stmt.setString(1, usuario.getLogin());
            stmt.setString(2, usuario.getSenha());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next()) {
                usuario.setId(rs.getInt(1));
                usuario.setTipo(rs.getString(2));
                return usuario;
            }                               
        } catch (SQLException ex) {                          
        }   
        return null;   
    }
    
    public Usuario realizaPrimeiroAcesso(String login1, String login2, String senha) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call realizaPrimeiroAcesso(?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, login1);
            stmt.setString(2, login2);
            stmt.setString(3, senha);
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return new Usuario(rs.getInt(1), login1, rs.getString(2));                                                            
        } catch (SQLException ex) {              
        }   
        return null; 
    }        
}
