<head>
<link rel="stylesheet" href="/CRM_project/css/req.css">
<script src="/CRM_project/js/form.js"></script>
</head>

<cfif NOT structKeyExists(session, "loggedIn")>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>
<div class="center-wrapper">
  <div class="form-box">
    <h2>Submit Request</h2>
 <form onsubmit="addRequest(); return false;">
<label>Title:</label>
<input type="text" name="title" id="title">
<label>Description:</label>
<textarea name="description" id="description"></textarea>
<label>Department:</label>
<select name="department"  id="department" required>
    <option value="">Select Department</option>
    <option value="IT">IT</option>
    <option value="HR">HR</option>
    <option value="Finance">Finance</option>
    <option value="Admin">Admin</option>
</select>
      <input type="submit" value="Submit Request">
    </form>
    <cflog file="activityLogs"
text="User #session.username# submitted request"
type="information">
    <a href="/CRM_project/index.cfm?crm=home"  class="back-link">
Back to Home
</a>
  </div>
</div>




