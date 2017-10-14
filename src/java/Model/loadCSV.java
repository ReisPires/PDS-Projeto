/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DAO.DAOAtividade;
import DAO.DAOUsuario;
import java.io.*;
import java.util.ArrayList;
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
    /*DAOUsuario banco = new DAOUsuario();
        
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
        
    */   DAOUsuario banco = new DAOUsuario();
        
        try {
            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream("professores.csv"), "UTF-8"));
            String line = fileReader.readLine();
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                
                // Le a linha do CSV
                String codigo = csvReader.next();
                String nome = csvReader.next();
                String email = csvReader.next();
                
                // Cadastra o professor
                Professor professor = new Professor(codigo, new Usuario(codigo), new DadosPessoais(email, nome), new Endereco());
                banco.cadastraProfessor(professor);                

            }          
        } catch (Exception ex) {
            System.out.println(ex);
        }
/*     DAOAtividade banco = new DAOAtividade();
       try {
            BufferedReader fileReader = new BufferedReader(new InputStreamReader(new FileInputStream("atividades.csv"), "UTF-8"));
            String line = fileReader.readLine();
            while ((line = fileReader.readLine()) != null) {                
                Scanner csvReader = new Scanner(line);
                csvReader.useDelimiter(",");
                // Le a linha do CSV
                String codigo = csvReader.next();
                String nomeAtividade = csvReader.next();
                String codProfessor = csvReader.next();
                String codAluno = csvReader.next();
                
                // Cadastra a atividade
                Atividade atividade = new Atividade(codigo, nomeAtividade);
                
                if(codProfessor.charAt(0) == 'a'){
                    String[] professores = codProfessor.replace(" ", "").replace("\"", "").split(",");
                    for (String professore : professores) {
                        ProfessorAtividade professorAtividade = new ProfessorAtividade(new Professor(professore, new Usuario(00, "aaa"), new DadosPessoais("00", "aaa"), new Endereco()), atividade);
                        banco.cadastraAtividade(professorAtividade);
                    }  
                }
                else{
                  ProfessorAtividade professorAtividade = new ProfessorAtividade(new Professor(codProfessor, new Usuario(00, "aaa"), new DadosPessoais("00", "aaa"), new Endereco()), atividade);
                    //AlunoAtividade = new ProfessorAtividade(codAluno, atividade);
                    banco.cadastraAtividade(professorAtividade);   
                }

           }          
        } catch (Exception ex) {
            System.out.println(ex);
        }
    */    
    } 
}
