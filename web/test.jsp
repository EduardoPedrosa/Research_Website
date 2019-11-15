<%-- 
    Document   : test
    Created on : 12/11/2019, 23:49:48
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
            <div class="row justify-content-center">
                <div class="col-md-5">
                    <div class='title'>
                        Nome do teste
                    </div>
                    <div class='subtitle'>
                        Descrição do teste
                    </div>
                </div>
            </div>
            <div class="row justify-content-center add-button-row">
                <div class="row col-md-10 justify-content-between">
                    <button class="btn btn-primary button-with-icon" id="editSaveButton" onclick="edit()">
                        Editar
                        <i class="material-icons">edit</i>
                    </button>
                    <div class="col-9">
                        <div class="row justify-content-end">
                            <button class="btn btn-primary button-with-icon" style="margin-right: 20px" data-toggle="modal" data-target="#myModal3">
                                Chaves disponíveis
                            </button>
                            <button class="btn btn-primary button-with-icon">
                                Criar pergunta
                                <i class="material-icons">add</i>
                            </button>    
                        </div>

                    </div>
                </div>

            </div>
            <div class="container col-md-10 col-12">
                <ul class="list sortable">
                    <li class="question-list ">
                        <i class="material-icons handle">drag_indicator</i>
                        <div class="container">
                            <div class="row">
                                <div class="col-9 item-text">
                                    <p class="test-name">Pergunta 1</span>
                                </div>
                                <div class="col-3 icons">
                                    <button class="icon-button edit">
                                        <i class="material-icons">edit</i>
                                    </button>
                                    <button class="icon-button delete">
                                        <i class="material-icons">delete</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="question-list " >
                        <i class="material-icons handle">drag_indicator</i>
                        <div class="container">
                            <div class="row">
                                <div class="col-9 item-text">
                                    <p class="test-name">Pergunta 2</span>
                                </div>
                                <div class="col-3 icons">
                                    <button class="icon-button edit">
                                        <i class="material-icons">edit</i>
                                    </button>
                                    <button class="icon-button delete">
                                        <i class="material-icons">delete</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </li>

                </ul>
            </div>
            <%@include file="keys.jsp"%>
        </div>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="scripts/jquery.sortable.js"></script>
        <script>
                                function makeSortable(){
                                $('.sortable').sortable({
                                handle: '.handle',
                                });
                                }
                        function makeUnsortable(){
                        $('.sortable').sortable('disable');
                        }

                        function save(){
                        var btn = document.getElementById("editSaveButton")
                                btn.innerHTML = 'Editar <i class="material-icons">edit</i>'
                                btn.onclick = () => edit()
                                makeUnsortable()
                                var handles = document.querySelectorAll(".handle")
                                handles.forEach((item) => {
                                item.style.visibility = 'hidden'
                                })
                        }
                        function edit(){
                        var btn = document.getElementById("editSaveButton")
                                btn.innerHTML = 'Salvar <i class="material-icons">save</i>'
                                btn.onclick = () => save()
                                makeSortable()
                                var handles = document.querySelectorAll(".handle")
                                handles.forEach((item) => {
                                item.style.visibility = 'visible'
                                })
                        }
        </script>
    </body>
</html>