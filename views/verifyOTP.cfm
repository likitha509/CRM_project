 <link rel="stylesheet" href="/CRM_project/css/register.css">

<div class="container">

<cfif form.otp EQ session.otp>

<!-- Insert user -->

<cfquery datasource="myDB">
INSERT INTO users (username,password,email)
VALUES (
'#session.reg_username#',
'#session.reg_password#',
'#session.reg_email#'
)
</cfquery>

<!-- Redirect to login -->

<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">

<cfelse>

<h2>Invalid OTP</h2>

<br>

<a href="/CRM_project/index.cfm?crm=register">
Try Again
</a>

</cfif>

</div>
