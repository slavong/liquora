--liquibase formatted sqlc

--changeset sna:cr111.1 labels:1tab_cols context:deadlock
--comment: create table "table3b"

CREATE TABLE myschema1.TABLE3b
(
  t3b_id number
);
-- rollback drop table myschema1.table3b;

--changeset sna:cr111.2 labels:2tab_uks context:deadlock
ALTER TABLE myschema1.TABLE3b
ADD CONSTRAINT t3b_pk PRIMARY KEY (t3b_id)
/
-- rollback alter table myschema1.TABLE3b drop constraint t3b_pk;