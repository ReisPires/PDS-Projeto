package Model;

import java.sql.Timestamp;
import java.util.Calendar;

public class Mensagem {
    private Integer remetente;
    private Integer destinatario;
    private String dia;
    private String horario;
    private String texto;
    private Boolean lida;

    public Mensagem(Integer remetente, Integer destinatario, String texto) {
        this.remetente = remetente;
        this.destinatario = destinatario;
        this.texto = texto;
    }

    public Mensagem(Integer remetente, Integer destinatario, Timestamp datahora, String texto, Boolean lida) {
        this.remetente = remetente;
        this.destinatario = destinatario;        
        this.texto = texto;
        this.lida = lida;
        
        Calendar c = Calendar.getInstance();
        c.setTimeInMillis(datahora.getTime());
        this.horario = String.format("%02d", c.get(Calendar.HOUR)) + ":" + String.format("%02d", c.get(Calendar.MINUTE));
        this.dia = String.format("%02d", c.get(Calendar.DATE)) + "/" + String.format("%02d", c.get(Calendar.MONTH) + 1) + "/" + String.format("%04d", c.get(Calendar.YEAR));        
    }

    public Integer getRemetente() {
        return remetente;
    }

    public void setRemetente(Integer remetente) {
        this.remetente = remetente;
    }

    public Integer getDestinatario() {
        return destinatario;
    }

    public void setDestinatario(Integer destinatario) {
        this.destinatario = destinatario;
    }

    public String getDia() {
        return dia;
    }

    public void setDia(String dia) {
        this.dia = dia;
    }

    public String getHorario() {
        return horario;
    }

    public void setHorario(String horario) {
        this.horario = horario;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public Boolean getLida() {
        return lida;
    }

    public void setLida(Boolean lida) {
        this.lida = lida;
    }
    
    
    
}
