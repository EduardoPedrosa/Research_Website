<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Pesquisador"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://apis.google.com/js/platform.js" async defer></script>
        <script src="scripts/menu.js"></script>
        <script src="scripts/signin.js"></script>
    </head>
    <body>
        <% Pesquisador pesquisador = (Pesquisador) request.getSession().getAttribute("login"); %>
        <input type="hidden" value="<% out.print(pesquisador.getToken());%>" id="token"/>
        <div class="container col-md-12 justify-content-center">
            <div class="row justify-content-between">
                <a href="testes.do">
                    <button class="btn button-back" onClick="goBack()">
                        <span class="back">
                            <i class="material-icons">navigate_before</i>
                            Voltar
                        </span>
                    </button>
                </a>
                <div class="col-2 col-md-1 user" onClick="myFunction()" >
                    <img class="avatar" id="avatar" src="./img/avatar.png"> 
                </div>
                <div id="myDropdown" class="dropdown-content">
                    <a href="pesquisador.do">Gerenciar pesquisadores</a>
                    <a href="logout.do">Sair <i class='material-icons'>exit_to_app</i></a>
                </div>
            </div>
        </div>
    </body>
    <script src="scripts/header.js"></script>
    <script>
    </script>
</html>
