<cfif NOT structKeyExists(session,"loggedIn") OR NOT session.loggedIn>
    <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>
<!-- Form validation -->
<cfif NOT structKeyExists(form, "title") OR NOT structKeyExists(form, "description")>
    <cflocation url="/CRM_project/index.cfm?crm=addRequest">
</cfif>

<cfset service = createObject("component","CRM_project.components.customerService")>

<cfset service.addRequest(
form.title,
form.description,
form.department,
session.username
)>

<!-- Get last inserted ID -->

<cfquery name="qID" datasource="myDB">
SELECT LAST_INSERT_ID() AS newID
</cfquery>
<!-- Insert log -->
<cfquery datasource="myDB">
INSERT INTO logs (username, action, details)
VALUES (
<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
'Submit',
<cfqueryparam value="Request ID #qID.newID# created" cfsqltype="cf_sql_varchar">
)
</cfquery>
<!--  LOG HERE -->
<cflog file="activityLogs"
text="User #session.username# submitted request"
type="information">
<cflocation url="/CRM_project/index.cfm?crm=viewRequests" addtoken="false">