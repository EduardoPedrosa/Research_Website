<%-- 
    Document   : tests
    Created on : 26/10/2019, 15:56:19
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Models.Pesquisador"%>
<%@page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="styles/styles.css" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <title>Aplicação</title>
        <script src="https://apis.google.com/js/platform.js" async defer></script>
    </head>
    <body>
        <div class="container col-md-12 justify-content-center">
            <% ArrayList<String> pesquisadores = (ArrayList<String>) request.getAttribute("pesquisadores");%>
            <%@include file="header2.jsp"%>
            <div class="row justify-content-center">
                <div class="title">Pesquisadores</div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-5 search">
                    <form method="GET" id="deleteForm" action="pesquisador.do">
                        <input type="text" class="form-control" name="q" placeholder="Pesquisar" />
                        <button class="input-button"><i class="material-icons input-icon">search</i></button>
                    </form>
                </div>
            </div>
            <div class="row col-md-11 justify-content-end add-button-row">
                <button class="btn btn-primary button-with-icon" data-toggle="modal" data-target="#myModal">
                    Adicionar Pesquisador
                    <i class="material-icons">add</i>
                </button>
            </div>
            <div class="container col-md-10 col-12 list" style="margin-bottom: 40px">
                <% for(String p:pesquisadores){%>
                    <div class="item-list dense">                         
                        <div class="container justify-content-between">
                            <div class="row">
                                <div class="col-9 item-text">
                                    <span class="test-name"><%out.print(p);%></span>
                                </div>
                                <div class="col-3 icons">
                                    <form method="GET" id="deleteForm" action="pesquisador-deletar.do">
                                        <button type="submit" class="icon-button delete" data-toggle="modal" data-target="#myModal2">
                                            <i class="material-icons" >delete</i>
                                            <input type="hidden" name="email" value="<%out.print(p);%>" />
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                <% } %>

            </div>
        </div>
        <%@include file="addResearcher.jsp"%>
    </body>
</html>
