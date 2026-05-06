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

let phonePattern = /^[0-9]{10}$/;

if(!phonePattern.test(phone)){
alert("Phone number must be exactly 10 digits");
return;
}

if(!email.endsWith("@gmail.com")){
alert("Email must end with @gmail.com");
return;
}

fetch("/rest/CRM_App/customers/add",{

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

.then(res => res.text())
.then(text => {

console.log("RAW ADD:", text);

let data = {};
try {
    data = JSON.parse(text);
} catch(e){}

alert(data.message || "Added");

clearForm();
location.reload();

})
.catch(err=>{
console.log("ADD ERROR:", err);
});

}
function loadCustomers(page=1){

fetch("/rest/CRM_App/customers")

.then(res=>res.json())

.then(data=>{

let table = document.getElementById("customerTable");
table.innerHTML = "";

data.customers.forEach(c => {

table.innerHTML += `
<tr>
<td>${c.id}</td>
<td>${c.name}</td>
<td>${c.email}</td>
<td>${c.phone}</td>
<td>${c.city}</td>

<td>
<button onclick="editCustomer(${c.id},'${c.name}','${c.email}','${c.phone}','${c.city}')">Edit</button>
<button onclick="deleteCustomer(${c.id})">Delete</button>
</td>
</tr>
`;

});

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

fetch("/rest/CRM_App/customers/update",{

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

fetch("/rest/CRM_App/customers/delete/" + id,{
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



let customersData = [];
let filteredData = [];

// 🔥 Convert CF → JS
function processCustomers(rawData){
    if (rawData.DATA) {
        let cols = rawData.COLUMNS;

        for (let i = 0; i < rawData.DATA.length; i++) {
            let obj = {};

            for (let j = 0; j < cols.length; j++) {
                obj[cols[j].toLowerCase()] = rawData.DATA[i][j];
            }

            customersData.push(obj);
        }
    }

    filteredData = [...customersData];
}

// 🔥 Generate Row
function generateRow(cust) {
  return `
    <tr>
      <td>${cust.id}</td>
      <td>${cust.name}</td>
      <td>${cust.email}</td>
      <td>${cust.phone}</td>
      <td>${cust.city}</td>
      <td>
        <button onclick="editCustomer(${cust.id}, '${cust.name}', '${cust.email}', '${cust.phone}', '${cust.city}')">Edit</button>
        <button onclick="deleteCustomer(${cust.id})">Delete</button>
      </td>
    </tr>
  `;
}

// 🔥 Search Filter
function filterCustomers() {
    let search = $("#searchBox").val().toLowerCase();

    filteredData = customersData.filter(c =>
        c.name.toLowerCase().includes(search) ||
        c.email.toLowerCase().includes(search) ||
        c.city.toLowerCase().includes(search)
    );

    initPagination(filteredData, "#customerTable", "#pagination");
}

// 🔥 Bind search event
$(document).on("keyup", "#searchBox", function(){
    filterCustomers();
});

// 🔥 INIT
$(document).ready(function(){

    processCustomers(window.rawCustomers);

    initPagination(customersData, "#customerTable", "#pagination");

});