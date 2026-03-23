<link rel="stylesheet" href="/CRM_project/css/register.css">
<!-- Check if user already exists -->

<cfquery name="checkUser">
SELECT *
FROM users
WHERE username =
<cfqueryparam value="#form.username#" cfsqltype="cf_sql_varchar">
OR email =
<cfqueryparam value="#form.email#" cfsqltype="cf_sql_varchar">
</cfquery>

<cfset usernameExists = false>
<cfset emailExists = false>

<cfloop query="checkUser">

    <cfif checkUser.username EQ form.username>
        <cfset usernameExists = true>
    </cfif>

    <cfif checkUser.email EQ form.email>
        <cfset emailExists = true>
    </cfif>

</cfloop>

<cfif usernameExists OR emailExists>

<div class="container">

<h2>

<cfif usernameExists>
Username already exists<br>
</cfif>

<cfif emailExists>
Email already registered
</cfif>

</h2>

<br>

<a href="/CRM_project/index.cfm?crm=login">
Go to Login
</a>

</div>

<cfabort>

</cfif>


<!-- Store values in session -->

<cfset session.reg_username = form.username>
<cfset session.reg_password = form.password>
<cfset session.reg_email = form.email>

<!-- Generate OTP -->

<cfset session.otp = RandRange(100000,999999)>

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
<input type="text" name="otp" required>

<input type="submit" value="Verify OTP">

</form>

<br>
<a href="/CRM_project/index.cfm?crm=login">
Back to Login
</a>

</div>