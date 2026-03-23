function changePage(crm, page, totalPages, search="", department=""){

    if(page >= 1 && page <= totalPages){

        var url = "/CRM_project/index.cfm?crm=" + crm + "&page=" + page;

        if(search !== ""){
            url += "&search=" + search;
        }

        if(department !== ""){
            url += "&department=" + department;
        }

        window.location.href = url;
    }
}