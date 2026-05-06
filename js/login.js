

// Toggle password
function togglePassword() {
    var pass = document.getElementById("password");
    if(pass.type === "password"){
        pass.type = "text";
    } else {
        pass.type = "password";
    }
}

// Validate login
function validateLogin(){

    let username = document.getElementById("username").value.trim();
    let password = document.getElementById("password").value.trim();
    let msg = document.getElementById("msg");

    // Clear old message
    msg.innerText = "";

    if(username === "" || password === ""){
        msg.innerText = "Please enter username and password";
        return false;
    }

    // Prevent multiple submit
    document.querySelector("button[type='submit']").disabled = true;

    return true;
}