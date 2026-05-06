<link rel="stylesheet" href="/CRM_project/css/edit.css">

<!-- Validate ID -->
<cfif NOT structKeyExists(url,"id")>
    <cflocation url="/CRM_project/index.cfm?crm=viewRequests" addtoken="false">
</cfif>

<cfset reqId = url.id>

<!-- Fetch record -->
<cfquery name="qReq">
    SELECT * FROM requests
    WHERE id = 
    <cfqueryparam value="#reqId#" cfsqltype="cf_sql_integer">
</cfquery>

<!-- If no record -->
<cfif qReq.recordCount EQ 0>
    <cfoutput>Request not found</cfoutput>
    <cfabort>
</cfif>

<h2>Edit Request</h2>

<cfoutput query="qReq">

<div class="form-box">

<form method="POST" action="/CRM_project/index.cfm?crm=updateRequest">

    <input type="hidden" name="id" value="#id#">

    <label>Title:</label><br>
    <input type="text" name="title" value="#encodeForHTML(title)#" required><br><br>

    <label>Description:</label><br>
    <textarea name="description" required>#description#</textarea><br><br>

    <label>Department:</label><br>
    <select name="department" required>
        <option value="IT" <cfif department EQ "IT">selected</cfif>>IT</option>
        <option value="HR" <cfif department EQ "HR">selected</cfif>>HR</option>
        <option value="Finance" <cfif department EQ "Finance">selected</cfif>>Finance</option>
    </select><br><br>

    <input type="submit" value="Update Request">

</form>

</div>

</cfoutput>