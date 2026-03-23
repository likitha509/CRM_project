
<link rel="stylesheet" href="/CRM_project/css/edit.css">
<script src="/CRM_project/js/edit.js"></script>
<cfif NOT structKeyExists(session, "loggedIn") OR NOT session.loggedIn>
  <cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<!-- Get ID from URL -->
<cfset reqId = url.id>
<!-- Fetch record -->
<cfquery name="qReq">
  SELECT * FROM requests
  WHERE id =
  <cfqueryparam value="#reqId#" cfsqltype="cf_sql_integer">
</cfquery>

<h2>Edit Request</h2>

<cfoutput query="qReq">

<div class="form-box">

<form onsubmit="updateRequest(); return false;">

  <input type="hidden" name="id" value="#id#" id="id">

  Title:<br>
  <input type="text" name="title" value="#title#" id="title"><br><br>

  Description:<br>
  <textarea name="description" id="description">#description#</textarea><br><br>

  <input type="submit" value="Update Request">

</form>

<br>
</div>

</cfoutput>

