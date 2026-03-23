
<link rel="stylesheet" href="/CRM_project/css/login.css">
<script src="/CRM_project/js/login.js"></script>
<body>
<!-- Navbar -->
<div class="navbar">
CRM Login
</div>

<!-- Login container -->
<div class="login-container">

<div class="login-box">
<form method="post" action="/CRM_project/index.cfm?crm=loginCheck" onsubmit="return validateLogin()">
<label>Username</label>
<input type="text" name="username" required>
<div class="password-box">
<label>Password</label>
<div class="password-input">
<input type="password" name="password" id="password" required>
<span class="toggle-password" onclick="togglePassword()">👁</span>
</div>
</div>
<button type="submit">Login</button>

<p id="msg"></p>


<p>
<a href="/CRM_Project/index.cfm?crm=register">Register Here</a>
</p>

<p>
<a href="/CRM_Project/index.cfm?crm=forgotPassword">Forgot Password?</a>
</p>

</form>

</div>

</div>
</body>
</html>