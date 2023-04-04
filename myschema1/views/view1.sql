--liquibase formatted sqlc

--changeset sna:2 labels:cr123999 context:dev,test runOnChange:true
--comment: create table "table1"
CREATE OR REPLACE VIEW myschema1.VIEW1
AS
SELECT id, 'dummy1' AS dummy1
FROM myschema1.table1
/
--rollback drop view myschema1.VIEW1;
