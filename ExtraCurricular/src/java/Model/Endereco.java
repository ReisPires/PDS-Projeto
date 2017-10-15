package Model;

public class Endereco {
    private String pais;
    private String cidade;
    private String cep;
    private String bairro;
    private String rua;
    private Integer numero;
    private String complemento;

    public Endereco(String pais, String cidade, String cep, String bairro, String rua, Integer numero, String complemento) {
        this.pais = pais;
        this.cidade = cidade;
        this.cep = cep;
        this.bairro = bairro;
        this.rua = rua;
        this.numero = numero;
        this.complemento = complemento;
    }   
    
    public Endereco() {
        this.pais = null;
        this.cidade = null;
        this.cep = null;
        this.bairro = null;
        this.rua = null;
        this.numero = null;
        this.complemento = null;
    }
    
    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public String getCidade() {
        return cidade;
    }

    public void setCidade(String cidade) {
        this.cidade = cidade;
    }

    public String getCep() {
        return cep;
    }

    public void setCep(String cep) {
        this.cep = cep;
    }

    public String getBairro() {
        return bairro;
    }

    public void setBairro(String bairro) {
        this.bairro = bairro;
    }

    public String getRua() {
        return rua;
    }

    public void setRua(String rua) {
        this.rua = rua;
    }

    public Integer getNumero() {
        return (numero != null ? numero : 0);
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public String getComplemento() {
        return complemento;
    }

    public void setComplemento(String complemento) {
        this.complemento = complemento;
    }
           
}
