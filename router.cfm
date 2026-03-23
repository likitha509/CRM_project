<cfparam name="url.crm" default="login">
<cfif url.crm EQ "login">
    <cfinclude template="views/login.cfm">
<cfelseif url.crm EQ "sendOTP">
    <cfinclude template="views/sendOTP.cfm">
<cfelseif url.crm EQ "resetOTP">
    <cfinclude template="views/resetOTP.cfm">
<cfelseif url.crm EQ "loginCheck">
    <cfinclude template="views/loginCheck.cfm">
<cfelseif url.crm EQ "register">
    <cfinclude template="views/registration.cfm">
<cfelseif url.crm EQ "forgotPassword">
    <cfinclude template="views/forgotPassword.cfm">
<cfelseif url.crm EQ "resetPassword">
    <cfinclude template="views/resetPassword.cfm">
<cfelseif crm EQ "sendResetLink">
    <cfinclude template="views/sendResetLink.cfm">
<cfelseif url.crm EQ "home">
    <cfinclude template="views/home.cfm">
<cfelseif url.crm EQ "editRequest">
<cfinclude template="views/editRequest.cfm">
<cfelseif url.crm EQ "submitRequest">
    <cfinclude template="views/requestForm.cfm">
<cfelseif url.crm EQ "viewRequests">
    <cfinclude template="views/viewRequests.cfm">
<cfelseif url.crm EQ "viewCustomers">
    <cfinclude template="views/viewCustomers.cfm">
<cfelseif url.crm EQ "viewUsers">
    <cfinclude template="views/viewUsers.cfm">
<cfelseif url.crm EQ "viewLogs">
    <cfinclude template="views/viewLogs.cfm">
<cfelseif url.crm EQ "logout">
    <cfinclude template="views/logout.cfm">
<cfelseif url.crm EQ "uploadProfile">
    <cfinclude template="views/uploadProfile.cfm">
<cfelseif url.crm EQ "deleteLogs">
    <cfinclude template="views/deleteLogs.cfm">
<cfelseif url.crm EQ "updateRequest">
    <cfinclude template="views/updateRequest.cfm">
<cfelseif url.crm EQ "saveRequest">
    <cfinclude template="views/saveRequest.cfm">
<cfelseif url.crm EQ "saveProfile">
    <cfinclude template="views/saveProfile.cfm">
<cfelseif url.crm EQ "deleteRequest">
    <cfinclude template="views/deleteRequest.cfm">
<cfelseif url.crm EQ "searchRequest">
    <cfinclude template="views/searchRequest.cfm">
<cfelseif url.crm EQ "generateReport">
    <cfinclude template="views/generateReport.cfm">
    <cfelseif url.crm EQ "deletePhoto">
    <cfinclude template="views/deletePhoto.cfm">
</cfif>