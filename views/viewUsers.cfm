<head>
<link rel="stylesheet" href="/CRM_project/css/logs.css">
</head>
<cfif session.is_admin NEQ 1>
<h2>Access Denied — Admin Only</h2>
<cfabort>
</cfif>
<h2>Registered Users</h2>
<cfquery name="qUsers">
SELECT username, email, is_admin, is_active
FROM users
ORDER BY id DESC
</cfquery>
<table border="1" cellpadding="8">
<tr>
<th>Username</th>
<th>Email</th>
<th>Status</th>
<th>Account status</th>
</tr>
<cfoutput query="qUsers">
<tr>
<td>#username#</td>
<td>#email#</td>
<td>
<cfif is_admin EQ 1>
Admin
<cfelse>
User
</cfif>
</td>
<td>
<cfif is_active EQ 1>
Active
<cfelse>
Inactive
</cfif>
</td>
</tr>
</cfoutput>
</table>
<br>
