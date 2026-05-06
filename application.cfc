component {
    //  App settings
    this.name = "CRM_App";
    this.datasource = "myDB";

    //  Session settings
    this.sessionManagement = true;
    this.sessionTimeout = createTimeSpan(0,0,30,0);
    //  Mappings
    this.mappings["/components"] = expandPath("/CRM_project/components");
    function onApplicationStart(){

    application.appName = "CRM";

    // Controller create
    application.controller = createObject("component", "components.controller");

}
    //  Session Start
    function onSessionStart(){
        session.loggedIn = false;
        session.userId = 0;
        session.username = "";
        session.is_admin = 0;
    }
    
    //  Request Start (LOGIN VALIDATION )  
    function onRequestStart(targetPage){

        // Cache control
        cfheader(name="Cache-Control", value="no-store, no-cache, must-revalidate");
        cfheader(name="Pragma", value="no-cache");
        cfheader(name="Expires", value="0");

        if(structKeyExists( url,"restart")){
            onApplicationStart();
        }
        // Public pages
       var publicPages = "login,loginCheck,register,sendOTP,verifyOTP,forgotPassword,sendResetLink,resetPassword";
   var adminPages = "viewCustomers,viewLogs,viewUsers";

        // Session validation
        if (
    NOT structKeyExists(session,"loggedIn") OR 
    NOT session.loggedIn
) {
    if (
        NOT structKeyExists(url, "crm") OR
        NOT listFindNoCase(publicPages, url.crm)
    ) {
        location(url="index.cfm?crm=login", addToken=false);
    }
}
 if (
        structKeyExists(url,"crm") AND
        listFindNoCase(adminPages, url.crm)
    ) {
        if (NOT structKeyExists(session,"is_admin") OR session.is_admin NEQ 1) {
            location(url="index.cfm?crm=home", addToken=false);
        } 
    }

    include "views/common/header.cfm";
}
    //  Request End (FOOTER CONTROL)
    function onRequestEnd(){

        var noFooterPages = "login,LoginCheck,register,forgotPassword,sendResetLink,resetPassword,SendOtp,home";

        if (
            NOT structKeyExists(url, "crm") OR
            NOT listFindNoCase(noFooterPages, url.crm)
        ) {
            include "views/common/footer.cfm";
        }
    }
    //  Session End 
    function onSessionEnd(sessionScope, applicationScope){

    try{

        // Check username exists
        if (
            structKeyExists(arguments.sessionScope,"username")
            AND len(trim(arguments.sessionScope.username))
        ) {

            queryExecute(
                "INSERT INTO logs (username, action, details)
                 VALUES (?, 'Session End', 'Session expired')",

                [ arguments.sessionScope.username ],

                { datasource = "myDB" }
            );

        }

    } catch(any e){

        cflog(
            file="sessionErrors",
            text="onSessionEnd Error: #e.message#"
        );

    }

} //  Global Error Handler
    function onError(exception, eventName){

        // File log
        cflog(
            file="errorLogs",
            text="Error in #eventName#: #exception.message#",
            type="error"
        );

        writeDump(exception);
    abort;


    }

}