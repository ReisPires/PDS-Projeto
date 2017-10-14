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
public class ProfessorAtividade {
    private Professor professor;
    private Atividade atividade;

    public ProfessorAtividade(Professor professor, Atividade atividade) {
        this.professor = professor;
        this.atividade = atividade;
    }

    public Professor getProfessor() {
        return professor;
    }

    public void setProfessor(Professor professor) {
        this.professor = professor;
    }

    /**
     *
     * @return
     */
    public Atividade getAtividade() {
        return atividade;
    }

    public void setAtividade(Atividade atividade) {
        this.atividade = atividade;
    }
    
    
}
