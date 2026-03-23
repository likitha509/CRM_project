/* ======================
ADD CUSTOMER
====================== */
function addCustomer(){

let name=document.getElementById("name").value;
let email=document.getElementById("email").value;
let phone=document.getElementById("phone").value;
let city=document.getElementById("city").value;

if(name=="" || email=="" || phone=="" || city==""){
alert("Please fill all fields");
return;
}
if(name=="" || email=="" || phone=="" || city==""){
alert("Please fill all fields");
return;
}

let phonePattern = /^[0-9]{10}$/;

if(!phonePattern.test(phone)){
alert("Phone number must be exactly 10 digits");
return;
}

if(!email.endsWith("@gmail.com")){
alert("Email must end with @gmail.com");
return;
}

fetch("/rest/crm/customers/add",{

method:"POST",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({
name:name,
email:email,
phone:phone,
city:city
})

})

.then(res=>res.json())

.then(data=>{

alert("Customer Added Successfully");

clearForm();

/* reload page so pagination updates */
location.reload();

})

.catch(err=>{
console.log("Add Error:", err);
});

}


/* ======================
EDIT CUSTOMER
====================== */
function editCustomer(id,name,email,phone,city){

document.getElementById("name").value=name;
document.getElementById("email").value=email;
document.getElementById("phone").value=phone;
document.getElementById("city").value=city;

document.getElementById("editId").value=id;

}


/* ======================
UPDATE CUSTOMER
====================== */
function updateCustomer(){

let id=document.getElementById("editId").value;

if(id==""){
alert("Please select a customer to update");
return;
}

let name=document.getElementById("name").value;
let email=document.getElementById("email").value;
let phone=document.getElementById("phone").value;
let city=document.getElementById("city").value;

fetch("/rest/crm/customers/update",{

method:"PUT",

headers:{
"Content-Type":"application/json"
},

body:JSON.stringify({
id:id,
name:name,
email:email,
phone:phone,
city:city
})

})

.then(res=>res.json())

.then(data=>{

alert("Customer Updated Successfully");

clearForm();

/* reload page */
location.reload();

})

.catch(err=>{
console.log("Update Error:", err);
});

}


/* ======================
DELETE CUSTOMER
====================== */
function deleteCustomer(id){

if(confirm("Delete this customer?")){

fetch("/rest/crm/customers/delete/"+id,{
method:"DELETE"
})

.then(res=>res.json())

.then(data=>{

alert("Customer Deleted Successfully");

/* reload page */
location.reload();

})

.catch(err=>{
console.log("Delete Error:", err);
});

}

}


/* ======================
CLEAR FORM
====================== */
function clearForm(){

document.getElementById("name").value="";
document.getElementById("email").value="";
document.getElementById("phone").value="";
document.getElementById("city").value="";
document.getElementById("editId").value="";

}


/* ======================
SEARCH CUSTOMER
====================== */
function searchCustomer(){

let input=document.getElementById("searchBox").value.toLowerCase();

let rows=document.querySelectorAll("#customerTable tr");

rows.forEach(function(row){

let text=row.innerText.toLowerCase();

if(text.includes(input)){
row.style.display="";
}else{
row.style.display="none";
}

});

}