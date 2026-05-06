component rest="true" restPath="customers" output="false" {

    /* ======================
       GET CUSTOMERS
    ====================== */
    remote function getCustomers()
httpMethod="GET"
restPath=""
produces="application/json"
returntype="query" {

return queryExecute(
"SELECT id,name,email,phone,city
 FROM customers1
 ORDER BY id DESC"
);

}
    /* ======================
       ADD CUSTOMER
    ====================== */
    remote function addCustomer()
httpMethod="POST"
restPath="add"
consumes="application/json"
produces="application/json"
returntype="any" {

    try {

        //  GET RAW DATA
        raw = toString(getHttpRequestData().content);

        // DEBUG (optional)
        // writeDump(raw); abort;

        data = deserializeJSON(raw);

        //  VALIDATION
        if (!structKeyExists(data,"name") OR !structKeyExists(data,"email")) {
            cfcontent(type="application/json");
            return serializeJSON({
                success=false,
                message="Missing fields"
            });
        }

        queryExecute(
        "INSERT INTO customers1(name,email,phone,city)
         VALUES(:name,:email,:phone,:city)",
        {
            name  = {value=data.name,  cfsqltype="cf_sql_varchar"},
            email = {value=data.email, cfsqltype="cf_sql_varchar"},
            phone = {value=data.phone, cfsqltype="cf_sql_varchar"},
            city  = {value=data.city,  cfsqltype="cf_sql_varchar"}
        });

        cfcontent(type="application/json");
        return serializeJSON({
            success=true,
            message="Customer Added Successfully"
        });

    } catch(any e) {

        cfcontent(type="application/json");
        return serializeJSON({
            success=false,
            message=e.message,
            detail=e.detail
        });

    }
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