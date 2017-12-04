package Model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;

public class Mensagem {    
    private Integer remetente;
    private String nomeRemetente;
    private ArrayList<Integer> destinatarios;
    private String titulo;
    private String dia;
    private String horario;

    public String getNomeRemetente() {
        return nomeRemetente;
    }
    private String texto;    

    /* Envio */
    public Mensagem(Integer remetente, ArrayList<Integer> destinatarios, String titulo, String texto) {
        this.remetente = remetente;
        this.destinatarios = destinatarios;       
        this.titulo = titulo;
        this.texto = texto;
    }
        
    /* Recebimento */
    public Mensagem(String nomeRemetente, String titulo, Timestamp datahora, String texto) {
        this.nomeRemetente = nomeRemetente;      
        this.titulo = titulo;
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(datahora.getTime());           
        this.dia = String.format("%02d", c.get(Calendar.DATE)) + "/" + String.format("%02d", c.get(Calendar.MONTH) + 1) + "/" + String.format("%04d", c.get(Calendar.YEAR));        
        this.horario = String.format("%02d", c.get(Calendar.HOUR)) + ":" + String.format("%02d", c.get(Calendar.MINUTE));
        this.texto = texto;
    }

    public Integer getRemetente() {
        return remetente;
    }

    public String getDia() {
        return dia;
    }

    public String getHorario() {
        return horario;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getTexto() {
        return texto;
    }

    public ArrayList<Integer> getDestinatarios() {
        return destinatarios;
    }        
    
}