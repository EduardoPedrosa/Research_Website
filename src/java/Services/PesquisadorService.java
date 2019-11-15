package Services;

import Utils.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Models.Pesquisador;
import java.util.ArrayList;

public class PesquisadorService {
    
    public Boolean ehCadastrado(Pesquisador pesquisador) throws Exception {
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Boolean existeEmail = false;
        try {
            ps = conn.prepareStatement("SELECT PES_email FROM Pesquisador WHERE PES_email = ?");
            ps.setString(1, pesquisador.getEmail());
            rs = ps.executeQuery();
            if(rs.first()){
                existeEmail = true;
            }
        } finally {
           if (ps != null) {
                ps.close();
            }

            if (rs != null) {
                rs.close();
            }

            conn.close();
        }
        
        return existeEmail;
    }
    
    public void adicionarPesquisador(Pesquisador pesquisador) throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        
        try {
            ps = conn.prepareStatement("INSERT INTO Pesquisador (PES_email) VALUES (?)");
            ps.setString(1, pesquisador.getEmail());
            ps.execute();
        } finally {
            if (ps != null){
                ps.close();
            }
            conn.close();
        }
    }
    
    public ArrayList<String> getPesquisadores() throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        ArrayList<String> email = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            ps = conn.prepareStatement("SELECT * from Pesquisador");
            rs = ps.executeQuery();
            email = new ArrayList<>();
            while(rs.next()){
                email.add(rs.getString("PES_email"));
            }   
        } finally {
            if (ps != null) {
                ps.close();
            }

            if (rs != null) {
                rs.close();
            }

            conn.close();
        }
        return email;
    }
    
    public void deletarPesquisadores(Pesquisador pesquisador) throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement("DELETE from Pesquisador WHERE PES_email = ?");
            ps.setString(1, pesquisador.getEmail());
            ps.execute();
        } finally {
             if (ps != null) {
                ps.close();
            }
            conn.close();
        }
        
    }
    
    public ArrayList<String> searchPesquisadores(String mail) throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        ArrayList<String> email = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            System.out.println("MAIL:"+mail);
            ps = conn.prepareStatement("SELECT * from Pesquisador WHERE PES_email LIKE ?");
            ps.setString(1, "%"+mail+"%");
            System.out.println("QUERY:"+ps.toString());
            rs = ps.executeQuery();
            email = new ArrayList<>();
            while(rs.next()){
                email.add(rs.getString("PES_email"));
            }   
        } finally {
            if (ps != null) {
                ps.close();
            }

            if (rs != null) {
                rs.close();
            }

            conn.close();
        }
        System.out.println("SIZE:"+email.size());
        return email;
    }
    
    public Integer getId(Pesquisador pesquisador) throws Exception {
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Integer id = null;
        try {
            ps = conn.prepareStatement("SELECT PES_id FROM Pesquisador WHERE PES_email = ?");
            ps.setString(1, pesquisador.getEmail());
            rs = ps.executeQuery();
            if(rs.first()){
                id = rs.getInt("PES_id");
            }
        } finally {
            if (ps != null) {
                ps.close();
            }
            if (rs != null) {
                rs.close();
            }
            conn.close();
        }
        return id;
    }
}
