package DAO;

import Model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;

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
            stmt.setString(1, alunoAtv.getAtividade().get(0));
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
                stmt.execute();
                rs = (ResultSet) stmt.getResultSet();
                while (rs.next())
                    alunos.add(new AlunoAtividade(rs.getString(1), new ArrayList<String>(Arrays.asList(rs.getString(2).split("/")))));                
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
                stmt.setInt(1, p.getId());
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
    
    public boolean realizaPostagem(Atividade atividade, Usuario usuario, Postagem postagem) {
        try {
            Integer codigo;            
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call realizaPostagem(?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());      
            stmt.setInt(2, usuario.getId());
            stmt.setString(3, postagem.getTitulo());
            stmt.setString(4, postagem.getTexto());
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next()) {
                codigo = rs.getInt(1);
            } else return false;
            rs.close();
            stmt.close();
            
            for (String midia : postagem.getMidias()) {
                // Cria o comando
                stmt = conn.prepareCall("{ call insereMidia(?, ?) }");
                // Recupera os dados
                stmt.setInt(1, codigo);
                stmt.setString(2, midia);                
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
    
    public Postagem recuperaPostagem(Integer id) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call recuperaPostagem(?) }");
            // Recupera os dados
            stmt.setInt(1, id);            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            
            Postagem postagem;
            
            if (rs.next())                 
                postagem = new Postagem(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getTimestamp(4), rs.getString(5));                        
            else
                return null;
            
            rs.close();
            stmt.close();
                                    
            ArrayList<String> midias = new ArrayList<>();
            // Cria o comando
            stmt = conn.prepareCall("{ call recuperaMidiasPostagem(?) }");
            // Recupera os dados
            stmt.setInt(1, postagem.getId());
            // Executa o comando
            stmt.execute();
            rs = (ResultSet) stmt.getResultSet();
            while(rs.next())
                midias.add(rs.getString(1));
            postagem.setMidias(midias);                            
                        
            return postagem;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    } 
    
    public boolean atualizaPostagem(Postagem postagem) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call atualizaPostagem(?, ?, ?) }");
            // Recupera os dados
            stmt.setInt(1, postagem.getId());            
            stmt.setString(2, postagem.getTitulo());
            stmt.setString(3, postagem.getTexto());
            // Executa o comando
            stmt.execute();                                    
            stmt.close();
                                    
           for (String midia : postagem.getMidias()) {
                // Cria o comando
                stmt = conn.prepareCall("{ call insereMidia(?, ?) }");
                // Recupera os dados
                stmt.setInt(1, postagem.getId());
                stmt.setString(2, midia);                
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
    
    public ArrayList<Professor> listaProfessoresAtividade(Atividade atividade) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call listaProfessoresAtividade(?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());                        
            // Executa o comando
            stmt.execute();                                    
            ResultSet rs = (ResultSet) stmt.getResultSet();
            ArrayList<Professor> professores = new ArrayList<>();
            while (rs.next())
                professores.add(new Professor(new Usuario(rs.getInt(1)), new DadosPessoais(rs.getString(2))));            
            return professores;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public ArrayList<Aluno> listaDadosAlunosAtividade(Atividade atividade) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call listaDadosAlunosAtividade(?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());                        
            // Executa o comando
            stmt.execute();                                    
            ResultSet rs = (ResultSet) stmt.getResultSet();
            ArrayList<Aluno> alunos = new ArrayList<>();
            while (rs.next())
                alunos.add(new Aluno(rs.getString(2), rs.getString(4), new Usuario(rs.getInt(1)), new DadosPessoais(rs.getString(5), rs.getString(3))));            
            return alunos;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return null;
    }
    
    public int atualizaAtividade(Atividade atividade) {
         try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call atualizaAtividade(?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, atividade.getCodigo());                        
            stmt.setInt(2, atividade.getAno());
            stmt.setString(3, atividade.getSemestre());
            stmt.setString(4, atividade.getHorario());
            stmt.setBoolean(5, atividade.isConcluida());
            // Executa o comando
            stmt.execute();                                    
            ResultSet rs = (ResultSet) stmt.getResultSet();            
            if (rs.next())
                return rs.getInt(1);
            return -1;
        } catch (SQLException ex) {  
            System.out.println(ex);
        }    
        return -1;
    }
}
