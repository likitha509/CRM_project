function addRequest(){

    var title = document.getElementById("title").value;
    var description = document.getElementById("description").value;
    var department = document.getElementById("department").value;

    // Create form dynamically
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "/CRM_project/index.cfm?crm=saveRequest";
    form.target = "_blank";   // ✅ opens new tab

    // Add inputs
    var fields = {
        title: title,
        description: description,
        department: department
    };

    for (var key in fields) {
        var input = document.createElement("input");
        input.type = "hidden";
        input.name = key;
        input.value = fields[key];
        form.appendChild(input);
    }

    document.body.appendChild(form);
    form.submit();
}