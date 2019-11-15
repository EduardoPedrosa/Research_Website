/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.Pesquisador;
import Utils.LoginControl;
import Utils.ServiceFactory;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Eduardo
 */
@WebServlet(name = "DeletarPesquisadorController", urlPatterns = {"/pesquisador-deletar.do"})
public class DeletarPesquisadorController extends HttpServlet {

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
        System.out.println(request.getParameter("email"));
        Pesquisador pesquisador = new Pesquisador(request.getParameter("email"));
        ArrayList<String> listaPesquisadores = null;
        try{
            if(ServiceFactory.getPesquisadorService().ehCadastrado(pesquisador)){
                ServiceFactory.getPesquisadorService().deletarPesquisadores(pesquisador);
                listaPesquisadores = ServiceFactory.getPesquisadorService().getPesquisadores();
                request.setAttribute("pesquisadores", listaPesquisadores);
                RequestDispatcher dispatcher = request.getRequestDispatcher("researchers.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            System.out.println(e);
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
//        processRequest(request, response);
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
