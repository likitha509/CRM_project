let requestsData = [];

//  Convert CF query → JS objects
function processData(rawData){
    if (rawData.DATA) {
        let cols = rawData.COLUMNS;
        let rows = rawData.DATA;

        for (let i = 0; i < rows.length; i++) {
            let obj = {};
            for (let j = 0; j < cols.length; j++) {
                obj[cols[j].toLowerCase()] = rows[i][j];
            }
            requestsData.push(obj);
        }
    }
}

//  Generate Table Row
function generateRow(req){

    let row = $("<tr>");

    row.append($("<td>").text(req.id));

    row.append($("<td>").text(req.title));

    row.append($("<td>").text(req.description));

    row.append($("<td>").text(req.department));

    row.append($("<td>").text(req.created_by));

    row.append(`
        <td>
            <a href="index.cfm?crm=editRequest&id=${req.id}">
                Edit
            </a>

            |

            <a href="#"
               onclick="deleteRequest(${req.id})">

               Delete

            </a>
        </td>
    `);

    return row;

}

//  Delete Function
function deleteRequest(id){

  if(confirm("Delete this request?")){

    fetch("index.cfm?crm=deleteRequest&id=" + id)
    .then(res => res.text())
    .then(() => {

      alert("Deleted Successfully");

      requestsData = requestsData.filter(r => r.id != id);

      initPagination(requestsData, "#requestTable", "#pagination");

    })
    .catch(err => {
      alert("Error deleting request");
      console.error(err);
    });

  }
}

//  INIT
$(document).ready(function(){

    processData(window.rawData);

    initPagination(requestsData, "#requestTable", "#pagination");

});