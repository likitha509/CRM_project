<head>

    <link rel="stylesheet" href="/CRM_project/css/logs.css">

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Pagination JS -->
    <script src="/CRM_project/js/pagination.js"></script>

    <!-- Logs JS -->
    <script src="/CRM_project/js/logs.js"></script>

</head>

<body>

<h2 style="text-align:center;">Activity Logs</h2>

<br>

<table border="1" cellpadding="8" width="90%" align="center">

    <thead>
        <tr>
            <th>Username</th>
            <th>Action</th>
            <th>Details</th>
            <th>Date & Time</th>
        </tr>
    </thead>

    <tbody id="logsTable"></tbody>

</table>

<br>

<div id="pagination" style="text-align:center;"></div>
<br>
<!-- ColdFusion Data -->
<script>

let logsData = [

<cfoutput query="data">
{
    username : "#encodeForJavaScript(username)#",
    action   : "#encodeForJavaScript(action)#",
    details  : "#encodeForJavaScript(details)#",
    date     : "#dateTimeFormat(created_at,'dd-mm-yyyy HH:nn')#"
},
</cfoutput>

];

</script>

</body>