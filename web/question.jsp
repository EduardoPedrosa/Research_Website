<%-- 
    Document   : create-question
    Created on : 12/11/2019, 20:48:02
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    </head>

    <body>
        <div class="container col-md-12 justify-content-center">
            <div class="row justify-content-between">
                <button class="btn button-back">
                    <span class="back">
                        <i class="material-icons">navigate_before</i>
                        Voltar
                    </span>
                </button>
            </div>
            <div class="row ">
                <div class="container col-md-12">
                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <div class='title'>
                                Pergunta 1:
                            </div>
                            <div class="subtitle">
                                Descrição da pergunta caso exista
                            </div>
                            <div class='form-group' id="id">
                                <label for="idItem">Identificador do item a ser avaliado</label>
                                <input id="idItem" name="idItem" class="form-control" placeholder="Identificador do item" />
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="row col-md-10 justify-content-center">
                            <input class="custom-range" id="range" value="1" type="range" min="1" max="3" step="1" />
                        </div>
                    </div>

                    <div class="row justify-content-center" style="margin-top: 30px">
                        <div class="col-md-4">
                            <div class="row justify-content-center">
                                <div class="img-visualization">
                                    <img src="img/avatar.png" alt="imagem"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="row justify-content-center">
                                <div class="img-visualization">
                                    <img src="img/avatar.png" alt="imagem"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="row justify-content-center">
                                <div class="img-visualization">
                                    <img src="img/avatar.png" alt="imagem"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row justify-content-center">
                        <div class="row col-md-10 justify-content-center">
                            <input class="custom-range" id="range1" value="0"  type="range" min="0" max="10" step="0.01" />
                        </div>
                    </div>

                </div>
            </div>
            <div class="row justify-content-center align-items-end save-button">
                <div class="row col-md-10 justify-content-between">
                    <button class="btn btn-primary button-with-icon">
                        <i class="material-icons">navigate_before</i>
                        Anterior
                    </button>
                    <button class="btn btn-primary button-with-icon">
                        Próxima
                        <i class="material-icons">navigate_next</i>
                    </button>
                </div>
            </div>
        </div>
        <script>
        </script>
    </body>

</html>