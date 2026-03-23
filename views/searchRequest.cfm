<cfparam name="url.search" default="">

<cfquery name="qReq" datasource="myDB">

SELECT id,title,description,department,created_by
FROM requests

WHERE department LIKE
<cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">

</cfquery>

<cfoutput query="qReq">

<tr>
<td>#id#</td>
<td>#title#</td>
<td>#description#</td>
<td>#department#</td>
<td>#created_by#</td>

<td>
<a href="/CRM_project/index.cfm?crm=editRequest&id=#id#">Edit</a> |
<a href="javascript:void(0)" onclick="deleteRequest(#id#)">Delete</a>
</td>

</tr>

</cfoutput>