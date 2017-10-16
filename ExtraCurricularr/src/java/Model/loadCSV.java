/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

import DAO.*;
import java.io.*;
import java.util.ArrayList;
import java.util.Scanner;

/**
 *
 * @author Pedro Pires
 */
public class loadCSV {
   
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
       /* DAOUsuario banco = new DAOUsuario();
        
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
     
       DAOAtividade bancoAtv = new DAOAtividade();
       
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
                String[] professores = codProfessor.replace(" ", "").replace("\"", "").split("/");
                String[] alunos = codAluno.replace(" ", "").replace("\"", "").split("/");
                
                Atividade atividade = new Atividade(codigo, nomeAtividade);                
                bancoAtv.cadastraAtividade(atividade);
                
                for (String prof : professores)                   
                    bancoAtv.associaProfessor(new ProfessorAtividade(codigo, prof));                 
                
                for (String aluno : alunos)                   
                    bancoAtv.matriculaAluno(new AlunoAtividade(aluno, codigo));
                
            }
        } catch (Exception ex) {
            System.out.println(ex);
        } */
       
       //DAOLogin log = new DAOLogin();
       //log.realizaLogin(new Usuario("104099", "ABCDE"));               
       /*if (log.atualizaSenha(6, "42748724190", "senhas"))
            System.out.println("true");
       else
            System.out.println("false");*/
       //log.realizaPrimeiroAcesso("90790064787", "pai.105328.18@gmail.com");
       
    //  DAOAtividade atv = new DAOAtividade();
       /*ArrayList<Atividade> atvs = atv.listaAtividades(new Usuario(3078, "aaa", "P"));
       for (int i = 0; i < atvs.size(); ++i) {
           System.out.println(atvs.get(i).getCodigo());
           System.out.println(atvs.get(i).getNome());
       }*/
      
     /*  ArrayList<Informacao> infos = atv.exibeInformacoesAtividade(new Atividade("11", "abc"));
       for (int i = 0; i < infos.size(); ++i) {
           System.out.println(infos.get(i).getNomeProfessor());
           System.out.println(infos.get(i).getTitulo());
           System.out.println(infos.get(i).getHorario());
           System.out.println(infos.get(i).getDia());
           System.out.println(infos.get(i).getTexto());
           System.out.println(infos.get(i).getMidia());
           
       }*/
     
     //atv.insereInformacao(new Informacao("2754", "22", "Truque", "Truque enviado pelo cara", null));
     
    // DAOMensagem m = new DAOMensagem();
     
     //m.enviaMensagem(new Mensagem(3, 4, "ABCDEFG"));
     //m.enviaMensagem(new Mensagem(8, 4, "ABCDEFG"));
     /*ArrayList<Mensagem> ms = m.exibeMensagens(new Usuario(4, "abc"));
     for (int i = 0; i < ms.size(); ++i) {
           System.out.println(ms.get(i).getRemetente());                      
           System.out.println(ms.get(i).getDestinatario());                      
           System.out.println(ms.get(i).getDia());                      
           System.out.println(ms.get(i).getHorario());                      
           System.out.println(ms.get(i).getTexto());                      
           System.out.println(ms.get(i).getLida());
       }*/
    } 
}
