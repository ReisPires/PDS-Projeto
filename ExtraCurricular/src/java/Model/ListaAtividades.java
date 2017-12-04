package Model;

import java.util.ArrayList;

public class ListaAtividades {
    ArrayList<Atividade> atividades;
    ArrayList<AlunoAtividade> alunos;

    public ListaAtividades(ArrayList<Atividade> atividades, ArrayList<AlunoAtividade> alunos) {
        this.atividades = atividades;
        this.alunos = alunos;
    } 

    public ArrayList<Atividade> getAtividades() {
        return atividades;
    }

    public ArrayList<AlunoAtividade> getAlunos() {
        return alunos;
    }
    
    
    
}
