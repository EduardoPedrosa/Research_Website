package Services;

import Utils.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ServiceDeTeste {
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
}
