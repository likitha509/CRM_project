function validateRegister(){

    let password = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;

    // Fixed pattern
    let passwordPattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if(!passwordPattern.test(password)){
        alert("Password must contain at least 1 CAPITAL, 1 small letter, 1 number, 1 special character and be 8+ characters");
        return false;
    }

    if(password !== confirmPassword){
        alert("Passwords do not match");
        return false;
    }

    return true;
}