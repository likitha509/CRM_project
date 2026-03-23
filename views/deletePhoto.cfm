<!-- Login Check -->
<cfif NOT structKeyExists(session, "loggedIn")>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<cfif structKeyExists(form, "photoPath")>

    <!-- Convert relative path to full path -->
    <cfset fullPath = expandPath("../" & form.photoPath)>

    <!-- Check if file exists -->
    <cfif fileExists(fullPath)>
        <cffile action="delete" file="#fullPath#">
    </cfif>

    <!-- Remove path from DB -->
    <cfquery>
        UPDATE users
        SET profile_pic = NULL
        WHERE username =
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
    </cfquery>

</cfif>

<!-- Redirect back -->
<cflocation url="/CRM_project/index.cfm?crm=uploadProfile" addtoken="false">