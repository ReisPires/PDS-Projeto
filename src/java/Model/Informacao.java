package Model;

import java.sql.Timestamp;
import java.util.Calendar;

public class Informacao {
    private String nomeProfessor;
    private String codProfessor;
    private String codAtividade;
    private String titulo;
    private String horario;
    private String dia;
    private String texto;
    private String midia;

    public Informacao(String professor, String titulo, Timestamp datahora, String texto, String midia) {
        this.nomeProfessor = professor;
        this.titulo = titulo;        
        this.texto = texto;
        this.midia = midia;
        
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(datahora.getTime());
        this.horario = String.format("%02d", c.get(Calendar.HOUR)) + ":" + String.format("%02d", c.get(Calendar.MINUTE));
        this.dia = String.format("%02d", c.get(Calendar.DATE)) + "/" + String.format("%02d", c.get(Calendar.MONTH) + 1) + "/" + String.format("%04d", c.get(Calendar.YEAR));        
    }

    public Informacao(String codProfessor, String codAtividade, String titulo, String texto, String midia) {
        this.codProfessor = codProfessor;
        this.codAtividade = codAtividade;
        this.titulo = titulo;
        this.texto = texto;
        this.midia = midia;
    }        

    public String getCodProfessor() {
        return codProfessor;
    }

    public void setCodProfessor(String codProfessor) {
        this.codProfessor = codProfessor;
    }

    public String getCodAtividade() {
        return codAtividade;
    }

    public void setCodAtividade(String codAtividade) {
        this.codAtividade = codAtividade;
    }
    
    

    public String getNomeProfessor() {
        return nomeProfessor;
    }

    public void setNomeProfessor(String nomeProfessor) {
        this.nomeProfessor = nomeProfessor;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }   

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public String getMidia() {
        return midia;
    }

    public void setMidia(String midia) {
        this.midia = midia;
    }
    
    
}
