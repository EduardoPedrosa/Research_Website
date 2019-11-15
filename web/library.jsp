<%-- 
    Document   : library
    Created on : 12/11/2019, 18:35:01
    Author     : Eduardo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Aplicação</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" type="text/css" href="styles/styles.css" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>

<body>
    <!-- Button trigger modal -->
    <!-- Button trigger modal -->
    <!-- Button to Open the Modal -->

    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog" style="max-width: 800px; width: 800px; ">
            <div class="modal-content" style="min-height: 500px">
                <!-- Modal body -->
                <div class="modal-body">
                    <div class="row justify-content-center">
                        <nav class="nav nav-pills">
                            <a href="#" onClick="handleTab2(1)" class="nav-item2 nav-item nav-link active">Upload</a>
                            <a href="#" onClick="handleTab2(2)" class="nav-item2 nav-item nav-link">Galeria</a>
                        </nav>
                    </div>
                    <div class="row justify-content-center">
                        <div class="tab2">
                            <form id="imgForm" enctype="multipart/form-data" >
                                <div class="row justify-content-center">
                                    <img id="img-preview" style="display: none" />
                                </div>
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text" id="inputGroupFileAddon01">Upload</span>
                                    </div>
                                    <div class="custom-file">
                                        <input type="file" name="image" class="custom-file-input" id="file-input"
                                            aria-describedby="inputGroupFileAddon01" accept="image/*"
                                            onChange="loadImage()">
                                        <label class="custom-file-label" for="file-input">Escolha a imagem</label>
                                    </div>
                                </div>
                                <div class='form-group' style="margin-top: 20px">
                                    <label for="tag">Tag da imagem</label>
                                    <input type="text" class="form-control" name="tag" id="tag" placeholder="Tag" />
                                </div>
                                <div class="row justify-content-center">
                                    <div id="error-text" class="error-text"></div>
                                </div>
                                <div class="row justify-content-center align-items-end save-img-button">
                                    <button type="submit" class="btn btn-primary button-with-icon">
                                        Salvar
                                        <i class="material-icons">save</i>
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="tab2" style="display: none; width: 100%;">
                            <div class="row justify-content-center">
                                <div class="col-md-8 search" style="margin: 5px;">
                                    <form id="searchImgForm">
                                        <input type="text" class="form-control" name="tagImg" placeholder="Pesquisar" id="search-img"/>
                                        <button class="input-button" type="submit">
                                            <i class="material-icons input-icon">search</i>
                                        </button>
                                    </form>
                                    
                                </div>
                            </div>
                            <div class="row " id="gallery-images" style="margin: 10px;">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
    <script>
        function handleTab2(t) {
            tabs = document.querySelectorAll(".tab2")
            tabs.forEach((tab) => {
                tab.style.display = "none"
            })
            tabs[t - 1].style.display = "block"
            tabsa = document.querySelectorAll(".nav-item2")
            tabsa.forEach((tab) => {
                tab.className = "nav-item2 nav-item nav-link"
            })
            tabsa[t - 1].className = "nav-item2 nav-item nav-link active"
        }
        function loadImage() {
            const input = document.getElementById('file-input')
            if (input.files && input.files[0]) {
                var reader = new FileReader();

                reader.onload = function (e) {
                    $('#img-preview')
                        .attr('src', e.target.result)
                        .height(200)
                        .show();
                };

                reader.readAsDataURL(input.files[0]);
            }
        }

        function chooseImage(img){
            const activeInput = document.getElementById('active')
            activeInput.src = img
            $("#myModal").modal("hide")
        }

        function loadImages(data) {
            const gallery = document.getElementById('gallery-images')
            //            fazer requisicao das imagens pela pesquisa
            gallery.innerHTML = ""
            if(data && data[0] !== ""){
                data.forEach((img) => {
                    const content = document.createElement('DIV')
                    content.className = "col-md-3 gallery-item"
                    content.innerHTML = '<div class="row justify-content-center" onClick="chooseImage(\''+img.toString()+'\')"><img width="180px" height="180px" style="cursor: pointer" src="' + img + '" /></div>'
                    gallery.appendChild(
                        content
                    )
                })  
            }
            
        }
        
        $('#searchImgForm').submit(function(event){
            event.preventDefault()
            const q = document.getElementById("search-img").value
            if(q != ""){
                $.ajax({
                        type: "GET",
                        url: "imagem.do",
                        data: $(this).serialize(),
                        success: function(response) {
                            const data = response.split(',')
                            loadImages(data)
                        },
                        catch: function(response) {
                            console.log(response)
                        }
                    })
            }
        })
        
        $('#imgForm').submit(function(event){
            document.getElementById("error-text").innerHTML = ""
            event.preventDefault()
            const files = document.getElementById("file-input").files
                if($(this)[0].tag.value && files.length !== 0){
                    $.ajax({
                        type: "POST",
                        url: "imagem.do",
                        data: new FormData($(this)[0]),
                        cache: false,
                        contentType: false,
                        processData: false,
                        success: function(response) {
                            const activeInput = document.getElementById('active')
                            activeInput.src = response
                            document.getElementById("imgForm").reset()
                            document.getElementById("img-preview").style.display = "none"
                            $("#myModal").modal("hide")
                        },
                        catch: function(response) {
                            console.log(response)
                        }
                    })
                } else {
                    document.getElementById("error-text").innerHTML = "Preencha todos os dados"
                }
                
            }
        )
            
        
        loadImages()
    </script>
</body>

</html>