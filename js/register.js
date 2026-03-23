function validateRegister(){

    let password = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;

    let passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    if(!passwordPattern.test(password)){
        alert("Password must contain letter, number, special character and be at least 8 characters");
        return false;
    }

    if(password !== confirmPassword){
        alert("Passwords do not match");
        return false;
    }

    return true;
}