<cfcomponent output="false">

<cffunction name="login" access="public" output="false">
    <cfinclude template="../views/login.cfm">
</cffunction>

<cffunction name="home" access="public" output="false">
    <cfinclude template="../views/home.cfm">
</cffunction>

<cffunction name="viewRequests" access="public" output="false">
    <cfinclude template="../views/viewRequests.cfm">
</cffunction>

<cffunction name="submitRequest" access="public" output="false">
    <cfinclude template="../views/requestForm.cfm">
</cffunction>

<cffunction name="viewUsers" access="public" output="false">
    <cfinclude template="../views/viewUsers.cfm">
</cffunction>

<cffunction name="viewCustomers" access="public" output="false">
    <cfinclude template="../views/viewCustomers.cfm">
</cffunction>

<cffunction name="viewLogs" access="public" output="false">
    <cfinclude template="../views/viewLogs.cfm">
</cffunction>
</cfcomponent>