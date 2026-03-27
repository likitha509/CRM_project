<link rel="stylesheet" href="/CRM_project/css/styleUpload.css">

<!-- Login Check -->
<cfif NOT structKeyExists(session, "loggedIn")>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<div class="upload-container">

<cfif structKeyExists(form, "profilePic")>

    <!--- Get old photo --->
    <cfquery name="getOld">
        SELECT profile_pic 
        FROM users 
        WHERE username = 
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <!--- Delete old file if exists --->
    <cfif getOld.recordCount GT 0 AND len(getOld.profile_pic)>
        <cfset oldPath = expandPath("/CRM_project/" & getOld.profile_pic)>
        <cfif fileExists(oldPath)>
            <cffile action="delete" file="#oldPath#">
        </cfif>
    </cfif>

    <!-- Upload file (overwrite mode) -->
    <cffile
        action="upload"
        filefield="profilePic"
        destination="#expandPath('/CRM_project/uploads/')#"
        nameconflict="overwrite">

    <!-- Resize image -->
    <cfimage
        action="resize"
        source="#cffile.serverDirectory#/#cffile.serverFile#"
        width="200"
        height="200"
        destination="#cffile.serverDirectory#/#cffile.serverFile#"
        overwrite="yes">

    <!-- Save image path -->
    <cfquery>
    UPDATE users
    SET profile_pic =
        <cfqueryparam value="uploads/#cffile.serverFile#"
        cfsqltype="cf_sql_varchar">
    WHERE username =
        <cfqueryparam value="#session.username#"
        cfsqltype="cf_sql_varchar">
    </cfquery>

    <h2 class="success-msg">Photo Uploaded Successfully</h2>

</cfif>

<br>



</div>