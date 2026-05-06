<link rel="stylesheet" href="/CRM_project/css/check.css">
<cfif NOT structKeyExists(form, "username") OR NOT structKeyExists(form, "password")>
    <cflocation url="index.cfm?crm=login">
</cfif>

<cfset username = form.username>
<cfset password = form.password>

<!-- Hash password -->
<cfset hashedPassword = hash(password, "SHA-256")>

<!-- Check user -->
<cfquery name="qUser">
SELECT id, username, is_admin
FROM users
WHERE username = 
    <cfqueryparam value="#username#" cfsqltype="cf_sql_varchar">
AND password = 
    <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif qUser.recordCount GT 0>

    <!-- Create session -->
    <cfset session.loggedIn = true>
    <cfset session.username = qUser.username[1]>
    <cfset session.is_admin = qUser.is_admin[1]>
    <cfset session.userId = qUser.id[1]>

    <!-- Insert log -->
    <cfquery >
    INSERT INTO logs (username, action, details)
    VALUES (
        <cfqueryparam value="#username#" cfsqltype="cf_sql_varchar">,
        'Login',
        <cfqueryparam value="User ID #qUser.id[1]# logged in" cfsqltype="cf_sql_varchar">
    )
    </cfquery>

    <!-- File log -->
    <cflog file="activityLogs"
           text="User #encodeForHTML(username)# (ID: #qUser.id[1]#) logged in successfully"
           type="information">

    <cflocation url="/CRM_project/index.cfm?crm=home" addtoken="false">

<cfelse>

<div class="error-box">
    <div class="error-text">
        Invalid Username or Password
    </div>

   <cfinclude template="common/backToLogin.cfm">
</div>

</cfif>