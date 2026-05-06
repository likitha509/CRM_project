<cfif structKeyExists(session,"username")>
    <cfset user = session.username>

    <cfquery datasource="myDB">
        INSERT INTO logs (username, action, details)
        VALUES (
            <cfqueryparam value="#user#" cfsqltype="cf_sql_varchar">,
            'Exit',
            <cfqueryparam value="User logged out" cfsqltype="cf_sql_varchar">
        )
    </cfquery>

    <cflog file="activityLogs"
           text="User #user# logged out"
           type="information">
</cfif>

<cfset structClear(session)>
<cfset sessionInvalidate()>
<cfset session.loggedIn = false>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">