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
    
    public boolean leMensagens(Usuario usuario) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call leMensagens(?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());
            // Executa o comando
            return(stmt.execute());            
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }
    
    public boolean enviaMensagem(Mensagem mensagem) {
        try {
            Integer codigo;            
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call criaMensagem(?, ?, ?) }");
            // Recupera os dados
            stmt.setInt(1, mensagem.getRemetente());
            stmt.setString(2, mensagem.getTitulo());
            stmt.setString(3, mensagem.getTexto());
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next()) {
                codigo = rs.getInt(1);
            } else return false;
            rs.close();
            stmt.close();
            
            for (Integer destinatario : mensagem.getDestinatarios()) {
                // Cria o comando
                stmt = conn.prepareCall("{ call enviaMensagem(?, ?) }");
                // Recupera os dados
                stmt.setInt(1, codigo);
                stmt.setInt(2, destinatario);                
                // Executa o comando
                stmt.execute();
                stmt.close();
            }
            
            return true;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }     
        return false;
    }
    
    public ArrayList<Mensagem> listaMensagens(Usuario usuario) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call listaMensagens(?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Mensagem> mensagens = new ArrayList<>();            
            while (rs.next())                 
                mensagens.add(new Mensagem(rs.getString(1), rs.getString(2), rs.getTimestamp(3), rs.getString(4)));            
            return mensagens;          
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }        
}
