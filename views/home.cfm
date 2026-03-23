
<link rel="stylesheet" href="/CRM_project/css/home.css">

<script src="/CRM_project/js/home.js"></script>
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<cfif NOT structKeyExists(session,"loggedIn")>
  <cflocation url="../index.cfm?crm=login" addtoken="false">
</cfif>

<div class="header">
<button class="menu-btn" onclick="toggleMenu()">☰</button>

<cfquery name="qProfile">
SELECT profile_pic
FROM users
WHERE username =
<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfoutput>
<div style="display:flex;align-items:center;gap:10px;">
<cfif qProfile.recordCount GT 0 AND len(qProfile.profile_pic)>
<img src="/CRM_project/#qProfile.profile_pic#"
style="width:50px;height:50px;border-radius:50%;object-fit:cover;">
<cfelse>
<div class="avatar">
#ucase(left(session.username,1))#
</div>
</cfif>
<h1>Welcome #session.username#</h1>

</div>

</cfoutput>

</div>

<!-- MENU BAR -->

<div id="menu" class="navbar">

<a href="/CRM_project/index.cfm?crm=submitRequest">Submit Request</a>
<a href="/CRM_project/index.cfm?crm=viewRequests">View Requests</a>
<cfif session.is_admin EQ 1>

<a href="index.cfm?crm=viewCustomers">View Customers</a>

<a href="index.cfm?crm=viewLogs">View Logs</a>

<a href="index.cfm?crm=viewUsers">Registered Users</a>

</cfif>

<a href="index.cfm?crm=uploadProfile">Upload Profile Picture</a>

<a href="/CRM_project/index.cfm?crm=logout">Logout</a>

</div>

