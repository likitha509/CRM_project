<link rel="stylesheet" href="/CRM_project/css/styleUpload.css">

<!-- Login Check -->
<cfif NOT structKeyExists(session, "loggedIn")>
    <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<div class="upload-container">

<cftry>

<cfif structKeyExists(form, "profilePic")>

    <!-- Upload file -->
    <cffile
        action="upload"
        filefield="profilePic"
        destination="#expandPath('/CRM_project/uploads/')#"
        nameconflict="makeunique">

    <!-- Validate file type -->
    <cfset fileExt = lcase(cffile.serverFileExt)>

    <cfif NOT listFind("jpg,jpeg,png", fileExt)>
        
        <!-- Delete invalid file -->
        <cffile action="delete" file="#cffile.serverDirectory#/#cffile.serverFile#">

        <script>
            alert("Only JPG, JPEG, PNG files are allowed!");
            window.history.back();
        </script>

        <cfabort>
    </cfif>

    <!-- File size check (2MB) -->
    <cfif cffile.fileSize GT 2097152>
        <cffile action="delete" file="#cffile.serverDirectory#/#cffile.serverFile#">
        <cfoutput>File too large! Max 2MB allowed.</cfoutput>
        <cfabort>
    </cfif>

    <!-- Get old photo -->
    <cfquery name="getOld">
        SELECT profile_pic 
        FROM users 
        WHERE username = 
        <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <!-- Delete old file -->
    <cfif getOld.recordCount GT 0 AND len(getOld.profile_pic)>
        <cfset oldPath = expandPath("/CRM_project/" & getOld.profile_pic)>
        <cfif fileExists(oldPath)>
            <cffile action="delete" file="#oldPath#">
        </cfif>
    </cfif>

    <!-- Resize image -->
    <cfimage
        action="resize"
        source="#cffile.serverDirectory#/#cffile.serverFile#"
        width="200"
        height="200"
        destination="#cffile.serverDirectory#/#cffile.serverFile#"
        overwrite="yes">

    <!-- Save to DB -->
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

<cfcatch>
    <cfoutput>Error uploading file!</cfoutput>
</cfcatch>

</cftry>

<br>

</div>