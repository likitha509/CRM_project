component rest="true" restPath="customers" output="false" {

    /* ======================
       GET CUSTOMERS
    ====================== */
    remote function getCustomers(
        numeric page=1
    )
    httpMethod="GET"
    restPath=""
    produces="application/json"
    returntype="struct" {

        perPage = 4;
        startRow = (arguments.page-1)*perPage;

        /* Total Records */
        qCount = queryExecute(
        "SELECT COUNT(*) AS total FROM customers1"
        );

        totalRecords = qCount.total;
        totalPages = ceiling(totalRecords/perPage);

        /* Customer Data */
        qCustomers = queryExecute(
        "SELECT id,name,email,phone,city
         FROM customers1
         ORDER BY id DESC
         LIMIT :startRow,:perPage",
        {
        startRow={value=startRow,cfsqltype="cf_sql_integer"},
        perPage={value=perPage,cfsqltype="cf_sql_integer"}
        }
        );

        return {
            customers = qCustomers,
            totalPages = totalPages,
            currentPage = arguments.page
        };
    }


    /* ======================
       ADD CUSTOMER
    ====================== */
    remote function addCustomer()
    httpMethod="POST"
    restPath="add"
    consumes="application/json"
    produces="application/json"
    returntype="struct" {

        data = deserializeJSON(toString(getHttpRequestData().content));

        queryExecute(
        "INSERT INTO customers1(name,email,phone,city)
         VALUES(:name,:email,:phone,:city)",
        {
        name={value=data.name,cfsqltype="cf_sql_varchar"},
        email={value=data.email,cfsqltype="cf_sql_varchar"},
        phone={value=data.phone,cfsqltype="cf_sql_varchar"},
        city={value=data.city,cfsqltype="cf_sql_varchar"}
        });

        return {message="Customer Added"};
    }


    /* ======================
       UPDATE CUSTOMER
    ====================== */
    remote function updateCustomer()
    httpMethod="PUT"
    restPath="update"
    consumes="application/json"
    produces="application/json"
    returntype="struct" {

        data = deserializeJSON(toString(getHttpRequestData().content));

        queryExecute(
        "UPDATE customers1
         SET name=:name,email=:email,phone=:phone,city=:city
         WHERE id=:id",
        {
        id={value=data.id,cfsqltype="cf_sql_integer"},
        name={value=data.name,cfsqltype="cf_sql_varchar"},
        email={value=data.email,cfsqltype="cf_sql_varchar"},
        phone={value=data.phone,cfsqltype="cf_sql_varchar"},
        city={value=data.city,cfsqltype="cf_sql_varchar"}
        });

        return {message="Customer Updated"};
    }


    /* ======================
       DELETE CUSTOMER
    ====================== */
    remote function deleteCustomer(
    required numeric id restArgSource="path"
    )
    httpMethod="DELETE"
    restPath="delete/{id}"
    produces="application/json"
    returntype="struct" {

        queryExecute(
        "DELETE FROM customers1 WHERE id=:id",
        {
        id={value=arguments.id,cfsqltype="cf_sql_integer"}
        });

        return {message="Customer Deleted"};
    }

}