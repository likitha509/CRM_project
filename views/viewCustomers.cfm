<head>
<link rel="stylesheet" href="/CRM_project/css/forgot.css">

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- JS -->
<script src="/CRM_project/js/customers.js"></script>
<script src="/CRM_project/js/pagination.js"></script>
</head>

<!-- Params -->
<cfparam name="url.search" default="">

<!-- =========================
        QUERY (FULL DATA)
========================= -->
<cfquery name="qCustomers" datasource="myDB">
SELECT id, name, email, phone, city
FROM customers1
WHERE (
    name LIKE <cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">
    OR email LIKE <cfqueryparam value="%#url.search#%" cfsqltype="cf_sql_varchar">
)
ORDER BY id DESC
</cfquery>

<h2 style="text-align:center">Customers</h2>

<div style="text-align:center; margin-bottom:20px;">
<a href="/CRM_project/reports/downloadPdf.cfm" target="_blank">
Download Customers PDF
</a>
</div>

<!-- =========================
        FORM
========================= -->
<div class="customer-form">

<h3>Add / Update Customer</h3>

<div class="form-group">
<label>Name</label>
<input type="text" id="name">
</div>

<div class="form-group">
<label>Email</label>
<input type="email" id="email">
</div>

<div class="form-group">
<label>Phone</label>
<input type="text" id="phone" maxlength="10"
oninput="this.value=this.value.replace(/[^0-9]/g,'')">
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

<!-- =========================
        SEARCH (CLIENT SIDE)
========================= -->
<div style="text-align:center">
<input type="text"
id="searchBox"
placeholder="Search customer..."
onkeyup="filterCustomers()">
</div>

<br>

<!-- =========================
        TABLE
========================= -->
<table border="1" width="80%" align="center">

<tr>
<th>ID</th>
<th>Name</th>
<th>Email</th>
<th>Phone</th>
<th>City</th>
<th>Action</th>
</tr>

<tbody id="customerTable"></tbody>

</table>

<br>

<!-- PAGINATION -->
<div id="pagination" style="text-align:center;"></div>

<br>
<!--  ONLY DATA -->
<script>
<cfoutput>
window.rawCustomers = #serializeJSON(qCustomers)#;
</cfoutput>
</script>