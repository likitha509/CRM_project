<cfif NOT structKeyExists(session, "loggedIn") OR NOT session.loggedIn>
    <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<cfset service = createObject("component","CRM_project.components.customerService")>

<cfset service.updateRequest(
form.id,
form.title,
form.description
)>

<!-- Log action -->

<cfquery>
INSERT INTO logs (username, action, details)
VALUES (
<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
'Edit',
<cfqueryparam value="Request ID #form.id# updated" cfsqltype="cf_sql_varchar">
)
</cfquery>
<cflog file="activityLogs"
text="User #session.username# updated request ID #url.id#"
type="information">
<cflocation url="/CRM_project/index.cfm?crm=viewRequests" addtoken="false">