<cfif session.role NEQ "admin">
    <cfoutput>Unauthorized Access</cfoutput>
    <cfabort>
</cfif>
<cflog file="activityLogs"
       text="Admin #session.username# deleted all logs"
       type="warning">
<!-- Log action -->
<cfquery>
INSERT INTO logs (username, action, details)
VALUES (
    <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="Delete Logs" cfsqltype="cf_sql_varchar">,
    <cfqueryparam value="All logs deleted" cfsqltype="cf_sql_varchar">
)
</cfquery>

<!-- Delete logs -->
<cfquery>
DELETE FROM logs
</cfquery>

