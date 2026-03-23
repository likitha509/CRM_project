<cfparam name="url.crm" default="login">
<cfset crm = url.crm>
<!-- create controller only once -->
<cfif NOT structKeyExists(application,"controller")>
    <cfset application.controller = createObject("component","components.controller")>
</cfif>
<!-- include router -->
<cfinclude template="router.cfm">