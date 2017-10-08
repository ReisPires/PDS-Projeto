package DAO;

import Model.*;
import java.sql.*;

public class DAOUsuario {
    private static Connection conn = null;    
    
    public static void initConnection() {
        if (conn != null)
            return;
        
        try{
            Class.forName("org.postgresql.Driver").newInstance();
            
            conn = DriverManager.getConnection("jdbc:postgresql:" +
                        "//localhost/ExtraCurricular?user=postgres&password=123");                        
        } catch (Exception e){
        }                
    }
    
    public DAOUsuario() {
        initConnection();
    }
    
    public Boolean cadastraAluno(Aluno aluno) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraAluno(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, aluno.getDadosUsuario().getSenha());
            stmt.setString(2, aluno.getMatricula());
            stmt.setString(3, aluno.getTurma());
            stmt.setString(4, aluno.getDadosPessoais().getCpf());
            stmt.setString(5, aluno.getDadosPessoais().getEmail());
            stmt.setString(6, aluno.getDadosPessoais().getTelefone());
            stmt.setString(7, aluno.getDadosPessoais().getNome());            
            stmt.setString(8, aluno.getDadosPessoais().getSexo());
            stmt.setString(9, aluno.getEndereco().getPais());
            stmt.setString(10, aluno.getEndereco().getCidade());
            stmt.setString(11, aluno.getEndereco().getCep());
            stmt.setString(12, aluno.getEndereco().getBairro());
            stmt.setString(13, aluno.getEndereco().getRua());
            stmt.setInt(14, aluno.getEndereco().getNumero());
            stmt.setString(15, aluno.getEndereco().getComplemento());
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {  
            System.out.println(ex);
        }
        return false;
    }
    
    public Boolean cadastraResponsavel(Responsavel responsavel, Aluno aluno) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraResponsavel(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, responsavel.getDadosUsuario().getSenha());            
            stmt.setString(2, responsavel.getDadosPessoais().getCpf());
            stmt.setString(3, responsavel.getDadosPessoais().getEmail());
            stmt.setString(4, responsavel.getDadosPessoais().getTelefone());
            stmt.setString(5, responsavel.getDadosPessoais().getNome());            
            stmt.setString(6, responsavel.getDadosPessoais().getSexo());
            stmt.setString(7, responsavel.getEndereco().getPais());
            stmt.setString(8, responsavel.getEndereco().getCidade());
            stmt.setString(9, responsavel.getEndereco().getCep());
            stmt.setString(10, responsavel.getEndereco().getBairro());
            stmt.setString(11, responsavel.getEndereco().getRua());
            stmt.setInt(12, responsavel.getEndereco().getNumero());
            stmt.setString(13, responsavel.getEndereco().getComplemento());
            stmt.setString(14, aluno.getMatricula());
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {              
            System.out.println(ex);
        }
        return false;
    }
}
