<cfcomponent output="false">
<!-- Get Requests -->
<cffunction name="getRequests" access="public" returntype="query">

<cfargument name="search" required="false">
<cfargument name="department" required="false">
<cfargument name="startRow" required="true">
<cfargument name="perPage" required="true">

<cfif session.is_admin EQ 1>

<!-- Admin sees all requests -->

<cfquery name="qReq">
SELECT *
FROM requests
WHERE 1=1

<cfif arguments.search NEQ "">
AND title LIKE
<cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
</cfif>

<cfif arguments.department NEQ "">
AND department =
<cfqueryparam value="#arguments.department#" cfsqltype="cf_sql_varchar">
</cfif>

ORDER BY id DESC
LIMIT #arguments.startRow#,#arguments.perPage#
</cfquery>

<cfelse>

<!-- User sees only their requests -->

<cfquery name="qReq">
SELECT *
FROM requests
WHERE created_by =
<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">

<cfif arguments.search NEQ "">
AND title LIKE
<cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
</cfif>

<cfif arguments.department NEQ "">
AND department =
<cfqueryparam value="#arguments.department#" cfsqltype="cf_sql_varchar">
</cfif>

ORDER BY id DESC
LIMIT #arguments.startRow#,#arguments.perPage#
</cfquery>

</cfif>

<cfreturn qReq>

</cffunction>
<!-- Get Total Requests -->
<cffunction name="getTotalRequests" access="public" returntype="query">

<cfargument name="search" default="">
<cfargument name="department" default="">

<cfquery name="qCount">

SELECT COUNT(*) AS total
FROM requests
WHERE 1=1

<cfif session.is_admin NEQ 1>
AND created_by =
<cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
</cfif>

<cfif len(arguments.search)>
AND title LIKE
<cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
</cfif>

<cfif len(arguments.department)>
AND department =
<cfqueryparam value="#arguments.department#" cfsqltype="cf_sql_varchar">
</cfif>

</cfquery>

<cfreturn qCount>

</cffunction>
<!-- Add Request -->
<cffunction name="addRequest" access="remote" returntype="struct" returnformat="json">

    <cfargument name="title" required="true">
    <cfargument name="description" required="true">
    <cfargument name="department" required="true">
    <cfargument name="username" required="true">

    <cfquery>

        INSERT INTO requests(created_by, title, description, department)
        VALUES(
        <cfqueryparam value="#arguments.username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#arguments.department#" cfsqltype="cf_sql_varchar">
        )

    </cfquery>
<cfset result = {status="success", message="Request added successfully"}>
<cfreturn result>
</cffunction>
<!-- Update Request -->
<cffunction name="updateRequest" access="remote" returntype="struct" returnformat="json">

    <cfargument name="id" required="true">
    <cfargument name="title" required="true">
    <cfargument name="description" required="true">
    
    <cfquery>

        UPDATE requests
        SET
        title =
        <cfqueryparam value="#arguments.title#" cfsqltype="cf_sql_varchar">,

        description =
        <cfqueryparam value="#arguments.description#" cfsqltype="cf_sql_varchar">

        WHERE id =
        <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">

    </cfquery>
<cfset result = {status="success", message="Request updated successfully"}>
<cfreturn result>
</cffunction>
<!-- Delete Request -->
<cffunction name="deleteRequest" access="remote" returntype="struct" returnformat="json">

    <cfargument name="id" required="true">

    <cfquery>

        DELETE FROM requests
        WHERE id =
        <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">

    </cfquery>
<cfset result = {status="success", message="Request deleted successfully"}>
<cfreturn result>
</cffunction>

</cfcomponent>