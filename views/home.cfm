
<link rel="stylesheet" href="/CRM_project/css/home.css">
<script src="/CRM_project/js/home.js"></script>
<body>
<div class="page-wrapper">
    <!-- HEADER -->
    <div class="header">
        <!-- MENU BUTTON -->
        <button class="menu-btn" onclick="toggleMenu()">☰</button>
        <!-- PROFILE QUERY -->
        <cfquery name="qProfile">
            SELECT profile_pic
            FROM users
            WHERE username =
            <cfqueryparam 
                value="#session.username#" 
                cfsqltype="cf_sql_varchar">
        </cfquery>
        <!-- PROFILE SECTION -->
        <cfoutput>
        <div class="profile-section">
            <!-- PROFILE IMAGE -->
            <cfif qProfile.recordCount GT 0 
                AND len(qProfile.profile_pic)>
                <img 
                    src="/CRM_project/#qProfile.profile_pic#">
            <cfelse>
                <!-- DEFAULT AVATAR -->
                <div class="avatar">
                    #ucase(left(session.username,1))#
                </div>
            </cfif>
            <!-- USER INFO -->
            <div class="user-info">
                <h1>
                    Welcome #session.username#
                </h1>
                <a 
                    href="/CRM_project/index.cfm?crm=logout"
                    class="logout-link">
                    Logout
                </a>
            </div>
        </div>
        </cfoutput>
    </div>
    <!-- CONTENT -->
    <div class="content">
        <!-- NAVBAR -->
        <div id="menu" class="navbar">
            <a href="/CRM_project/index.cfm?crm=submitRequest">
                Submit Request
            </a>
            <a href="/CRM_project/index.cfm?crm=viewRequests">
                View Requests
            </a>
            <cfif session.is_admin EQ 1>
                <a href="index.cfm?crm=viewCustomers">
                    View Customers
                </a>
                <a href="index.cfm?crm=viewLogs">
                    View Logs
                </a>
                <a href="index.cfm?crm=viewUsers">
                    Registered Users
                </a>
            </cfif>
            <a href="index.cfm?crm=uploadProfile">
                Upload Profile Picture
            </a>
        </div>
    </div>
    <!-- FOOTER -->
    <footer class="footer">
        © 2026 CRM Project | Developed by Likitha
    </footer>
</div>
</body>