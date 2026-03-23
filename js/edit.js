

function updateRequest(){

var id = document.getElementById("id").value;
var title = document.getElementById("title").value;
var description = document.getElementById("description").value;

fetch("/CRM_project/index.cfm?crm=updateRequest",{

method:"POST",

headers:{
"Content-Type":"application/x-www-form-urlencoded"
},


body:"id="+id+"&title="+title+"&description="+description

})
.then(response=>response.text())
.then(data=>{
alert("Request Updated Successfully");
window.location="/CRM_project/index.cfm?crm=viewRequests";
});

}

