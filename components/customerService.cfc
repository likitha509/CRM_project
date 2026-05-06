component output="false" {

    // GET ALL
    function getCustomers() {
        return queryExecute(
            "SELECT id, name, email, phone, city
             FROM customers1
             ORDER BY id DESC",
            {},
            { datasource="myDB" }
        );
    }

    // ADD
    function addCustomer(required struct data) {

        if (!structKeyExists(arguments.data, "name") OR !len(trim(arguments.data.name))) {
            return { success=false, message="Name required" };
        }

        queryExecute(
            "INSERT INTO customers1(name,email,phone,city)
             VALUES(:name,:email,:phone,:city)",
            {
                name  = {value=arguments.data.name,  cfsqltype="cf_sql_varchar"},
                email = {value=arguments.data.email, cfsqltype="cf_sql_varchar"},
                phone = {value=arguments.data.phone, cfsqltype="cf_sql_varchar"},
                city  = {value=arguments.data.city,  cfsqltype="cf_sql_varchar"}
            },
            { datasource="myDB" }
        );

        return { success=true, message="Customer Added Successfully" };
    }

    // UPDATE
    function updateCustomer(required struct data) {

        queryExecute(
            "UPDATE customers1
             SET name=:name, email=:email, phone=:phone, city=:city
             WHERE id=:id",
            {
                id    = {value=arguments.data.id, cfsqltype="cf_sql_integer"},
                name  = {value=arguments.data.name, cfsqltype="cf_sql_varchar"},
                email = {value=arguments.data.email, cfsqltype="cf_sql_varchar"},
                phone = {value=arguments.data.phone, cfsqltype="cf_sql_varchar"},
                city  = {value=arguments.data.city, cfsqltype="cf_sql_varchar"}
            },
            { datasource="myDB" }
        );

        return { success=true, message="Customer Updated" };
    }

    // DELETE
    function deleteCustomer(required numeric id) {

        queryExecute(
            "DELETE FROM customers1 WHERE id=:id",
            {
                id = {value=arguments.id, cfsqltype="cf_sql_integer"}
            },
            { datasource="myDB" }
        );

        return { success=true, message="Customer Deleted" };
    }

}