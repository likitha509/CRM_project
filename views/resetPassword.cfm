<head>
<link rel="stylesheet" href="/CRM_project/css/home.css">
<script src="/CRM_project/js/reset.js"></script>
</head>
<cfif NOT structKeyExists(url,"token") OR len(trim(url.token)) EQ 0>
    <h3>Invalid request</h3>
    <a href="/CRM_project/index.cfm?crm=login">Go to Login</a>
    <cfabort>
</cfif>

<cfset token = url.token>

<!-- If form submitted -->
<cfif structKeyExists(form, "password")>

    <!-- Backend validation -->
    <cfif NOT reFind("^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$", form.password)>
        <cfoutput>
            Password must contain uppercase, lowercase, number, special character (min 8 chars)
        </cfoutput>
        <cfabort>
    </cfif>

    <!-- Hash password -->
    <cfset hashedPassword = hash(form.password, "SHA-256")>

    <!-- Update password -->
    <cfquery >
        UPDATE users
        SET password = <cfqueryparam value="#hashedPassword#" cfsqltype="cf_sql_varchar">,
            reset_token = NULL,
            token_expiry = NULL
        WHERE reset_token = <cfqueryparam value="#token#" cfsqltype="cf_sql_varchar">
    </cfquery>

    <!-- Success -->
    <cfoutput>
        <h3>Password updated successfully</h3>
        <a href="/CRM_project/index.cfm?crm=login">Go to Login</a>
    </cfoutput>

    <cfabort>

</cfif>

<!-- Form UI -->
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

<cfinclude template="common/backToLogin.cfm">

</div>