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
    </head>

    <body>
        <div class="container col-md-12 justify-content-center">
            <%@include file="header2.jsp"%>
            <div class="row ">
                <div class="container col-md-12">
                    <div class="row justify-content-center">
                        <div class="col-md-5">
                            <div class='title'>
                                Pergunta 1:
                            </div>
                            <div class="subtitle">
                                Você pode dar uma descrição ou permitir que o usuário informe o id do item a ser avaliado.
                            </div>
                            <div class="row justify-content-center">
                                <div class='form-group'>
                                    <!-- Default checked -->
                                    <div class="custom-control custom-switch">
                                        <input type="checkbox" class="custom-control-input" id="customSwitch" checked onchange="customSwitch()">
                                        <label class="custom-control-label" for="customSwitch">Fornecer descrição?</label>
                                    </div>
                                </div>
                            </div>
                            <div class='form-group' id="description">
                                <textarea id="description" class="form-control" rows="3" placeholder="Descrição" required></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <nav class="nav nav-pills">
                            <a href="#" onClick="handleTab(1)" class="nav-item1 nav-item nav-link active">Contínuo</a>
                            <a href="#" onClick="handleTab(2)" class="nav-item1 nav-item nav-link">Ordinal</a>
                        </nav>
                    </div>
                    <div class="tab">
                        <div class="row justify-content-center">
                            <div class="col-md-4">
                                <div class="row justify-content-center">
                                    <div class="img-visualization">
                                        <img class="image" src="img/avatar.png" alt="imagem"/>
                                        <div class="row justify-content-center">
                                            <button class="icon-button" data-toggle="modal" data-target="#myModal" onClick="active(0)">
                                                <a>
                                                    <i class="material-icons">add</i>
                                                </a>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="row justify-content-center">
                                    <div class="img-visualization">
                                        <img class="image" src="img/avatar.png" alt="imagem"/>
                                        <div class="row justify-content-center">
                                            <button class="icon-button" data-toggle="modal" data-target="#myModal" onClick="active(1)">
                                                <a>
                                                    <i class="material-icons">add</i>
                                                </a>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="row justify-content-center">
                                    <div class="img-visualization">
                                        <img class="image" src="img/avatar.png" alt="imagem"/>
                                        <div class="row justify-content-center">
                                            <button class="icon-button" data-toggle="modal" data-target="#myModal" onClick="active(2)">
                                                <a>
                                                    <i class="material-icons">add</i>
                                                </a>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab" style="display: none">
                        <div class="row justify-content-center">
                            <div class="row col-md-10 justify-content-between label-number">
                                <div>3</div>
                                <div>5</div>
                                <div>7</div>
                            </div>
                            <div class="row col-md-10 justify-content-center">
                                <input class="custom-range" id="range" value="3" onChange="handleChangeQuantityOfImages()" type="range" min="3" max="7" step="2" />
                            </div>
                        </div>
                        <div class="row justify-content-around images-container" id="tab2"  >
                        </div>
                    </div>
                </div>
            </div>
            <div class="row justify-content-center align-items-end save-button">
                <button class="btn btn-primary button-with-icon">
                    Salvar
                    <i class="material-icons">save</i>
                </button>
            </div>
            <%@include file="library.jsp"%>
        </div>
        <script>
            function customSwitch() {
                description = document.getElementById("description");
                customSwitch1 = document.getElementById("customSwitch");
                if (customSwitch1.checked) {
                    description.style.display = "block";
                } else {
                    description.style.display = "none";
                }
            }
            function handleTab(t) {
                tabs = document.querySelectorAll(".tab")
                tabs.forEach((tab) => {
                    tab.style.display = "none"
                })
                tabs[t - 1].style.display = "block"
                tabsa = document.querySelectorAll(".nav-item1")
                tabsa.forEach((tab) => {
                    tab.className = "nav-item1 nav-item nav-link"
                })
                tabsa[t - 1].className = "nav-item1 nav-item nav-link active"
            }

            function handleChangeQuantityOfImages() {
                var tab2 = document.getElementById('tab2')
                var qtd = document.getElementById('range').value
                let content = document.createElement('DIV')
                if (qtd === 3) {
                    content.className = "col-md-4"
                } else if (qtd === 5) {
                    content.className = "col-md-2"
                } else {
                    content.className = "col-md-1"
                }
                
                tab2.innerHTML = ""

                for (let i = 0; i < qtd; i++) {
                    const html = '<div class="row justify-content-center">' +
                        '<div class="img-visualization">' +
                        '<img class="image" src="img/avatar.png" alt="imagem"/>' +
                        '<div class="row justify-content-center">' +
                        '<button class="icon-button" data-toggle="modal" data-target="#myModal" onClick="active('+(i+3)+')">' +
                        '<a>' +
                        '<i class="material-icons">add</i>' +
                        '</a>' +
                        '</button>' +
                        '</div>' +
                        '</div>' +
                        '</div>'
                        content.innerHTML = html
                    tab2.appendChild(content.cloneNode(true))
                }
            }
            
            function active(isActive){
                const divs = document.querySelectorAll(".img-visualization")
                console.log(divs)
                for(div of divs){
                    var first
                    for(child of div.childNodes){
                        if(child.className === "image"){
                            first = child
                        }
                    }
                    first.id = ""
                }
                var img
                for(child of divs[isActive].childNodes){
                    if(child.className === "image"){
                        img = child
                    }
                }
                img.id = "active"
            }
            
            handleChangeQuantityOfImages()


        </script>
    </body>

</html>