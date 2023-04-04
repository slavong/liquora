--liquibase formatted sqlc

--changeset sna:1 labels:table1_label context:table1_context
--comment: create table "table1"
create table myschema1.table1 (
    id number
)
/
--rollback drop table myschema1.table1;

--changeset sna:2 labels:table1_label context:table1_context
--comment: add PK to table "table1"
alter table myschema1.table1
add constraint pk primary key(id)
/
--rollback alter table myschema1.table1 drop constraint pk;
