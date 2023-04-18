--liquibase formatted sqlc

--changeset init:0 labels:table2_label context:table2_context
--comment: create table "table2"

CREATE TABLE myschema1.TABLE2 
(
  COLUMN1 VARCHAR2(20) 
);
-- rollback drop table myschema1.table2;

--changeset sna:1 labels:cr123456 context:dev,test,prod
ALTER TABLE myschema1.TABLE2
ADD (COLUMN2 DATE)
/
-- rollback alter table myschema1.TABLE2 drop column column2;
