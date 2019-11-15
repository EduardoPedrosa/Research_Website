package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import java.util.List;
import Utils.ServiceFactory;
import Models.Imagem;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import java.util.ArrayList;
import javax.swing.ImageIcon;
import Utils.LoginControl;

/**
 *
 * @author sid
 */
@WebServlet(name = "imagem", urlPatterns = {"/imagem.do"})
public class ImagemController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override 
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String busca = request.getParameter("tagImg");
        ArrayList<String> imagens = null;
        try(PrintWriter out = response.getWriter()) {
            imagens = ServiceFactory.getImagemService().buscarImagens(busca);
            String caminhoImagens = "";
            if(imagens != null){
                for(int i = 0; i < imagens.size(); ++i){
                    caminhoImagens += imagens.get(i);
                    if(i < imagens.size()-1){
                        caminhoImagens += ", ";
                    }
                }
            }            
            out.print(caminhoImagens);
        } catch (Exception e){
            System.out.println(e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOExceptioRequestDispatcher dispatcher = request.getRequestDispatcher("index..html");
                dispatcher.forward(request, response);n if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        boolean isMultiPart = FileUpload.isMultipartContent(request);
        if (isMultiPart) {
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            Imagem imagem = new Imagem();
            
            try(PrintWriter out = response.getWriter()) {
                List items = upload.parseRequest(request);
                Iterator iter = items.iterator();
                FileItem fileItem = null;
                while (iter.hasNext()) {
                    FileItem item = (FileItem) iter.next();
                    if (item.getFieldName().equals("tag")) {
                        imagem.setTag(item.getString());
                    }
                    if (!item.isFormField()) {
                        fileItem = item;
                    }
                }
                String caminhoStorage = getServletContext().getRealPath("/storage");
                String caminho = "";
                if(fileItem != null && fileItem.getName().length() > 0 && imagem.getTag().length() > 2){
                    caminho = ServiceFactory.getImagemService().salvarImagem(fileItem, imagem, caminhoStorage);
                }
                out.println(caminho);

            }
            
            catch (FileUploadException e) {
                request.setAttribute("erro", e);
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
                RequestDispatcher dispatcher = request.getRequestDispatcher("index..html");
                dispatcher.forward(request, response);
            }
            catch (Exception e) {
                request.setAttribute("erro", e);
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
                RequestDispatcher dispatcher = request.getRequestDispatcher("index..html");
                dispatcher.forward(request, response);
            }

        }

    }

   // implementação de demais métodos do Servlet.

}

