/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Model;

/**
 *
 * @author William Alves
 */
public class Atividade {;

    String codAtividade;
    String nomeAtividade;
    int anoAtividade;
    String semestreAtividade;
    String horarioAtividade;

    public Atividade(String codAtividade, String nomeAtividade, int anoAtividade, String semestreAtividade, String horarioAtividade) {
        this.codAtividade = codAtividade;
        this.nomeAtividade = nomeAtividade;
        this.anoAtividade = anoAtividade;
        this.semestreAtividade = semestreAtividade;
        this.horarioAtividade = horarioAtividade;
    }

    public Atividade(String codAtividade, String nomeAtividade) {
        this.codAtividade = codAtividade;
        this.nomeAtividade = nomeAtividade;
    }

    public String getCodAtividade() {
        return codAtividade;
    }

    public void setCodAtividade(String codAtividade) {
        this.codAtividade = codAtividade;
    }

    public String getNomeAtividade() {
        return nomeAtividade;
    }

    public void setNomeAtividade(String nomeAtividade) {
        this.nomeAtividade = nomeAtividade;
    }

    public int getAnoAtividade() {
        return anoAtividade;
    }

    public void setAnoAtividade(int anoAtividade) {
        this.anoAtividade = anoAtividade;
    }

    public String getSemestreAtividade() {
        return semestreAtividade;
    }

    public void setSemestreAtividade(String semestreAtividade) {
        this.semestreAtividade = semestreAtividade;
    }

    public String getHorarioAtividade() {
        return horarioAtividade;
    }

    public void setHorarioAtividade(String horarioAtividade) {
        this.horarioAtividade = horarioAtividade;
    }
    
    
    
    
}