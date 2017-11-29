package DAO;

import Model.*;
import java.sql.*;

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
            CallableStatement stmt = conn.prepareCall("{ call cadastraAluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, aluno.getDadosUsuario().getSenha());
            stmt.setString(2, aluno.getMatricula());
            stmt.setString(3, aluno.getTurma());
            stmt.setString(4, aluno.getDadosPessoais().getCpf());
            stmt.setString(5, aluno.getDadosPessoais().getNome());  
            stmt.setString(6, aluno.getDadosPessoais().getEmail());
            stmt.setString(7, aluno.getDadosPessoais().getTelefone());                      
            stmt.setString(8, aluno.getDadosPessoais().getSexo());
            stmt.setString(9, aluno.getEndereco().getPais());
            stmt.setString(10, aluno.getEndereco().getEstado());
            stmt.setString(11, aluno.getEndereco().getCidade());
            stmt.setString(12, aluno.getEndereco().getCep());
            stmt.setString(13, aluno.getEndereco().getBairro());
            stmt.setString(14, aluno.getEndereco().getRua());
            stmt.setInt(15, aluno.getEndereco().getNumero());
            stmt.setString(16, aluno.getEndereco().getComplemento());
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
    
    public int cadastraResponsavel(Responsavel responsavel, Aluno aluno) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraResponsavel(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, responsavel.getDadosUsuario().getSenha());            
            stmt.setString(2, responsavel.getDadosPessoais().getCpf());
            stmt.setString(3, responsavel.getDadosPessoais().getNome());   
            stmt.setString(4, responsavel.getDadosPessoais().getEmail());            
            stmt.setString(5, responsavel.getDadosPessoais().getTelefone());                     
            stmt.setString(6, responsavel.getDadosPessoais().getSexo());
            stmt.setString(7, responsavel.getEndereco().getPais());
            stmt.setString(8, responsavel.getEndereco().getEstado());
            stmt.setString(9, responsavel.getEndereco().getCidade());
            stmt.setString(10, responsavel.getEndereco().getCep());
            stmt.setString(11, responsavel.getEndereco().getBairro());
            stmt.setString(12, responsavel.getEndereco().getRua());
            stmt.setInt(13, responsavel.getEndereco().getNumero());
            stmt.setString(14, responsavel.getEndereco().getComplemento());
            stmt.setString(15, aluno.getMatricula());
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
    
    public int cadastraProfessor(Professor professor) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraProfessor(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, professor.getDadosUsuario().getSenha());    
            stmt.setString(2, professor.getCodigo());
            stmt.setString(3, professor.getDadosPessoais().getCpf());
            stmt.setString(6, professor.getDadosPessoais().getNome());    
            stmt.setString(4, professor.getDadosPessoais().getEmail());
            stmt.setString(5, professor.getDadosPessoais().getTelefone());            
            stmt.setString(7, professor.getDadosPessoais().getSexo());
            stmt.setString(8, professor.getEndereco().getPais());
            stmt.setString(8, professor.getEndereco().getEstado());                    
            stmt.setString(9, professor.getEndereco().getCidade());
            stmt.setString(10, professor.getEndereco().getCep());
            stmt.setString(11, professor.getEndereco().getBairro());
            stmt.setString(12, professor.getEndereco().getRua());
            stmt.setInt(13, professor.getEndereco().getNumero());
            stmt.setString(14, professor.getEndereco().getComplemento());
            // Executa o comando
            ResultSet rs = (ResultSet) stmt.getResultSet();
            if (rs.next())
                return rs.getInt(1);            
        } catch (SQLException e) {                          
            System.out.println(e);
        }
        return -1;
    }   
}
