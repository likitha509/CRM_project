<head>
<link rel="stylesheet" href="/CRM_project/css/forgot.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Add JS file -->
<script src="/CRM_project/js/requests.js"></script>
<script src="/CRM_project/js/pagination.js"></script>
</head>

<cfparam name="url.search" default="">
<cfparam name="url.department" default="">

<h2 style="text-align:center;">All Requests</h2>
 
<br><br>
 
<!-- FILTER -->
<form method="get" action="/CRM_project/index.cfm" style="text-align:center;">
    <input type="hidden" name="crm" value="viewRequests">

    <input type="text" name="search"
           placeholder="Search"
           value="<cfoutput>#encodeForHTML(url.search)#</cfoutput>">

    <select name="department">
        <option value="">All Departments</option>
        <option value="HR" <cfif url.department EQ "HR">selected</cfif>>HR</option>
        <option value="IT" <cfif url.department EQ "IT">selected</cfif>>IT</option>
        <option value="Finance" <cfif url.department EQ "Finance">selected</cfif>>Finance</option>
    </select>

    <button type="submit">Filter</button>
</form>

<br><br>

<table border="1" cellpadding="8" width="80%" align="center">
<tr>
<th>ID</th>
<th>Title</th>
<th>Description</th>
<th>Department</th>
<th>Created By</th>
<th>Action</th>
</tr>

<tbody id="requestTable"></tbody>
</table>

<br>
<br><br>

<div style="text-align:center;">

    <a href="/CRM_project/views/generateReport.cfm?
search=<cfoutput>#urlEncodedFormat(url.search)#</cfoutput>
&department=<cfoutput>#urlEncodedFormat(url.department)#</cfoutput>">

       Generate Report

    </a>

</div>

<br>

<div id="pagination" style="text-align:center;"></div>

<br>
<br>

<!--  ONLY DATA PASSING -->
<script>
<cfoutput>
window.rawData = #serializeJSON(requests)#;
</cfoutput>
</script>