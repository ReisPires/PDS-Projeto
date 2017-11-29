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

    public void setAtividades(ArrayList<Atividade> atividades) {
        this.atividades = atividades;
    }

    public ArrayList<AlunoAtividade> getAlunos() {
        return alunos;
    }

    public void setAlunos(ArrayList<AlunoAtividade> alunos) {
        this.alunos = alunos;
    }
    
    
}
