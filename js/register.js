function validateRegister(){

    let username = document.getElementById("username").value.trim();
    let password = document.getElementById("password").value.trim();
    let confirmPassword = document.getElementById("confirmPassword").value.trim();
    let email = document.getElementById("email").value.trim();
    let msg = document.getElementById("msg");

    // Clear previous message
    msg.innerText = "";

    // Empty fields check
    if(username === "" || password === "" || confirmPassword === "" || email === ""){
        msg.innerText = "All fields are required";
        return false;
    }

    // Strong password validation
    let passwordPattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$/;

    if(!passwordPattern.test(password)){
        msg.innerText = "Password must contain uppercase, lowercase, number, special character and be 8+ characters";
        return false;
    }

    // Confirm password match
    if(password !== confirmPassword){
        msg.innerText = "Passwords do not match";
        return false;
    }

    // Email validation
    let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if(!emailPattern.test(email)){
        msg.innerText = "Enter a valid email address";
        return false;
    }

    // Prevent multiple submissions
    document.getElementById("submitBtn").disabled = true;

    return true;
}