--liquibase formatted sqlc

--changeset sna:2 labels:cr123456 context:dev,test runOnChange:true
--comment: create function "function1"
CREATE OR REPLACE PROCEDURE myschema1.procedure1
IS
BEGIN
  NULL;
  RETURN;
END procedure1;
/
-- rollback drop procedure procedure1;