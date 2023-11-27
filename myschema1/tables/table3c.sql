--liquibase formatted sqlc

--changeset sna:cr111.1 labels:1tab_cols context:deadlock
--comment: create table "table3c"

CREATE TABLE myschema1.TABLE3c
(
 t3c_id number
);
-- rollback drop table myschema1.table3c;

--changeset sna:cr111.2 labels:2tab_uks context:deadlock
ALTER TABLE myschema1.TABLE3c
ADD CONSTRAINT t3c_pk PRIMARY KEY (t3c_id)
/
-- rollback alter table myschema1.TABLE3c drop constraint t3c_pk;