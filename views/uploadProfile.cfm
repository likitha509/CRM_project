
<link rel="stylesheet" href="/CRM_project/css/styleUpload.css">
<script src="/CRM_project/js/upload.js"></script>

<!-- Login Check -->
<cfif NOT structKeyExists(session, "loggedIn")>
    <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<cfquery name="getUser">
    SELECT profile_pic
    FROM users
    WHERE username = 
    <cfqueryparam value="#session.username#" cfsqltype="cf_sql_varchar">
</cfquery>

<div class="upload-container">

<h2>Upload Profile Photo</h2>

<form action="/CRM_project/index.cfm?crm=saveProfile" 
      method="post" 
      enctype="multipart/form-data">

    <label>Select Image:</label>

    <input type="file" 
           name="profilePic" 
           id="profilePic"
           accept=".jpg,.jpeg,.png"
           onchange="validateImage()"
           required>

    <input type="submit" value="Upload Photo">

</form>

<h3>Your Current Profile Photo</h3>

<cfif getUser.recordCount GT 0 AND len(getUser.profile_pic)>
    <cfoutput>
        <img src="/CRM_project/#getUser.profile_pic#" width="200" class="avatar">

        <br>

        <form action="/CRM_project/index.cfm?crm=deletePhoto" method="post">
            <input type="hidden" name="photoPath" value="#getUser.profile_pic#">
            <input type="submit" value="Delete Photo"
                   onclick="return confirm('Are you sure you want to delete this photo?');">
        </form>
    </cfoutput>
<cfelse>
    <div class="avatar" width="200">
        <cfoutput>#ucase(left(session.username,1))#</cfoutput>
    </div>
</cfif>

</div>