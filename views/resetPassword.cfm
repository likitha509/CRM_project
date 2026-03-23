<head>
<link rel="stylesheet" href="/CRM_project/css/home.css">
<script src="/CRM_Project/js/reset.js"></script>
</head>

<cfset token = url.token>

<!--- Step 1: Check token --->
<cfquery name="checkToken">
SELECT * FROM users
WHERE reset_token = <cfqueryparam value="#token#">
AND token_expiry > <cfqueryparam value="#now()#" cfsqltype="cf_sql_timestamp">
</cfquery>

<cfif checkToken.recordCount EQ 0>
    <cfoutput>Invalid or expired link</cfoutput>
    <cfabort>
</cfif>

<!--- Step 2: If form submitted --->
<cfif structKeyExists(form, "password")>

    <!--- Password validation --->
    <cfif NOT reFind("^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$", form.password)>
        <cfoutput>Password must contain letters, numbers, and special characters (min 8 chars)</cfoutput>
        <cfabort>
    </cfif>

    <!--- Update password --->
    <cfquery>
    UPDATE users
    SET password = <cfqueryparam value="#form.password#">,
        reset_token = NULL,
        token_expiry = NULL
    WHERE reset_token = <cfqueryparam value="#token#">
    </cfquery>

    <cfoutput>
       <h4></h4> Password updated successfully.</h4><br>
        <a href="/CRM_project/index.cfm?crm=login">Go to Login</a>
    </cfoutput>

    <cfabort>

</cfif>

<!--- Step 3: Show form --->
<div class="login-container">
<div class="login-box">

<h2>Reset Password</h2>

<form method="post" onsubmit="return validatePassword()">

<label>New Password</label>
<input type="password" name="password" id="password" required>

<p id="errorMsg" style="color:red;"></p>

<br>

<button type="submit">Reset Password</button>

</form>

</div>
</div>

