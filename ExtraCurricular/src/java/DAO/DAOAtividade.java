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
        } catch (SQLException e) {                          
            System.out.println(e);
        }    
        return -1;
    }
    
    public int associaProfessor(ProfessorAtividade profAtv) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call associaProfessor(?, ?) }");
            // Recupera os dados
            stmt.setString(1, profAtv.getAtividade());
            stmt.setString(2, profAtv.getProfessor());
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
    
    public int matriculaAluno(AlunoAtividade alunoAtv) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call matriculaAluno(?, ?) }");
            // Recupera os dados
            stmt.setString(1, alunoAtv.getAtividade());
            stmt.setString(2, alunoAtv.getAluno());
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
    
    public ListaAtividades listaAtividades(Usuario usuario) {
         try {             
            ArrayList<Atividade> atividades = new ArrayList<>();
            ArrayList<AlunoAtividade> alunos = null;
            
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
                    stmt = conn.prepareCall("{ call listaAtividadesAdministrador() }");
                    break;
                default:
                    return null;                    
            }                                   
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet(); 
            
            while (rs.next())
                atividades.add(new Atividade(rs.getString(1), rs.getString(2), rs.getBoolean(3)));    
            rs.close();
            stmt.close();
            
            if (usuario.getTipo().compareTo("R") == 0) {            
                alunos = new ArrayList<>();
                stmt = conn.prepareCall("{ call listaAlunosAtividadesResponsavel(?) }");
                stmt.setInt(1, usuario.getId());
                rs = (ResultSet) stmt.getResultSet();
                while (rs.next())
                    alunos.add(new AlunoAtividade(rs.getString(1), rs.getString(2)));
            }
            
            return new ListaAtividades(atividades, alunos);
        } catch (SQLException e) {      
             System.err.println(e);
        }             
        return null;
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
                atividade.setConcluida(rs.getBoolean(5));
                return atividade;
            }
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }    

    public ArrayList<Postagem> listaPostagens(Atividade atividade) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call listaPostagens(?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            ArrayList<Postagem> postagens = new ArrayList<>();            
            while (rs.next())                 
                postagens.add(new Postagem(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5)));                        
            rs.close();
            stmt.close();
                        
            for (Postagem p : postagens) {
                ArrayList<String> midias = new ArrayList<>();
                // Cria o comando
                stmt = conn.prepareCall("{ call recuperaMidiasPostagem(?) }");
                // Recupera os dados
                stmt.setString(1, atividade.getCodigo());
                // Executa o comando
                stmt.execute();
                rs = (ResultSet) stmt.getResultSet();
                
                while(rs.next())
                    midias.add(rs.getString(1));
                p.setMidias(midias);                
            }
                        
            return postagens;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }    
    
   /* public Boolean insereInformacao (Informacao informacao) {
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
    }*/            
}
