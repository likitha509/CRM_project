function validateImage(){

    let fileInput = document.getElementById("profilePic");
    let filePath = fileInput.value;

    let allowedExtensions = /(\.jpg|\.jpeg|\.png)$/i;

    if(!allowedExtensions.exec(filePath)){
        alert("Only JPG, JPEG, PNG files are allowed!");
        fileInput.value = "";
        return false;
    }

    return true;
}