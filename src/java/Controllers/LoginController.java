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
import Models.Pesquisador;
/**
 *
 * @author sid
 */
@WebServlet(name = "Login", urlPatterns = {"/login.do"})
public class LoginController extends HttpServlet {
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    
    //verifica se existe email de pesquisador no sistema
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
        //
    }
    
    //adiciona email de pesquisador no sistema
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
        Pesquisador pesquisador = new Pesquisador(request.getParameter("email"), request.getParameter("token"));
        try (PrintWriter out = response.getWriter()){
            boolean ehCadastrado = ServiceFactory.getPesquisadorService().ehCadastrado(pesquisador);
            if(ehCadastrado){
                Integer idPes = ServiceFactory.getPesquisadorService().getId(pesquisador);
                pesquisador.setId(idPes);
                request.getSession().setAttribute("login", pesquisador);
            }
            out.print(ehCadastrado);
        } catch(Exception e){
            request.setAttribute("erro", e);
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.html"); 
            dispatcher.forward(request, response);
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