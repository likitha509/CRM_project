<cfif NOT structKeyExists(session, "loggedIn") OR NOT session.loggedIn>
    <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<cfparam name="url.id" default="0">

<cfset service = createObject("component","CRM_project.components.customerService")>

<cfset service.deleteRequest(url.id)>
<!-- Log delete action -->

<cfquery datasource="myDB">
INSERT INTO logs (username, action, details)
VALUES (
<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
'Delete',
<cfqueryparam value="Request ID #url.id# deleted" cfsqltype="cf_sql_varchar">
)
</cfquery>

<cflog file="activityLogs"
text="User #session.username# deleted request ID #url.id#"
type="information">
<cflocation url="/CRM_project/index.cfm?crm=viewRequests" addtoken="false">