<head>
<link rel="stylesheet" href="/CRM_project/css/logs.css">
</head>


<h2>Registered Users</h2>
<table border="1" cellpadding="8">
<tr>
<th>Username</th>
<th>Email</th>
<th>Status</th>
<th>Account status</th>
</tr>
<cfoutput query="data">
<tr>
<td>#encodeForHTML(username)#</td>
<td>#encodeForHTML(email)#</td>
<td>
<cfif is_admin EQ 1> Admin <cfelse> User </cfif>
</td>
<td>
<cfif is_active EQ 1> Active <cfelse> Inactive </cfif>
</td>
</tr>
</cfoutput>
</table>
<br>
