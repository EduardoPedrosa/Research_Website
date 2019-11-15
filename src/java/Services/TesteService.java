package Services;

import Models.Teste;
import java.util.ArrayList;
import Utils.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class TesteService {
    private static final int QTD_PAGINACAO = 1;

    public ArrayList<Teste> listaTestes(String nome, Integer pagina) throws Exception {
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<Teste> testes = null;
        try {
            if(nome != null){
                ps = conn.prepareStatement("SELECT TES_titulo, TES_descricao, TES_visibilidade, TES_createdAt FROM Teste "
                        + "WHERE TES_titulo LIKE ? OR TES_descricao LIKE ? LIMIT ?,?");
               ps.setString(1, "%"+nome+"%");
               ps.setString(2, "%"+nome+"%");
               ps.setInt(3, pagina*QTD_PAGINACAO);
               ps.setInt(4, QTD_PAGINACAO);
            } else {
                ps = conn.prepareStatement("SELECT TES_titulo, TES_descricao, TES_visibilidade, TES_createdAt FROM Teste "
                        + "LIMIT ?,?");
                ps.setInt(1, pagina*QTD_PAGINACAO);
                ps.setInt(2, QTD_PAGINACAO);
            }
            rs = ps.executeQuery();
            testes = new ArrayList();
            while(rs.next()){
                Teste teste = new Teste();
                teste.setTitulo(rs.getString("TES_titulo"));
                teste.setDescricao(rs.getString("TES_descricao"));
                teste.setVisibilidade(rs.getInt("TES_visibilidade"));
                teste.setCreatedAt(rs.getTimestamp("TES_createdAt"));

                testes.add(teste);
            }
        } finally {
            if(ps != null){
                ps.close();
            }
            if(rs != null){
                rs.close();
            }
            conn.close();
        }

        return testes;
    }
    
    public Integer ultimaPagina() throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Integer ultimaPag = 0;
        try {
            ps = conn.prepareStatement("SELECT count(*) FROM Teste");
            rs = ps.executeQuery();
            if(rs.next()){
                ultimaPag= (rs.getInt("count(*)")/QTD_PAGINACAO) - 1;
            }
        } finally{
            if(ps != null){
                ps.close();
            }
            if(rs != null){
                rs.close();
            }
            conn.close();
        }
        
        return ultimaPag;
    }
    
    public String gerarCSV(int idTeste)throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        Integer ultimaPag = 0;
        String conteudo = "";
        try {
            ps = conn.prepareStatement("CALL answers_to_csv(?)");
            ps.setInt(1, idTeste);
            rs = ps.executeQuery();
            if(rs.next()){
                conteudo= rs.getString("@write_data");
            }
            System.out.println("contudo");
        } finally{
            if(ps != null){
                ps.close();
            }
            if(rs != null){
                rs.close();
            }
            conn.close();
        }
        return conteudo;
    }
}