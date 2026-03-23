<!-- Log: Exit in DB -->
<cfquery>
INSERT INTO logs (username, action, details)
VALUES (
    <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
    'Exit',
    <cfqueryparam value="User logged out" cfsqltype="cf_sql_varchar">
)
</cfquery>

<!--  CFLOG (NEW) -->
<cflog file="activityLogs"
       text="User #session.username# logged out"
       type="information">

<!-- Destroy session -->
<cfset structClear(session)>
<cfset sessionInvalidate()>

<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">