<head>
<link rel="stylesheet" href="/CRM_project/css/logs.css">
<script src="/CRM_project/js/pagination.js"></script>
</head>

<!-- Prevent Back Cache -->
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<!-- Login Check -->
<cfif NOT structKeyExists(session,"loggedIn") OR NOT session.loggedIn>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>
<!-- Admin Only -->
<cfif NOT structKeyExists(session,"is_admin") OR session.is_admin NEQ 1>

<h2>Access Denied — Admin Only</h2>



<cfabort>

</cfif>

<!-- Pagination Setup -->

<cfparam name="url.page" default="1">

<cfset perPage = 5>

<cfset startRow = (url.page - 1) * perPage>

<!-- Fetch Logs -->

<cfquery name="qLogs">
SELECT username,
       action,
       COUNT(*) AS total_actions
FROM logs
GROUP BY username, action
ORDER BY total_actions DESC
LIMIT #startRow#, #perPage#
</cfquery>

<cfquery name="qCount">
SELECT COUNT(*) AS total
FROM (
    SELECT username, action
    FROM logs
    GROUP BY username, action
) AS temp
</cfquery>

<cfset totalPages = ceiling(qCount.total / perPage)>

<h2 style="text-align:center">Activity Logs</h2>

<br>

<!-- Logs Table -->

<table border="1" cellpadding="8" width="80%" align="center">

<table border="1">

<tr>
<th>Username</th>
<th>Action</th>
<th>Total Times</th>
</tr>

<cfoutput query="qLogs">

<tr>
<td>#username#</td>
<td>#action#</td>
<td>#total_actions#</td>
</tr>

</cfoutput>

</table>

<br>

<!-- Delete Logs Button -->

<div style="text-align:center">

<a href="/CRM_project/index.cfm?crm=deleteLogs"
   onclick="return confirm('Delete all logs?')">

Delete All Logs

</a>

</div>
<br><br>

<!-- Pagination -->
<cfinclude template="pagination.cfm">
