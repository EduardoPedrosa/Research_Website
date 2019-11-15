package Models;
import java.text.SimpleDateFormat;
import java.util.Date;
/**
 *
 * @author sid
 */
public class Teste {
    private Integer id;
    private String descricao;
    private String titulo;
    private Integer idPesquisador;
    private Integer visibilidade;
    private Date createdAt;
    private Date updatedAt;

    public Teste(){
    }
    
    public Teste(String descricao, String titulo, Integer idPesquisador, Integer visibilidade) {
        this.descricao = descricao;
        this.titulo = titulo;
        this.idPesquisador = idPesquisador;
        this.visibilidade = visibilidade;
    }
    
    public Teste(Integer id, String descricao, String titulo, Integer idPesquisador, Integer visibilidade, Date createdAt, Date updatedAt) {
        this.descricao = descricao;
        this.titulo = titulo;
        this.idPesquisador = idPesquisador;
        this.visibilidade = visibilidade;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    public int getId() {
        return id;
    }

    public String getDescricao() {
        return descricao;
    }

    public String getTitulo() {
        return titulo;
    }

    public Integer getIdPesquisador() {
        return idPesquisador;
    }

    public Integer getVisibilidade() {
        return visibilidade;
    }

    public String getCreatedAt() { 
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String date = fmt.format(createdAt);
        return date;
    }
    
    public String getCreatedAtDay(){
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
        String date = fmt.format(createdAt);
        return date;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public void setEmailPesquisador(Integer idPesquisador) {
        this.idPesquisador = idPesquisador;
    }

    public void setVisibilidade(Integer visibilidade) {
        this.visibilidade = visibilidade;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}