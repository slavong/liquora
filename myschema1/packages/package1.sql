--liquibase formatted sqlc

--changeset sna:2 labels:cr123456 context:dev,test runOnChange:true
--comment: create package "package1"
CREATE OR REPLACE PACKAGE myschema1.package1
IS
 FUNCTION dummy RETURN NUMBER;
END package1;
/
CREATE OR REPLACE PACKAGE BODY myschema1.package1
IS
 FUNCTION dummy RETURN NUMBER IS
 BEGIN RETURN 42; /*comments*/ END dummy;
END package1;
/
-- rollback drop package package1;