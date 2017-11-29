package DAO;

import Model.*;
import java.sql.*;
import java.util.ArrayList;

public class DAOMensagem extends DAOConnection {     
    
    public DAOMensagem() {
        initConnection();
    }
    
    public int exibeMensagensNaoLidas(Usuario usuario) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call exibeMensagensNaoLidas(?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return rs.getInt(1);
        } catch (SQLException e) {  
            System.out.println(e);
        }
        return -1;
    }
    
    /*public Boolean enviaMensagem(Mensagem mensagem) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call enviaMensagem(?, ?, ?) }");
            // Recupera os dados
            stmt.setInt(1, mensagem.getRemetente());
            stmt.setInt(2, mensagem.getDestinatario());
            stmt.setString(3, mensagem.getTexto());
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {  
            System.out.println(ex);
        }
        return false;
    }
    
    public ArrayList<Mensagem> exibeMensagens(Usuario usuario) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call exibeMensagens(?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Mensagem> msgs = new ArrayList<>();            
            while (rs.next())                 
                msgs.add(new Mensagem(rs.getInt(1), rs.getInt(2), rs.getTimestamp(3), rs.getString(4), rs.getBoolean(5)));
            
            return msgs;          
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public ArrayList<Mensagem> todasMensagens() {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call exibeTodasMensagens() }");            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Mensagem> msgs = new ArrayList<>();            
            while (rs.next())                 
                msgs.add(new Mensagem(rs.getInt(1), rs.getInt(2), rs.getTimestamp(3), rs.getString(4), rs.getBoolean(5)));
            
            return msgs;          
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }*/
}
