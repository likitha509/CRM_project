<link rel="stylesheet" href="/CRM_project/css/styleUpload.css">

<!-- Login Check -->
<cfif NOT structKeyExists(session, "loggedIn")>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<div class="upload-container">

<cfif structKeyExists(form, "profilePic")>

    <!-- Upload file -->
    <cffile
        action="upload"
        filefield="profilePic"
        destination="#expandPath('/CRM_project/uploads/')#"
        nameconflict="makeunique">

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

<a href="/CRM_project/index.cfm?crm=home" class="back-link">
Go to Home
</a>

</div>