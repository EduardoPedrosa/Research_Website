<%-- 
    Document   : create-test
    Created on : 13/11/2019, 22:59:54
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Aplicação</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="styles/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="styles/styles.css" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>

<body>
    <div class="container col-md-12 justify-content-center">
        <%@include file="header2.jsp"%>
        <div class="row align-items-center full">
            <div class="container col-md-12">
                <div class="row justify-content-center">
                    <div class="col-md-5">
                        <div class='title'>
                            Criar Teste
                        </div>
                        <div class='form-group'>
                            <label for="name">Nome do Teste</label>
                            <input type="text" class="form-control" name="name" id="name" placeholder="Nome" />
                        </div>
                        <div class='form-group'>
                            <label for="description">Descrição do teste</label>
                            <textarea id="description" class="form-control" rows="3" placeholder="Descrição" required></textarea>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center add-button-row">
                    <button class="btn btn-primary button-with-icon">
                        Avançar
                        <i class="material-icons">navigate_next</i>
                    </button>
                </div>
            </div>
        </div>
    </div>

</body>

</html>