package DAO;

import Model.*;
import java.sql.*;
import java.util.ArrayList;

public class DAOAtividade extends DAOConnection {
    
    public DAOAtividade() {
        initConnection();
    }
    
    public int cadastraAtividade(Atividade atividade) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraAtividade(?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());
            stmt.setString(2, atividade.getNome());
            stmt.setInt(3, atividade.getAno());
            stmt.setString(4, atividade.getSemestre());
            stmt.setString(5, atividade.getHorario());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return rs.getInt(1);                       
        } catch (SQLException ex) {                          
        }    
        return -1;
    }
    
    /*public Boolean associaProfessor(ProfessorAtividade profAtv) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call associaProfessor(?, ?) }");
            // Recupera os dados
            stmt.setString(1, profAtv.getAtividade());
            stmt.setString(2, profAtv.getProfessor());
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {  
            System.out.println(ex);
        }
        return false;
    }
    
    public Boolean matriculaAluno(AlunoAtividade alunoAtv) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call matriculaAluno(?, ?) }");
            // Recupera os dados
            stmt.setString(1, alunoAtv.getAtividade());
            stmt.setString(2, alunoAtv.getAluno());
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {  
            System.out.println(ex);
        }
        return false;
    }
    
    public Atividade recuperaAtividade(Atividade atividade) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call recuperaAtividade(?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();                        
            if (rs.next()) {   
                atividade.setNome(rs.getString(1));
                atividade.setAno(rs.getInt(2));
                atividade.setSemestre(rs.getString(3));
                atividade.setHorario(rs.getString(4));
                return atividade;
            } else return null;                                                
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public ArrayList<Atividade> listaAtividades(Usuario usuario) {
         try {             
            ArrayList<Atividade> atividades = new ArrayList<>();  
            
            // Cria o comando
            CallableStatement stmt;
            switch (usuario.getTipo()) {
                case "A":
                    stmt = conn.prepareCall("{ call listaAtividadesAluno(?) }");                                    
                    stmt.setInt(1, usuario.getId()); 
                    break;                    
                case "P":
                    stmt = conn.prepareCall("{ call listaAtividadesProfessor(?) }");                                    
                    stmt.setInt(1, usuario.getId()); 
                    break;
                case "R":
                    stmt = conn.prepareCall("{ call listaAtividadesResponsavel(?) }");                                    
                    stmt.setInt(1, usuario.getId()); 
                    break;
                case "E":
                    stmt = conn.prepareCall("{ call listaAtividadesEscola() }");
                    break;
                default:
                    return atividades;                    
            }                                   
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            while (rs.next())
                atividades.add(new Atividade(rs.getString(1), rs.getString(2)));
            
            return atividades;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public Boolean insereInformacao (Informacao informacao) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call insereInformacao(?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, informacao.getCodAtividade());
            stmt.setString(2, informacao.getCodProfessor());
            stmt.setString(3, informacao.getTitulo());
            stmt.setString(4, informacao.getTexto());
            stmt.setString(5, informacao.getMidia());            
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {  
            System.out.println(ex);
        }
        return false;
    }
    
    public ArrayList<Informacao> exibeInformacoesAtividade(Atividade atividade) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call exibeInformacoesAtividade(?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Informacao> infos = new ArrayList<>();            
            while (rs.next())                 
                infos.add(new Informacao(rs.getString(1), rs.getString(2), rs.getTimestamp(3), rs.getString(4), rs.getString(5)));            
            
            return infos;          
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    */
}
