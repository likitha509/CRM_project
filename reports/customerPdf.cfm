<cfquery name="qCustomers">
SELECT id,name,email,phone,city
FROM customers1
</cfquery>

<cfdocument format="pdf">

<h2>Customer Report</h2>

<table border="1" width="100%">0

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>City</th>
</tr>

<cfoutput query="qCustomers">
<tr>
<td>#id#</td>
<td>#name#</td>
<td>#email#</td>
<td>#phone#</td>
<td>#city#</td>
</tr>
</cfoutput>

</table>

</cfdocument>