package DAO;

import Model.*;
import java.sql.*;

public class DAOLogin {
    private static Connection conn = null;    
    
    public static void initConnection() {
        if (conn != null)
            return;
        
        try{
            Class.forName("org.postgresql.Driver").newInstance();
            
            conn = DriverManager.getConnection("jdbc:postgresql:" +
                        "//localhost/ExtraCurricular?user=postgres&password=y7s6s9");                        
        } catch (Exception e){
        }                
    }
    
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
            else
                return null;            
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public Usuario realizaPrimeiroAcesso(String login1, String login2) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call realizaPrimeiroAcesso(?, ?) }");
            // Recupera os dados
            stmt.setString(1, login1);
            stmt.setString(2, login2);            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return new Usuario(rs.getInt(1), login1, rs.getString(2));                                     
            return null;            
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public Boolean atualizaSenha(Integer id, String senhaAntiga, String senhaNova) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call atualizaSenha(?, ?, ?) }");
            // Recupera os dados
            stmt.setInt(1, id);
            stmt.setString(2, senhaAntiga);
            stmt.setString(3, senhaNova);
            // Executa o comando
            return (stmt.execute());            
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return false;
    }
}
