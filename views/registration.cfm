
<link rel="stylesheet" href="/CRM_project/css/register.css">
<script src="/CRM_project/js/register.js"></script>
<div class="container">
<h2>Register</h2>
<form action="/CRM_project/index.cfm?crm=sendOTP" method="post" onsubmit="return validateRegister()">
<label>Username</label>
<input type="text" name="username" required />
<label>Password</label>
<input type="password" name="password" id="password" required 
pattern="^(?=.*[!@#$%^&*]).{8,}$"
title="Password must contain at least one special character">

<label>Email</label>
<input type="email" name="email" required />
<input type="submit" value="Register" />
</form>

<br>

</div>
