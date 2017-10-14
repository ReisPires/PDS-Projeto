package DAO;

import Model.*;
import java.sql.*;

public class DAOAtividade {
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
    
    public DAOAtividade() {
        initConnection();
    }
    
    public Boolean cadastraAtividade(ProfessorAtividade prof) {
        try {
            // Cria o comando
            CallableStatement stmt = conn.prepareCall("{ call cadastraAtividade(?, ?, ?, ?, ?, ?) }");
            // Recupera os dados
            stmt.setString(1, prof.getAtividade().getCodAtividade());
            stmt.setString(2, prof.getAtividade().getNomeAtividade());
            stmt.setInt(3, prof.getAtividade().getAnoAtividade());
            stmt.setString(4, prof.getAtividade().getSemestreAtividade());
            stmt.setString(5, prof.getAtividade().getHorarioAtividade());
            stmt.setString(6, prof.getProfessor().getCodigo());
            // Executa o comando
            return (stmt.execute());
        } catch (SQLException ex) {  
            System.out.println(ex);
        }
        return false;
    }
}