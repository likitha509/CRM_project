<head>
<link rel="stylesheet" href="/CRM_project/css/forgot.css">
<script src="/CRM_project/js/customers.js"></script>
<script src="/CRM_project/js/pagination.js"></script>
</head>

<!-- Prevent Back Cache -->
<cfheader name="Cache-Control" value="no-store, no-cache, must-revalidate">
<cfheader name="Pragma" value="no-cache">
<cfheader name="Expires" value="0">

<!-- Login Check -->
<cfparam name="url.search" default="">
<cfif NOT structKeyExists(session,"loggedIn") OR NOT session.loggedIn>
<cflocation url="/CRM_project/index.cfm?crm=login" addtoken="false">
</cfif>

<!-- Admin Only -->
<cfif NOT structKeyExists(session,"is_admin") OR session.is_admin NEQ 1>
<h2>Access Denied — Admin Only</h2>
<a href="/CRM_project/index.cfm?crm=home">Back to Home</a>
<cfabort>
</cfif>

<!-- Pagination Setup -->
<cfparam name="url.page" default="1">
<cfset perPage = 4>
<cfset startRow = (url.page-1)*perPage>

<!-- Total Customers -->

<cfquery name="qCount">
SELECT COUNT(*) AS total
FROM customers1
</cfquery>
<cfset totalPages = ceiling(qCount.total/perPage)>
<!-- Customers Query -->
<cfquery name="qCustomers">

SELECT *
FROM customers1

WHERE name LIKE
<cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">

OR email LIKE
<cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">

ORDER BY id DESC

LIMIT #startRow#,#perPage#

</cfquery>

<h2 style="text-align:center">Customers</h2>
<div style="text-align:center; margin-bottom:20px;">
<a href="/CRM_project/reports/downloadPdf.cfm">
Download Customers PDF
</a>
</div>
<!-- ADD / UPDATE FORM -->

<div class="customer-form">

<h3>Add Customer</h3>

<div class="form-group">
<label>Name</label>
<input type="text" id="name">
</div>

<div class="form-group">
<label>Email</label>
<input type="text" id="email">
</div>

<div class="form-group">
<label>Phone</label>
<input type="text" id="phone" maxlength="10" oninput="this.value=this.value.replace(/[^0-9]/g,'')">
</div>

<div class="form-group">
<label>City</label>
<input type="text" id="city">
</div>

<input type="hidden" id="editId">

<br>

<div class="form-buttons">
<button onclick="addCustomer()">Add Customer</button>
<button onclick="updateCustomer()">Update Customer</button>
</div>
</div>
<br>

<!-- SEARCH -->

<div style="text-align:center">
<input type="text"
id="searchBox"
placeholder="Search customer..."
onkeyup="searchCustomer()">
</div>

<!-- CUSTOMER TABLE -->

<table border="1" width="80%" align="center">

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>City</th>
<th>Action</th>
</tr>

<tbody id="customerTable">

<cfoutput query="qCustomers">

<tr>

<td>#id#</td>
<td>#name#</td>
<td>#email#</td>
<td>#phone#</td>
<td>#city#</td>

<td>

<button onclick="editCustomer(#id#,'#name#','#email#','#phone#','#city#')">
Edit
</button>

&nbsp;&nbsp;&nbsp;

<button onclick="deleteCustomer(#id#)">
Delete
</button>

</td>

</tr>

</cfoutput>

</tbody>

</table>

<br>

<!-- PAGINATION -->
<cfinclude template="pagination.cfm">