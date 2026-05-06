<head>
<link rel="stylesheet" href="/CRM_project/css/req.css">
</head>

<div class="center-wrapper">
  <div class="form-box">

    <h2>Submit Request</h2>

    <form method="POST" action="/CRM_project/index.cfm?crm=addreq">

      <label>Title:</label>
      <input type="text" name="title" id="title" required>

      <label>Description:</label>
      <textarea name="description" id="description" required></textarea>

      <label>Department:</label>
      <select name="department" id="department" required>
          <option value="">Select Department</option>
          <option value="IT">IT</option>
          <option value="HR">HR</option>
          <option value="Finance">Finance</option>
          <option value="Admin">Admin</option>
      </select>

      <br><br>

      <input type="submit" value="Submit Request">

    </form>

    <br>

    <a href="/CRM_project/index.cfm?crm=home" class="back-link">
        Back to Home
    </a>

  </div>
</div>