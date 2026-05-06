<!-- Get today's logs -->
<cfquery name="qLogs">
SELECT user_name, download_time, ip_address
FROM pdf_download_logs
WHERE DATE(download_time) = CURDATE()
ORDER BY download_time DESC
</cfquery>

<!-- Total downloads -->
<cfset totalDownloads = qLogs.recordcount>

<!-- Send Email -->
<cfmail
server="smtp.gmail.com"
port="587"
username="bendilikitha@gmail.com"
password="gravyblertrjshbi"
useTLS="true"
to="bendilikitha@gmail.com"
from="bendilikitha@gmail.com"
subject="Daily Customer PDF Download Report"
type="html">

<h2>Daily Customer PDF Download Report</h2>

<p>Total Downloads Today: <b>#totalDownloads#</b></p>

<table border="1" cellpadding="5">
<tr>
<th>User</th>
<th>Download Time</th>
<th>IP Address</th>
</tr>
<!-- Loop rows safely -->
<cfloop query="qLogs">
<tr>
<td>#qLogs.user_name#</td>
<td>#qLogs.download_time#</td>
<td>#qLogs.ip_address#</td>
</tr>
</cfloop>

</table>

</cfmail>