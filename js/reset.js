
function validatePassword(){

    let password = document.getElementById("password").value;
    let errorMsg = document.getElementById("errorMsg");

    let pattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    if(!pattern.test(password)){
        errorMsg.innerText = "Password must contain letter, number, special character and be 8+ characters";
        return false;
    }

    errorMsg.innerText = "";
    return true;
}
