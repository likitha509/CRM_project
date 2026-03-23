<cfset username = "Admin">
<cfset ip = CGI.REMOTE_ADDR>

<!-- Save log -->

<cfquery>
INSERT INTO pdf_download_logs(user_name,download_time,ip_address)
VALUES(
<cfqueryparam value="#username#" cfsqltype="cf_sql_varchar">,
NOW(),
<cfqueryparam value="#ip#" cfsqltype="cf_sql_varchar">
)
</cfquery>

<!-- Redirect to PDF -->

<cflocation url="customerPdf.cfm" addtoken="false">