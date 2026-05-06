<link rel="stylesheet" href="/CRM_project/css/register.css">
<script src="/CRM_project/js/register.js"></script>

<div class="container">
    <h2>Register</h2>

    <!-- Message -->
    <p id="msg" style="color:red; text-align:center;"></p>

    <form action="/CRM_project/index.cfm?crm=sendOTP" method="post" onsubmit="return validateRegister()">

        <label>Username</label>
        <input type="text" name="username" id="username" required />

        <label>Password</label>
        <input type="password" name="password" id="password" required />

        <label>Confirm Password</label>
        <input type="password" name="confirmPassword" id="confirmPassword" required />

        <label>Email</label>
        <input type="email" name="email" id="email" required />

        <input type="submit" value="Register" id="submitBtn" />

    </form>

    <br>

    <!-- Navigation -->
    <div style="text-align:center;">
        <p>
            Already have an account? 
           <cfinclude template="common/backToLogin.cfm">
        </p>
    </div>
</div>