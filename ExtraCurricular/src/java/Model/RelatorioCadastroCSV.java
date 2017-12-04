package Model;

public class RelatorioCadastroCSV {
    /* Success */
    public int successProfessor;
    public int successAluno;
    public int successResponsavel;    
    public int successAtividade;
    
    /* Error */
    public int errorProfessor;
    public int errorAluno;    
    public int errorResponsavel;
    public int errorAtividade;   

    public RelatorioCadastroCSV() {
        this.successProfessor = 0;
        this.successAluno = 0;
        this.successResponsavel = 0;
        this.successAtividade = 0;
        this.errorProfessor = 0;
        this.errorAluno = 0;
        this.errorResponsavel = 0;
        this.errorAtividade = 0;
    }    
}
