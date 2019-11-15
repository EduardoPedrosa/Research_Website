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
import javax.servlet.RequestDispatcher;
import java.util.logging.Level;
import java.util.logging.Logger;

import Models.Pesquisador;
import Utils.LoginControl;
import Utils.ServiceFactory;
import java.util.ArrayList;



/**
 *
 * @author sid
 */
@WebServlet(name = "CadastroPesquisador", urlPatterns = {"/pesquisador.do"})
public class CadastroPesquisadorController extends HttpServlet {

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
                ArrayList<String> listaPesquisadores = ServiceFactory.getPesquisadorService().getPesquisadores();
                if(request.getParameter("q") != null){
                    listaPesquisadores = null;
                    String busca = request.getParameter("q");
                    listaPesquisadores = ServiceFactory.getPesquisadorService().searchPesquisadores(busca);
                }
                if(listaPesquisadores != null){
                    request.setAttribute("pesquisadores", listaPesquisadores);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("researchers.jsp");
                    dispatcher.forward(request, response);
                }
                
            }  catch (Exception ex) {
            Logger.getLogger(ControllerDeTeste.class.getName()).log(Level.SEVERE, null, ex);
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
        Pesquisador pesquisador = new Pesquisador(request.getParameter("email"));
        ArrayList<String> pesquisadores = null;
        try (PrintWriter out = response.getWriter()){
            if(!ServiceFactory.getPesquisadorService().ehCadastrado(pesquisador)){
               ServiceFactory.getPesquisadorService().adicionarPesquisador(pesquisador);
               pesquisadores = ServiceFactory.getPesquisadorService().getPesquisadores();
               request.setAttribute("pesquisadores", pesquisadores);
                RequestDispatcher dispatcher = request.getRequestDispatcher("researchers.jsp");
                dispatcher.forward(request, response);
            } else {
                out.println("Email já cadastrado no sistema");  
            }
        } catch (Exception e) {
            request.setAttribute("erro", e);
            Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, e);
            RequestDispatcher dispatcher = request.getRequestDispatcher("index..html");
            dispatcher.forward(request, response);
        }
    }
    
    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        LoginControl.checkLogin(request, response);
        Pesquisador pesquisador = new Pesquisador(request.getParameter("email"));
        ArrayList<String> listaPesquisadores = null;
        try(PrintWriter out = response.getWriter()){
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
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
