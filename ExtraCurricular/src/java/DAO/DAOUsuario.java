package DAO;

import Model.*;
import java.sql.*;
import java.util.ArrayList;

public class DAOUsuario extends DAOConnection {        
    
    public DAOUsuario() {
        initConnection();
    }
    
    public int cadastraAdministrador(Administrador administrador) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraAdministrador(?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, administrador.getDadosUsuario().getSenha());            
            stmt.setString(2, administrador.getDadosUsuario().getLogin());  
            stmt.setString(3, administrador.getEmail());            
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
    
    public int cadastraAluno(Aluno aluno) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraAluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, aluno.getDadosUsuario().getSenha());
            stmt.setString(2, aluno.getMatricula());
            stmt.setString(3, aluno.getTurma());
            stmt.setString(4, aluno.getDadosPessoais().getCpf());
            stmt.setString(5, aluno.getDadosPessoais().getNome());  
            stmt.setString(6, aluno.getDadosPessoais().getEmail());
            stmt.setString(7, aluno.getDadosPessoais().getTelefone());                      
            stmt.setString(8, aluno.getDadosPessoais().getSexo());            
            stmt.setString(9, aluno.getDadosPessoais().getEndereco().getPais());
            stmt.setString(10, aluno.getDadosPessoais().getEndereco().getEstado());
            stmt.setString(11, aluno.getDadosPessoais().getEndereco().getCidade());
            stmt.setString(12, aluno.getDadosPessoais().getEndereco().getCep());
            stmt.setString(13, aluno.getDadosPessoais().getEndereco().getBairro());
            stmt.setString(14, aluno.getDadosPessoais().getEndereco().getRua());
            stmt.setString(15, aluno.getDadosPessoais().getEndereco().getNumero());
            stmt.setString(16, aluno.getDadosPessoais().getEndereco().getComplemento());
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
    
    public int cadastraResponsavel(Responsavel responsavel, ArrayList<Aluno> alunos) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraResponsavel(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, responsavel.getDadosUsuario().getSenha());            
            stmt.setString(2, responsavel.getDadosPessoais().getCpf());
            stmt.setString(3, responsavel.getDadosPessoais().getNome());   
            stmt.setString(4, responsavel.getDadosPessoais().getEmail());            
            stmt.setString(5, responsavel.getDadosPessoais().getTelefone());                     
            stmt.setString(6, responsavel.getDadosPessoais().getSexo());            
            stmt.setString(7, responsavel.getDadosPessoais().getEndereco().getPais());
            stmt.setString(8, responsavel.getDadosPessoais().getEndereco().getEstado());
            stmt.setString(9, responsavel.getDadosPessoais().getEndereco().getCidade());
            stmt.setString(10, responsavel.getDadosPessoais().getEndereco().getCep());
            stmt.setString(11, responsavel.getDadosPessoais().getEndereco().getBairro());
            stmt.setString(12, responsavel.getDadosPessoais().getEndereco().getRua());
            stmt.setString(13, responsavel.getDadosPessoais().getEndereco().getNumero());
            stmt.setString(14, responsavel.getDadosPessoais().getEndereco().getComplemento());                        
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next() && rs.getInt(1) != 0)                    
                return rs.getInt(1);
            rs.close();
            stmt.close();
            
            for (Aluno a : alunos) {
                // Cria o comando
                stmt = conn.prepareCall("{ call associaResponsavel(?, ?) }");
                // Recupera os dados
                stmt.setString(1, a.getMatricula());
                stmt.setString(2, responsavel.getDadosPessoais().getCpf());
                // Executa o comando
                stmt.execute();
                rs = (ResultSet) stmt.getResultSet();
                if (rs.next() && rs.getInt(1) != 0)                    
                    return rs.getInt(1);
                rs.close();
                stmt.close();
            }
            return 0;
        } catch (SQLException e) {                          
            System.out.println(e);
        }
        return -1;
    }
    
    public int cadastraProfessor(Professor professor) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraProfessor(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, professor.getDadosUsuario().getSenha());    
            stmt.setString(2, professor.getCodigo());
            stmt.setString(3, professor.getDadosPessoais().getCpf());
            stmt.setString(4, professor.getDadosPessoais().getNome());    
            stmt.setString(5, professor.getDadosPessoais().getEmail());
            stmt.setString(6, professor.getDadosPessoais().getTelefone());            
            stmt.setString(7, professor.getDadosPessoais().getSexo());            
            stmt.setString(8, professor.getDadosPessoais().getEndereco().getPais());
            stmt.setString(9, professor.getDadosPessoais().getEndereco().getEstado());                    
            stmt.setString(10, professor.getDadosPessoais().getEndereco().getCidade());
            stmt.setString(11, professor.getDadosPessoais().getEndereco().getCep());
            stmt.setString(12, professor.getDadosPessoais().getEndereco().getBairro());
            stmt.setString(13, professor.getDadosPessoais().getEndereco().getRua());
            stmt.setString(14, professor.getDadosPessoais().getEndereco().getNumero());
            stmt.setString(15, professor.getDadosPessoais().getEndereco().getComplemento());            
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
    
    public int atualizaDadosPessoais(Usuario usuario, DadosPessoais dadosPessoais) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call atualizaDadosPessoais(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());                
            stmt.setString(2, dadosPessoais.getEmail());
            stmt.setString(3, dadosPessoais.getTelefone());
            stmt.setString(4, dadosPessoais.getSexo());
            stmt.setString(5, dadosPessoais.getEndereco().getPais());
            stmt.setString(6, dadosPessoais.getEndereco().getEstado());
            stmt.setString(7, dadosPessoais.getEndereco().getCidade());
            stmt.setString(8, dadosPessoais.getEndereco().getCep());
            stmt.setString(9, dadosPessoais.getEndereco().getBairro());
            stmt.setString(10, dadosPessoais.getEndereco().getRua());
            stmt.setString(11, dadosPessoais.getEndereco().getNumero());
            stmt.setString(12, dadosPessoais.getEndereco().getComplemento());
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
    
    public DadosPessoais recuperaDadosPessoais(Usuario usuario) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call recuperaDadosPessoais(?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());    
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return new DadosPessoais(rs.getString(1), rs.getString(2), rs.getString(3), new Endereco(rs.getString(4), rs.getString(7), rs.getString(5), rs.getString(6), rs.getString(8), rs.getString(9), rs.getString(10), rs.getString(11)));
        } catch (SQLException e) {                          
            System.out.println(e);
        }
        return null;
    }
    
    public int atualizaSenha(Usuario usuario, String senhaAntiga, String senhaNova) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call atualizaSenha(?, ?, ?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());    
            stmt.setString(2, senhaAntiga);    
            stmt.setString(3, senhaNova);    
            
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
    
    public String recuperaFacebook(Usuario usuario) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call recuperaFacebook(?) }");
            // Recupera os dados
            stmt.setInt(1, usuario.getId());                            
            // Executa o comando
            stmt.execute();
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return rs.getString(1);
        } catch (SQLException e) {                          
            System.out.println(e);
        }
        return "";
    }
}
