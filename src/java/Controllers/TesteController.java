/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Models.Teste;
import Models.Pesquisador;
import Utils.LoginControl;
import Utils.ServiceFactory;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author sid
 */
@WebServlet(name = "TesteController", urlPatterns = {"/teste.do"})
public class TesteController extends HttpServlet {

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
        LoginControl.checkLogin(request, response);
        Integer id = null;
        if(request.getParameter("id") != null){
            id = Integer.parseInt(request.getParameter("id"));
        }
        Teste teste = null;
        try {
            if(id != null){
                teste = ServiceFactory.getTesteService().getTeste(id);
            }
            if(teste != null){
                RequestDispatcher dispatcher = request.getRequestDispatcher("test.jsp"); 
                dispatcher.forward(request, response);
            }
        } catch (Exception e){
            request.setAttribute("erro", e);
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.html"); 
            dispatcher.forward(request, response);

        }
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LoginControl.checkLogin(request, response);
        Pesquisador pesquisador = (Pesquisador) request.getSession().getAttribute("login");
        Teste teste = new Teste(request.getParameter("name"), request.getParameter("description"), pesquisador.getId(), 0);
        try  {
            ServiceFactory.getTesteService().salvarTeste(teste);
            Integer id = ServiceFactory.getTesteService().getId(teste);
            if(id != null){
                response.sendRedirect(request.getContextPath()+"/teste.do?id="+teste.getId());
            }
        } catch(Exception e) {
            PrintWriter out = response.getWriter();
            out.print(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}