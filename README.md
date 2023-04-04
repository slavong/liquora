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

- added script for [table `table1`](myschema/tables/table1.sql)
- only changeset 1 exists at the moment
- grant permissions to user `LB_DEV`
```sql
GRANT CREATE ANY TABLE to lb_dev;
```
- run `liquibase update`
- table `TABLE1` is created in schema `MYSCHEMA1`

## Alter Table
- add changeset2 to [table `table1`](myschema/tables/table1.sql)
- grant permissions to user `LB_DEV`
```sql
GRANT ALTER ANY TABLE to lb_dev;
GRANT CREATE ANY INDEX to lb_dev;
```
- run `liquibase update`
- table `TABLE1` is modified
