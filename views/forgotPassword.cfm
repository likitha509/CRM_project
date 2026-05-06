<link rel="stylesheet" href="/CRM_project/css/forgot.css">

<div class="container">

    <h2>Forgot Password</h2>

    <form action="/CRM_project/index.cfm?crm=sendResetLink" method="post">

        <label>Enter your Email</label>
        <input type="email" name="email" required>

        <br><br>

        <button type="submit">Send OTP</button>

    </form>

    <br>

    <cfinclude template="common/backToLogin.cfm">

</div>