package Services;

import Utils.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Models.Imagem;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import org.apache.commons.fileupload.FileItem;
import java.util.Date;
import java.util.ArrayList;

public class ImagemService {
    public String salvarImagem(FileItem item, Imagem imagem, String caminhoStorage) throws Exception{
        // Cria o diretório caso ele não exista
        File diretorio = new File(caminhoStorage);
        if(!diretorio.exists()){
            diretorio.mkdir();
        }
        // Mandar o arquivo para o diretório informado
        String nome = item.getName();
        //Concatenando timestamp a nome para garantir nome unico
        String nomeSeparado[] = nome.split("\\.");
        Date date = new Date();
        long time = date.getTime();
        String nomeFinal = "";
        for(int i = 0; i < nomeSeparado.length; ++i){
            if(i == nomeSeparado.length-1){
                nomeFinal += Long.toString(time);
                nomeFinal += ".";
            }
            nomeFinal += nomeSeparado[i];
        }
        File file = new File(diretorio, nomeFinal);
        try (FileOutputStream output = new FileOutputStream(file)) {
            InputStream is = item.getInputStream(); 
            byte[] buffer = new byte[2048];
            int nLidos;
            while ((nLidos = is.read(buffer)) >= 0) {
                output.write(buffer, 0, nLidos);
            }
            output.flush();
        }
        //armazenando dados da imagem no banco
        imagem.setEndereco("./storage/"+nomeFinal);
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement("INSERT INTO Imagem (IMG_endereco, IMG_tag) VALUES (?, ?)");
            ps.setString(1, imagem.getEndereco());
            ps.setString(2, imagem.getTag());
            ps.execute();
        } finally {
            if (ps != null){
                ps.close();
            }
            conn.close();
        }
        return imagem.getEndereco();
    }
    
    public ArrayList<String> buscarImagens(String busca) throws Exception{
        Connection conn = DbConnection.getInstance().getConnection();
        PreparedStatement ps = null;
        ResultSet rs = null;
        ArrayList<String> imagens = null;
        try {
            
            ps = conn.prepareStatement("SELECT IMG_endereco FROM Imagem WHERE IMG_tag LIKE ?");
            ps.setString(1, "%"+busca+"%");
            rs = ps.executeQuery();
            imagens = new ArrayList();
            while(rs.next()){
                String caminho = rs.getString("IMG_endereco");
                imagens.add(caminho);   
            }
        } finally {
            if (ps != null){
                ps.close();
            }
            if(rs != null){
                rs.close();
            }
            conn.close();
        }
        return imagens;
    }
}
