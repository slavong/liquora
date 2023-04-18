--liquibase formatted sqlc

--changeset sna:2 labels:cr123456 context:dev,test runOnChange:true
--comment: create function "function1"
CREATE OR REPLACE FUNCTION myschema1.function1
RETURN NUMBER
IS
BEGIN
  RETURN 42; -- dummy
END function1;
/
-- rollback drop function function1;