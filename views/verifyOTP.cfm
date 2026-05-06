<link rel="stylesheet" href="/CRM_project/css/register.css">
<div class="container">

<!-- FORM VALIDATION -->
<cfif NOT structKeyExists(form,"otp") OR len(trim(form.otp)) EQ 0>
    <h3>OTP missing. Please try again.</h3>
    <a href="/CRM_project/index.cfm?crm=register">Go to Register</a>
    <cfabort>
</cfif>

<!-- SESSION VALIDATION -->
<cfif NOT structKeyExists(session,"otp") 
    OR NOT structKeyExists(session,"reg_username")
    OR NOT structKeyExists(session,"reg_email")
    OR NOT structKeyExists(session,"otpTime")>

    <h3>Session expired. Please register again.</h3>
    <a href="/CRM_project/index.cfm?crm=register">Go to Register</a>
    <cfabort>

</cfif>

<!-- OTP EXPIRY CHECK -->
<cfif dateDiff("n", session.otpTime, now()) GT 5>
    <h2>OTP Expired</h2>
    <a href="/CRM_project/index.cfm?crm=register">Register Again</a>
    <cfabort>
</cfif>
<!-- OTP MATCH -->
<cfif int(form.otp) EQ int(session.otp)>
    <!-- INSERT USER -->
    <cftry>

<cfquery datasource="myDB">
    INSERT INTO users (username,password,email)
    VALUES (
        <cfqueryparam value="#session.reg_username#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#session.reg_password#" cfsqltype="cf_sql_varchar">,
        <cfqueryparam value="#session.reg_email#" cfsqltype="cf_sql_varchar">
    )
</cfquery>


<cfcatch>
    <cfoutput>
        ERROR: #cfcatch.message# <br>
        DETAIL: #cfcatch.detail#
    </cfoutput>
</cfcatch>

</cftry>

    <!-- CLEAR SESSION -->
    <cfset structDelete(session,"otp")>
    <cfset structDelete(session,"otpTime")>
    <cfset structDelete(session,"reg_username")>
    <cfset structDelete(session,"reg_password")>
    <cfset structDelete(session,"reg_email")>

    <!-- SUCCESS -->
    <h2>Account Created Successfully </h2>
    <a href="/CRM_project/index.cfm?crm=login">Go to Login</a>

<cfelse>

    <h2>Invalid OTP </h2>
    <a href="/CRM_project/index.cfm?crm=register">Try Again</a>

</cfif>

</div>