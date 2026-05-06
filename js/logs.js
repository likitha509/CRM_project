// Generate Table Row
function generateRow(log) {

    return `
        <tr>
            <td>${log.username}</td>
            <td>${log.action}</td>
            <td>${log.details}</td>
            <td>${log.date}</td>
        </tr>
    `;

}

// Initialize Pagination
$(document).ready(function () {

    initPagination(
        logsData,
        "#logsTable",
        "#pagination"
    );

});