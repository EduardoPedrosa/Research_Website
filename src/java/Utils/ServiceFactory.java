/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Utils;
import Services.*;

public class ServiceFactory {
    private static PesquisadorService pesquisadorService;
    private static TesteService testeService;
    private static ImagemService imagemService;
    
    //private static LoginService loginService;
    
    /*public static LoginService getLoginService() {
        
        if ( loginService == null ) {
            loginService = new LoginService();
        }
        
        return loginService;
    }*/
    
    public static PesquisadorService getPesquisadorService(){
        if(pesquisadorService == null){
            pesquisadorService = new PesquisadorService();
        }
        
        return pesquisadorService;
    }
    
    public static TesteService getTesteService(){
        if(testeService == null){
            testeService = new TesteService();
        }
        
        return testeService;
    }
    
   public static ImagemService getImagemService(){
       if(imagemService == null){
           imagemService = new ImagemService();
       }
       
       return imagemService;
   }
}
