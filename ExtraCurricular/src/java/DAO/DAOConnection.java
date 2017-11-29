package DAO;

import java.sql.*;

public class DAOConnection {
    
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
    
    public static Connection conn = null;            
}
