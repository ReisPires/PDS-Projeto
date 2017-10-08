/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DAO.DAOUsuario;
import java.io.*;
import java.util.Scanner;

/**
 *
 * @author Pedro Pires
 */
public class loadCSV {

    public void alunosCSV() {
        
    }
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        DAOUsuario banco = new DAOUsuario();
        
        try {
            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream("alunos.csv"), "UTF-8"));
            String line = fileReader.readLine();
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                
                // Le a linha do CSV
                String rm = csvReader.next();
                String nome = csvReader.next();
                String turma = csvReader.next();
                String emailAluno = csvReader.next();
                String cpfPai = csvReader.next();
                String emailPai = csvReader.next();
                String telefonePai = csvReader.next();
                String cpfMae = csvReader.next();
                String emailMae = csvReader.next();
                String telefoneMae = csvReader.next();  
                
                // Cadastra o aluno
                Aluno aluno = new Aluno(rm, turma, new Usuario(rm), new DadosPessoais(emailAluno, nome), new Endereco());
                banco.cadastraAluno(aluno);                
                // Cadastra o pai
                if (!cpfPai.trim().isEmpty()) {
                    Responsavel pai = new Responsavel(new Usuario(cpfPai), new DadosPessoais(cpfPai, emailPai, telefonePai), new Endereco());
                    banco.cadastraResponsavel(pai, aluno);
                }                
                // Cadastra a mae
                if (!cpfMae.trim().isEmpty()) {
                    Responsavel mae = new Responsavel(new Usuario(cpfMae), new DadosPessoais(cpfMae, emailMae, telefoneMae), new Endereco());
                    banco.cadastraResponsavel(mae, aluno);
                }
            }          
        } catch (Exception ex) {
            System.out.println(ex);
        }
    }
    
}
