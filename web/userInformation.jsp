<%-- 
    Document   : userInformation
    Created on : 12/11/2019, 21:55:05
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="styles/bootstrap.min.css" />
        <link rel="stylesheet" type="text/css" href="styles/styles.css" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <title>Aplication</title>
    </head>
    <body>
        <div class="container col-md-12 justify-content-center">
            <div class="row justify-content-between">
                <button class="btn button-back">
                    <div class="back">
                        <i class="material-icons">navigate_before</i>
                        Voltar
                    </div>
                </button>
            </div>
            <div class="row align-items-center full">
                <div class="container col-md-12">
                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <div class='title'>
                                Informações iniciais
                            </div>
                            <div class='form-group'>
                                <label for="email">Email</label>
                                <input type="text" class="form-control" name="email" placeholder="Email" />
                            </div>
                            <div class='form-group'>
                                <label for="age">Idade</label>
                                <input type="text" class="form-control" name="age" placeholder="Idade" />
                            </div>
                            <div class='form-group'>
                                <label for="phone">Telefone</label>
                                <input type="text" class="form-control" name="phone" placeholder="Telefone" />
                            </div>
                            <div class='form-group'>
                                <label for="gender">Sexo</label><br> 
                                <input type="radio" name="gender" placeholder="Email" value="m"/>Masculino
                                <input type="radio" name="gender" placeholder="Email" value="f"/>Feminino
                            </div>
                            <div class='form-group'>
                                <label for="zipcode">CEP</label>
                                <input type="text" class="form-control" id="zipcode" name="zipcode" placeholder="CEP" />
                            </div>
                            <select class="browser-default custom-select">
                                <option selected>Abrir menu</option>
                                <option value="amarela">Amarela</option>
                                <option value="branca">Branca</option>
                                <option value="indigena">Indígena</option>
                                <option value="parda">Parda</option>
                                <option value="preta">Preta</option>
                            </select>
                        </div>
                    </div>
                    <div class="row justify-content-center add-button-row" style="margin-bottom: 20px">
                        <button class="btn btn-primary button-with-icon">
                            Responder Teste
                            <i class="material-icons">navigate_next</i>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
