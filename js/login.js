

if (window.history && window.history.pushState) {
window.history.pushState(null, null, window.location.href);
window.onpopstate = function () {
window.location.replace("/CRM_project/index.cfm?crm=login");
};
}

function togglePassword() {
var pass = document.getElementById("password");
if(pass.type === "password"){
pass.type = "text";
}else{
pass.type = "password";
}
}


function validateLogin(){
    let username = document.getElementsByName("username")[0].value;
    let password = document.getElementById("password").value;

    if(username.trim() === "" || password.trim() === ""){
        document.getElementById("msg").innerText = "Please enter username and password";
        return false;
    }
    return true;
}
