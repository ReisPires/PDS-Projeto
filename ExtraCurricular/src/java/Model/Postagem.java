package Model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

public class Postagem {
    private Integer id;
    private String professor;
    private String titulo;
    private String dia;
    private String horario;
    private String texto;
    private ArrayList<String> midias;

    /* Visualizacao */
    public Postagem(Integer id, String professor, String titulo, Timestamp datahora, String texto) {
        this.id = id;
        this.professor = professor;
        this.titulo = titulo;
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(datahora.getTime());        
        this.dia = String.format("%02d", c.get(Calendar.DATE)) + "/" + String.format("%02d", c.get(Calendar.MONTH) + 1) + "/" + String.format("%04d", c.get(Calendar.YEAR));        
        this.horario = String.format("%02d", c.get(Calendar.HOUR)) + ":" + String.format("%02d", c.get(Calendar.MINUTE));
        this.texto = texto;        
    }      

    /* Criacao */
    public Postagem(String titulo, String texto, ArrayList<String> midias) {
        this.titulo = titulo;
        this.texto = texto;
        this.midias = midias;
    }        

    public void setMidias(ArrayList<String> midias) {
        this.midias = midias;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getTexto() {
        return texto;
    }

    public ArrayList<String> getMidias() {
        return midias;
    }

    public Integer getId() {
        return id;
    }
            
    
    
}
