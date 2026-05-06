<link rel="stylesheet" href="/CRM_project/css/register.css">

<!-- Form validation -->
<cfif NOT structKeyExists(form,"username") OR 
      NOT structKeyExists(form,"email") OR 
      NOT structKeyExists(form,"password")>
    <cflocation url="index.cfm?crm=register" addtoken="false">
    <cfabort>
</cfif>

<!-- Trim -->
<cfset form.username = trim(form.username)>
<cfset form.email = trim(form.email)>
<cfset form.password = trim(form.password)>

<!-- Check user -->
<cfquery name="checkUser" datasource="myDB">
SELECT id
FROM users
WHERE username =
<cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
OR email =
<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfif checkUser.recordCount GT 0>
    <div class="container">
        <h2>User already exists</h2>
        <a href="/CRM_project/index.cfm?crm=login">Go to Login</a>
    </div>
    <cfabort>
</cfif>

<!-- Store -->
<cfset session.reg_username = form.username>
<cfset session.reg_password = hash(form.password, "SHA-256")>
<cfset session.reg_email = form.email>

<!-- OTP -->
<cfset session.otp = RandRange(100000,999999)>
<cfset session.otpTime = now()>

<!-- Send Email -->
<cfmail
to="#session.reg_email#"
from="bendilikitha@gmail.com"
subject="OTP for Registration"
server="smtp.gmail.com"
port="587"
username="bendilikitha@gmail.com"
password="gravyblertrjshbi"
useTLS="true">

Your OTP is: #session.otp#

</cfmail>

<div class="container">
<h2>Verify OTP</h2>
<p>OTP sent to your email</p>

<form action="/CRM_project/index.cfm?crm=verifyOTP" method="post">
<label>Enter OTP</label>
<input type="number" name="otp" required>
<input type="submit" value="Verify OTP">
</form>

<cfinclude template="common/backToLogin.cfm">
</div>