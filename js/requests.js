function deleteRequest(id){

if(confirm("Delete this request?")){

fetch("/CRM_project/index.cfm?crm=deleteRequest&id=" + id)

.then(response => response.text())

.then(data => {

alert("Deleted Successfully");

window.location="/CRM_project/index.cfm?crm=viewRequests";

});

}

}
function searchRequest(){

var search = document.getElementById("search").value;

fetch("/CRM_project/index.cfm?crm=searchRequest&search="+search)

.then(response=>response.text())
.then(data=>{
document.getElementById("tableData").innerHTML=data;
});

}


