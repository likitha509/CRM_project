<!-- Route -->
<cfparam name="url.crm" default="login">
<cfset crm = url.crm>

<!-- =========================
        ROUTING
========================= -->

<!-- LOGIN -->
<cfif crm EQ "login">
    <cfinclude template="views/login.cfm">

<cfelseif crm EQ "loginCheck">
    <cfinclude template="views/loginCheck.cfm">

<cfelseif crm EQ "register">
    <cfinclude template="views/registration.cfm">

<cfelseif crm EQ "sendOTP">
    <cfinclude template="views/sendOTP.cfm">

<cfelseif crm EQ "verifyOTP">
    <cfinclude template="views/verifyOTP.cfm">

<cfelseif crm EQ "forgotPassword">
    <cfinclude template="views/forgotPassword.cfm">

<cfelseif crm EQ "sendResetLink">
    <cfinclude template="views/sendResetLink.cfm">

<cfelseif crm EQ "resetPassword">
    <cfinclude template="views/resetPassword.cfm">


<!-- HOME -->
<cfelseif crm EQ "home">
    <cfinclude template="views/home.cfm">


<!-- =========================
        REQUESTS
========================= -->

<cfelseif crm EQ "viewRequests">

    <cfparam name="url.search" default="">
    <cfparam name="url.department" default="">

    <cfset requests = application.controller.fetchRequests(
        url.search,
        url.department
    )>

    <cfinclude template="views/viewRequests.cfm">


<cfelseif crm EQ "submitRequest">
    <cfinclude template="views/requestForm.cfm">


<cfelseif crm EQ "addreq">

    <cfset formRes = application.controller.createRequest(info=form) />

    <cfif formRes EQ "">
        <cflocation url="index.cfm?crm=viewRequests" addtoken="false">
        <cfabort>
    <cfelse>
       <cfoutput>#formRes#</cfoutput>
    </cfif>


<cfelseif crm EQ "editRequest">
    <cfinclude template="views/editRequest.cfm">


<cfelseif crm EQ "updateRequest">

    <cfset formRes = application.controller.updateRequest(
        id=form.id,
        info=form
    ) />

    <cflocation url="index.cfm?crm=viewRequests" addtoken="false">
    <cfabort>


<cfelseif crm EQ "deleteRequest">

    <cfif NOT structKeyExists(url,"id")>
        <cflocation url="index.cfm?crm=viewRequests" addtoken="false">
        <cfabort>
    </cfif>

    <cfset formRes = application.controller.deleteRequest(id=url.id) />
    <cflocation url="index.cfm?crm=viewRequests" addtoken="false">
    <cfabort>


<cfelseif crm EQ "generateReport">
    <cfinclude template="views/generateReport.cfm">


<!-- =========================
        PROFILE
========================= -->

<cfelseif crm EQ "uploadProfile">
    <cfinclude template="views/uploadProfile.cfm">

<cfelseif crm EQ "saveProfile">
    <cfinclude template="views/saveProfile.cfm">

<cfelseif crm EQ "deletePhoto">
    <cfinclude template="views/deletePhoto.cfm">


<!-- =========================
        ADMIN
========================= -->

<cfelseif crm EQ "viewLogs">

    <cfset data = application.controller.fetchLogsNew()>

    <cfinclude template="views/viewLogs.cfm">
<cfelseif crm EQ "viewUsers">
    <cfset data = application.controller.fetchUsers() />
    <cfinclude template="views/viewUsers.cfm">

<cfelseif crm EQ "viewCustomers">
    <cfinclude template="views/viewCustomers.cfm">


<!-- LOGOUT -->
<cfelseif crm EQ "logout">
    <cfinclude template="views/logout.cfm">


<!-- INVALID -->
<cfelse>
    <h2 style="text-align:center;">Page Not Found</h2>
</cfif>