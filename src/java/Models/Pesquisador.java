package Models;

public class Pesquisador {
    private String email;
    private String token;
    private Integer id;

    public Pesquisador(String email, String token){
        this.email = email;
        this.token = token;
    }
    
    public Pesquisador(String email){
        this.email = email;
    }
    
    public Pesquisador(String email, String token, Integer id){
        this.email = email;
        this.token = token;
        this.id = id;
    }
    
    public String getEmail(){
        return email;
    }
    public void setEmail(String email){
        this.email = email;
    }
    public String getToken(){
        return token;
    }
    public void setToken(String token){
        this.token = token;
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }
    
}
