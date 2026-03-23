<head>
<link rel="stylesheet" href="/CRM_project/css/forgot.css">

<script src="/CRM_project/js/pagination.js"></script>
<script src="/CRM_project/js/requests.js"></script>
</head>

<!-- Login Check -->
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfif NOT structKeyExists(session, "loggedIn")>
    <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<!-- URL Parameters -->
<cfparam name="url.search" default="">
<cfparam name="url.department" default="">
<cfparam name="url.page" default="1">

<!-- Pagination -->
<cfset perPage = 5>
<cfset startRow = (url.page - 1) * perPage>

<!-- CFC -->
<cfset service = createObject("component","CRM_project.components.customerService")>
<!-- Data -->
<cfset qReq = service.getRequests(url.search,url.department,startRow,perPage)>
<cfset qCount = service.getTotalRequests(url.search,url.department)>
<cfset totalPages = ceiling(qCount.total / perPage)>
<h2>All Requests</h2>
<a href="/CRM_project/index.cfm?crm=submitRequest">Submit New Request</a>
<br><br>
<cfoutput>
<a href="/CRM_project/index.cfm?crm=generateReport&department=#url.department#&search=#url.search#">
Download PDF
</a>
</cfoutput>

<br><br>
<input type="text" id="search" onkeyup="searchRequest()" placeholder="Search department">
<br><br>
<form method="get" action="/CRM_project/index.cfm">
<input type="hidden" name="crm" value="viewRequests">

<cfoutput>
<input type="hidden" name="search" value="#url.search#">
</cfoutput>
<input type="hidden" name="page" value="1">
<label>Select Department:</label>
<select name="department">
<option value="">All Departments</option>
<option value="HR" <cfif url.department EQ "HR">selected</cfif>>HR</option>
<option value="IT" <cfif url.department EQ "IT">selected</cfif>>IT</option>
<option value="Finance" <cfif url.department EQ "Finance">selected</cfif>>Finance</option>
</select>

<input type="submit" value="Filter">
</form>
<br><br>
<table border="1" cellpadding="5">
<tr>
<th>ID</th>
<th>Title</th>
<th>Description</th>
<th>Department</th>
<th>Created By</th>
<th>Action</th>
</tr>
<tbody id="tableData">
<cfoutput query="qReq">
<tr>
<td>#id#</td>
<td>#title#</td>
<td>#description#</td>
<td>#department#</td>
<td>#created_by#</td>
<td>
<a href="/CRM_project/index.cfm?crm=editRequest&id=#id#">Edit</a>|
<a href="javascript:void(0)" onclick="deleteRequest(#id#)">Delete</a>
</td>
</tr>
</cfoutput>
</tbody>
</table>

<cfinclude template="pagination.cfm">
<br>
