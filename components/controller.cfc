<cfcomponent output="false">
 <!-- =========================
        CREATE REQUEST
    ========================== -->
    <cffunction name="createRequest" access="public" returntype="string">

        <cfargument name="info" type="struct" required="true">

        <cfset var errMsg = "">

        <!-- Validate -->
        <cfif NOT len(trim(arguments.info.title ?: ""))>
            <cfset errMsg &= "Title required ">
        </cfif>

        <cfif NOT len(trim(arguments.info.description ?: ""))>
            <cfset errMsg &= "Description required ">
        </cfif>

        <cfif NOT len(trim(arguments.info.department ?: ""))>
            <cfset errMsg &= "Department required ">
        </cfif>

        <cfif errMsg NEQ "">
            <cfreturn errMsg>
        </cfif>

        <!-- Clean -->
        <cfset var safeTitle = encodeForHTML(trim(arguments.info.title))>
        <cfset var safeDescription = encodeForHTML(trim(arguments.info.description))>
        <cfset var safeDepartment = encodeForHTML(trim(arguments.info.department))>

        <!-- Insert -->
        <cfquery result="res" datasource="myDB">
            INSERT INTO requests (title, description, department, created_by)
            VALUES (
                <cfqueryparam value="#safeTitle#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#safeDescription#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#safeDepartment#" cfsqltype="cf_sql_varchar">,
                <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
            )
        </cfquery>

        <!-- Get ID -->
        <cfset var newID = res.generatedKey>

        <!-- DB Log -->
        <cfquery datasource="myDB">
            INSERT INTO logs (username, action, details)
            VALUES (
                <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">,
                'Submit',
                <cfqueryparam value="Request ID #newID# created" cfsqltype="cf_sql_varchar">
            )
        </cfquery>

        <!-- File Log -->
        <cflog file="activityLogs"
            text="User #session.username# created request ID #newID#"
            type="information">

        <cfreturn errMsg>

    </cffunction>


    <!-- =========================
        FETCH REQUESTS
    ========================== -->
    <cffunction name="fetchRequests" access="public" returntype="query">

    <cfargument name="search" default="">
    <cfargument name="department" default="">

    <cfquery name="qReq" datasource="myDB">
        SELECT id, title, description, department, created_by
        FROM requests
        WHERE 1=1

        <!-- USER FILTER (only for non-admin) -->
        <cfif structKeyExists(session,"is_admin") AND session.is_admin NEQ 1>
            AND created_by = 
            <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
        </cfif>

        <!-- SEARCH FILTER -->
        <cfif len(trim(arguments.search))>
            AND (
                title LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
                OR description LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
                OR department LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
                OR created_by LIKE <cfqueryparam value="%#arguments.search#%" cfsqltype="cf_sql_varchar">
            )
        </cfif>

        <!-- DEPARTMENT FILTER -->
        <cfif len(trim(arguments.department)) AND arguments.department NEQ "All Departments">
            AND department = 
            <cfqueryparam value="#arguments.department#" cfsqltype="cf_sql_varchar">
        </cfif>

        ORDER BY id DESC
    </cfquery>

    <cfreturn qReq>

</cffunction>
    <!--- =========================
        UPDATE REQUEST
    ========================== --->
    <cffunction name="updateRequest" access="public" returntype="string">

        <cfargument name="id" required="true">
        <cfargument name="info" required="true">

        <cfset var errMsg = "">

        <!-- Validate -->
        <cfif arguments.id LTE 0>
            <cfreturn "Invalid ID">
        </cfif>

        <!--- Clean --->
        <cfset var safeTitle = encodeForHTML(trim(arguments.info.title))>
        <cfset var safeDescription = encodeForHTML(trim(arguments.info.description))>
        <cfset var safeDepartment = encodeForHTML(trim(arguments.info.department))>

        <!--- Update --->
        <cfquery datasource="myDB">
            UPDATE requests
            SET title = <cfqueryparam value="#safeTitle#">,
                description = <cfqueryparam value="#safeDescription#">,
                department = <cfqueryparam value="#safeDepartment#">
            WHERE id = <cfqueryparam value="#arguments.id#">
        </cfquery>

        <!--- DB LOG --->
        <cfquery datasource="myDB">
            INSERT INTO logs (username, action, details)
            VALUES (
                <cfqueryparam value="#session.username#">,
                'Edit',
                <cfqueryparam value="Request ID #arguments.id# updated">
            )
        </cfquery>

        <!--- FILE LOG --->
        <cflog file="activityLogs"
            text="User #session.username# updated request ID #arguments.id#"
            type="information">

        <cfreturn errMsg>

    </cffunction>


    <!-- =========================
        DELETE REQUEST
    ========================== -->
    <cffunction name="deleteRequest" access="public" returntype="string">

        <cfargument name="id" type="numeric" required="true">

        <cfset var errMsg = "">

        <cfif arguments.id LTE 0>
            <cfreturn "Invalid ID">
        </cfif>

        <!--- Delete --->
        <cfquery datasource="myDB">
            DELETE FROM requests
            WHERE id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer">
        </cfquery>

        <!--- DB LOG --->
        <cfquery datasource="myDB">
            INSERT INTO logs (username, action, details)
            VALUES (
                <cfqueryparam value="#session.username#">,
                'Delete',
                <cfqueryparam value="Request ID #arguments.id# deleted">
            )
        </cfquery>

        <!--- FILE LOG --->
        <cflog file="activityLogs"
            text="User #session.username# deleted request ID #arguments.id#"
            type="information">

        <cfreturn errMsg>

    </cffunction>


    <!-- =========================
        FETCH LOGS
    ========================== -->
    <cffunction name="fetchLogsNew" access="public" returntype="query">

    <cfquery name="qLogs" datasource="myDB">
        SELECT username, action, details, created_at
        FROM logs
        ORDER BY created_at DESC
    </cfquery>

    <cfreturn qLogs>

</cffunction>


    <!-- =========================
        FETCH USERS
    ========================== -->
    <cffunction name="fetchUsers" access="public" returntype="query">

        <cfquery name="qUsers" datasource="myDB">
            SELECT * FROM users
            ORDER BY id DESC
        </cfquery>

        <cfreturn qUsers>

    </cffunction>

</cfcomponent>\