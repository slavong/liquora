# Use Git and Liquibase for Continuous Deployment to Oracle Database

## Initial Setup

Requirements:
- Oracle Database, see URLs [liquibase.properties](./liquibase.properties) e.g. `jdbc:oracle:thin:@localhost:1521/localdb`, with SYSDBA access

- create users LB_DEV and LB_TEST for development and test deployments, resp.
    ```sql
    -- as SYSDBA
    CREATE USER lb_dev IDENTIFIED BY "liquibase";
    GRANT CREATE SESSION, RESOURCE TO lb_dev;
    ALTER USER lb_dev QUOTA UNLIMITED ON users;
    ```
- and repeat for user `lb_test`
    ```sql
    -- as SYSDBA
    CREATE USER lb_test IDENTIFIED BY "liquibase";
    GRANT CREATE SESSION, RESOURCE TO lb_test;
    ALTER USER lb_test QUOTA UNLIMITED ON users;
    ```
- create schema `myschema1`
    ```sql
    -- as SYSDBA
    CREATE USER myschema1 IDENTIFIED BY "top!secret";
    GRANT CREATE SESSION, RESOURCE TO myschema1;
    ALTER USER myschema1 QUOTA UNLIMITED ON users;
    ```
- run `liquibase update`
- tables `DATABASECHANGELOG` and `DATABASECHANGELOGLOCK` are created in schema `LB_DEV`
- no changes in schema `myschema1` as there is only empty SQL script in tables folder

## Create Table

- added script for [table `table1`](myschema1/tables/table1.sql)
- only changeset 1 exists at the moment
- grant permissions to user `LB_DEV`
    ```sql
    GRANT CREATE ANY TABLE to lb_dev;
    ```
- run `liquibase update`
- table `TABLE1` is created in schema `MYSCHEMA1`

## Alter Table

- add changeset2 to [table `table1`](myschema1/tables/table1.sql)
- grant permissions to user `LB_DEV`
    ```sql
    GRANT ALTER ANY TABLE to lb_dev;
    GRANT CREATE ANY INDEX to lb_dev;
    ```
- run `liquibase update`
- table `TABLE1` is modified

## Create View

- create script for [view `view1`](myschema1/views/view1.sql)
- grant permissions to user `LB_DEV`
    ```sql
    GRANT CREATE ANY VIEW to lb_dev;
    ```
- run `liquibase update`
- view `VIEW1` is created

## Modify View

- change script for [view `view1`](myschema1/views/view1.sql) either increasing id or not
- run `liquibase update`
- view `VIEW1` is modified, runOnChange works as expected

## Add Existing Table

- create table `TABLE2` directly in schema `myschema1`
- liquibase does not know about the new table, running `liquibase update` does not check for additional objects
- but we want to include it in our repo
- add `CREATE TABLE` script for [table `table2`](myschema1/tables/table2.sql) into changeset `init:0`
- running `liquibase update` fails with `ORA-00955: name is already used by an existing object`, because it tries to recreate the table, that already exists
- run `liquibase markNextChangeSetRan`
- the next run of `liquibase update` succeeds
- and we can continue now as with table that was created using liquibase, see changeset `sna:1`

## Packages, Procedures and Functions

- liquibase user needs CREATE ANY PROCEDURE privilege for creating any packages, functions and procedures in other schemas
```sql
GRANT CREATE ANY procedure TO lb_dev;
```
- adding new or existing packages/procedures/functions works the same way as for views
