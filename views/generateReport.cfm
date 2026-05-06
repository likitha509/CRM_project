<cfparam name="url.department" default="">
<cfquery name="qReq">
SELECT id, title, description, department, created_by
FROM requests
WHERE 1=1

<cfif len(url.department)>
AND department = <cfqueryparam value="#url.department#" cfsqltype="cf_sql_varchar">
</cfif>

ORDER BY id DESC
</cfquery>
<cfheader name="Content-Disposition" value="attachment; filename=Requests_Report.pdf">
<cfdocument format="pdf">
<h2 align="center">CRM Requests Report</h2>
<table border="1" cellpadding="5" cellspacing="0">
<tr>
<th>ID</th>
<th>Title</th>
<th>Description</th>
<th>Department</th>
<th>Created By</th>
</tr>
<cfoutput query="qReq">
<tr>
<td>#id#</td>
<td>#title#</td>
<td>#description#</td>
<td>#department#</td>
<td>#created_by#</td>
</tr>
</cfoutput>

</table>

</cfdocument>