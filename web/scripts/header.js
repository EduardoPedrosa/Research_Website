var token = document.getElementById('token').value;
var xhr = new XMLHttpRequest();
var url = 'https://www.googleapis.com/oauth2/v3/tokeninfo?id_token='+token;
xhr.open('GET', url, true)
xhr.onreadystatechange = function() {
    if (xhr.readyState === XMLHttpRequest.DONE) {
        if (xhr.status === 200){ 
            var resp = JSON.parse(xhr.response)
            document.getElementById('avatar').src = resp.picture
            var name = document.getElementById('name')
            if(name){
                name.innerHTML = (', ' + String(resp.name))
            }
        }
    }
}

xhr.send()