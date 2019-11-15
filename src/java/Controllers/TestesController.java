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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;

import Utils.ServiceFactory;
import java.util.ArrayList;
import Models.Teste;
import Utils.LoginControl;
/**
 *
 * @author sid
 */
@WebServlet(name = "Testes", urlPatterns = {"/testes.do"})
public class TestesController extends HttpServlet {

    
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
        try (PrintWriter out = response.getWriter()) {
            LoginControl.checkLogin(request, response); 
            String nome = request.getParameter("nome");
            Integer pagina = 0;
            if(request.getParameter("pag") != null){
                pagina = Integer.parseInt(request.getParameter("pag"));
            }
            ArrayList<Teste> testes = ServiceFactory.getTesteService().listaTestes(nome, pagina);

            if(testes != null){
                request.setAttribute("testes", testes);
                request.setAttribute("ultimaPag", ServiceFactory.getTesteService().ultimaPagina());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("tests.jsp");
            dispatcher.forward(request, response);
        } catch(Exception e){
            request.setAttribute("erro", e);
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            RequestDispatcher dispatcher = request.getRequestDispatcher("erro.jsp");
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
        //processRequest(request, response);
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
