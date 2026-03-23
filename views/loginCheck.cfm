
<link rel="stylesheet" href="/CRM_project/css/check.css">
<cfif NOT structKeyExists(form, "username") OR NOT structKeyExists(form, "password")>
    <cflocation url="index.cfm?crm=login">
</cfif>
<cfset username = form.username>
<cfset password = form.password>
<cfquery name="qUser">
SELECT *
FROM users
WHERE username =
    <cfqueryparam value="#username#" cfsqltype="cf_sql_varchar">
AND password =
    <cfqueryparam value="#password#" cfsqltype="cf_sql_varchar">
</cfquery>
<cfif qUser.recordCount GT 0>

  <!-- Create session -->
  <cfset session.loggedIn = true>
  <cfset session.username = qUser.username>
  <cfset session.is_admin = qUser.is_admin>
<cfquery>
INSERT INTO logs (username, action, details)
VALUES (
  '#username#',
  'Login',
  'User ID #qUser.id# logged in'
)
</cfquery>
<!-- NEW: CFLOG -->
  <cflog file="activityLogs"
         text="User #username# (ID: #qUser.id#) logged in successfully"
         type="information">
<cflocation url="/CRM_project/index.cfm?crm=home" addtoken="false">
  
<cfelse>  
<div class="error-box">

  <div class="error-text">
    Invalid Username or Password
  </div>


<a href="/CRM_project/index.cfm?crm=login" class="back-link">
    Back to Login
  </a>
</cfif>