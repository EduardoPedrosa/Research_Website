/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
/**
 *
 * @author aluno
 */
public class LoginControl {
    public static void checkLogin(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException{
        if(request.getSession().getAttribute("login") == null) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("index.html"); 
            dispatcher.forward(request, response);
        }
    }
}
