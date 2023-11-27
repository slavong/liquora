--liquibase formatted sqlc

--changeset sna:cr111.1 labels:1tab_cols context:deadlock
--comment: create table "table3a"

CREATE TABLE myschema1.TABLE3a
(
  t3a_id number
);
-- rollback drop table myschema1.table3a;

--changeset sna:cr111.2 labels:2tab_uks context:deadlock
ALTER TABLE myschema1.TABLE3a
ADD CONSTRAINT t3a_pk PRIMARY KEY (t3a_id)
/
-- rollback alter table myschema1.TABLE3a drop constraint t3a_pk;

--changeset sna:cr111.3 labels:1tab_cols context:deadlock
--comment: create table "table3a"

ALTER TABLE myschema1.TABLE3a
ADD t3a_t3b_id number
/
-- rollback alter table myschema1.table3a drop column t3a_t3b_id;

--changeset sna:cr111.4 labels:3tab_fks context:deadlock
ALTER TABLE myschema1.TABLE3a
ADD CONSTRAINT t3a_t3b_fk
FOREIGN KEY (t3a_t3b_id)
 REFERENCES myschema1.TABLE3b (t3b_id)
/
-- rollback alter table myschema1.TABLE3a drop constraint t3a_pk;

