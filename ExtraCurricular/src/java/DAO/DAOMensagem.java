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
        } catch (SQLException e) {  
            System.out.println(e);
        }    
        return null;
    }        
    
    public ArrayList<Aluno> listaAlunos(Usuario usuario) {
        try {
            CallableStatement stmt;
            switch (usuario.getTipo()) {
                case "P":
                    stmt = conn.prepareCall("{ call listaAlunosProfessor(?) }");                
                    stmt.setInt(1, usuario.getId());
                    break;
                case "E":
                    stmt = conn.prepareCall("{ call listaAlunosAdministrador() }");                
                    break;
                default:
                    return null;
            }
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Aluno> alunos = new ArrayList<>();            
            while (rs.next())                 
                alunos.add(new Aluno(rs.getString(2), new Usuario(rs.getInt(1)), new DadosPessoais(rs.getString(3))));  
            return alunos;          
        } catch (SQLException e) {  
            System.out.println(e);
        }    
        return null;
    }
    
    public ArrayList<Professor> listaProfessor(Usuario usuario) {
        try {
            CallableStatement stmt;
            switch (usuario.getTipo()) {
                case "A":
                    stmt = conn.prepareCall("{ call listaProfessoresAluno(?) }");                
                    stmt.setInt(1, usuario.getId());
                    break;
                case "R":
                    stmt = conn.prepareCall("{ call listaProfessoresResponsavel(?) }");                
                    stmt.setInt(1, usuario.getId());
                    break;
                case "E":
                    stmt = conn.prepareCall("{ call listaProfessoresAdministrador() }");                
                    break;
                default:
                    return null;
            }
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Professor> professores = new ArrayList<>();            
            while (rs.next())                 
                professores.add(new Professor(new Usuario(rs.getInt(1)), rs.getString(3), new DadosPessoais(rs.getString(2)))); 
            return professores;          
        } catch (SQLException e) {  
            System.out.println(e);
        }    
        return null;
    }
}


