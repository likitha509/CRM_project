function validatePassword(){

    let password = document.getElementById("password").value.trim();
    let errorMsg = document.getElementById("errorMsg");

    // Clear previous message
    errorMsg.innerText = "";

    if(password === ""){
        errorMsg.innerText = "Password cannot be empty";
        return false;
    }

    // Same pattern as backend
    let pattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    if(!pattern.test(password)){
        errorMsg.innerText = "Password must contain uppercase, lowercase, number, special character and be 8+ characters";
        return false;
    }

    // Prevent multiple submit
    document.querySelector("button[type='submit']").disabled = true;

    return true;
}