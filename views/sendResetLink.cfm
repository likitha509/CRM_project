<!-- Validate form -->
<cfif NOT structKeyExists(form,"email")>
    <cflocation url="index.cfm?crm=forgotPassword" addtoken="false">
</cfif>

<cfset email = trim(form.email)>
<cfset token = createUUID()>

<!-- Check user -->
<cfquery name="qUser" datasource="myDB">
SELECT id FROM users
WHERE email = <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif qUser.recordCount EQ 0>
    <div class="error-box">
        Email not registered
        <br>
        <a href="index.cfm?crm=forgotPassword">Try Again</a>
    </div>
    <cfabort>
</cfif>

<!-- Save token -->
<cfquery datasource="myDB">
UPDATE users
SET reset_token = <cfqueryparam value="#token#" cfsqltype="cf_sql_varchar">,
    token_expiry = <cfqueryparam value="#dateAdd('h',1,now())#" cfsqltype="cf_sql_timestamp">
WHERE email = <cfqueryparam value="#email#" cfsqltype="cf_sql_varchar">
</cfquery>

<!-- Send email -->
<cfmail
to="#email#"
from="bendilikitha@gmail.com"
subject="Reset Password"
server="smtp.gmail.com"
port="587"
username="bendilikitha@gmail.com"
password="gravyblertrjshbi"
useTLS="true">

Click the link below to reset your password:

http://localhost:8500/CRM_project/index.cfm?crm=resetPassword&token=#token#

This link will expire in 1 hour.

</cfmail>

<!-- Log -->
<cflog file="activityLogs" 
text="Password reset link sent to #encodeForHTML(email)#">

<!-- UI -->
<div class="container">
    <h3>Check your email for reset link</h3>
    <cfinclude template="common/backToLogin.cfm">
</div>