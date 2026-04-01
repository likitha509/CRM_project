component {
    this.name = "CRM_App";
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0,0,30,0);
    this.datasource = "myDB";
    this.mappings["/components"] = expandPath("/CRM_project/components");
    
    function onRequestStart(){
        cfheader(name="Cache-Control", value="no-store, no-cache, must-revalidate");
        cfheader(name="Pragma", value="no-cache");
        cfheader(name="Expires", value="0");
        // HEADER include
        include "views/common/header.cfm";
    }

    function onRequestEnd(){
        if (
            structKeyExists(url, "crm") AND
            NOT listFindNoCase("login,LoginCheck,register,home,logout,forgotPassword,sendResetLink,resetPassword,SendOtp,searchRequest", url.crm)
        ) {
            include "views/common/footer.cfm";
        }

    }

}