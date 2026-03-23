
<cfset token = createUUID()>

<cfquery name="qUser" >
SELECT id FROM users
WHERE email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif qUser.recordCount EQ 0>
    <cfoutput>Email not registered</cfoutput>
    <cfabort>
</cfif>

<!-- Update token -->
<cfquery >
UPDATE users
SET reset_token = <cfqueryparam value="#token#" cfsqltype="cf_sql_varchar">,
    token_expiry = <cfqueryparam 
        value="#dateAdd('h',1,now())#" 
        cfsqltype="cf_sql_timestamp">
WHERE email = <cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
</cfquery>
<cfmail
to="#form.email#"
from="bendilikitha@gmail.com"
subject="Reset Your Password"
server="smtp.gmail.com"
port="587"
username="bendilikitha@gmail.com"
password="gravyblertrjshbi"
useTLS="true">

Click the link below to reset your password:

http://localhost:8500/CRM_project/index.cfm?crm=resetPassword&token=#token#

This link will expire in 1 hour.

</cfmail>

<cflog file="activityLogs" 
text="Password reset link sent to #form.email#">

<cfoutput>
Check your email for reset link.
<br><br>

<a href="/CRM_project/index.cfm?crm=login">
Go to Login
</a>
</cfoutput>