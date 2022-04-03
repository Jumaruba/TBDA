-- Drop all tables 
drop table xdocentes cascade constraints purge; 
drop table xdsd cascade constraints purge; 
drop table xocorrencias cascade constraints purge;
drop table xtiposaula cascade constraints purge;
drop table xucs cascade constraints purge; 

drop table ydocentes cascade constraints purge; 
drop table ydsd cascade constraints purge; 
drop table yocorrencias cascade constraints purge;
drop table ytiposaula cascade constraints purge;
drop table yucs cascade constraints purge; 

drop table zdocentes cascade constraints purge; 
drop table zdsd cascade constraints purge; 
drop table zocorrencias cascade constraints purge;
drop table ztiposaula cascade constraints purge;
drop table zucs cascade constraints purge; 

-- Create tables 

create table xdocentes as select * from GTD10.xdocentes; 
create table xdsd as select * from GTD10.xdsd; 
create table xocorrencias as select * from GTD10.xocorrencias; 
create table xtiposaula as select * from GTD10.xtiposaula; 
create table xucs as select * from GTD10.xucs;


create table ydocentes as select * from GTD10.xdocentes; 
create table ydsd as select * from GTD10.xdsd; 
create table yocorrencias as select * from GTD10.xocorrencias; 
create table ytiposaula as select * from GTD10.xtiposaula; 
create table yucs as select * from GTD10.xucs; 


create table zdocentes as select * from GTD10.xdocentes; 
create table zdsd as select * from GTD10.xdsd; 
create table zocorrencias as select * from GTD10.xocorrencias; 
create table ztiposaula as select * from GTD10.xtiposaula; 
create table zucs as select * from GTD10.xucs; 


-- Add primary keys
alter table ydocentes add constraint ydocentes_pk primary key (nr); 
alter table ydsd add constraint ydsd_pk primary key (nr, id); 
alter table ytiposaula add constraint ytiposaula_pk primary key (id); 
alter table yocorrencias add constraint yocorrencias_pk primary key (codigo, ano_letivo, periodo);
alter table yucs add constraint yucs_pk primary key(codigo); 

alter table zdocentes add constraint zdocentes_pk primary key (nr); 
alter table zdsd add constraint zdsd_pk primary key (nr, id); 
alter table ztiposaula add constraint ztiposaula_pk primary key (id); 
alter table zocorrencias add constraint zocorrencias_pk primary key (codigo, ano_letivo, periodo);
alter table zucs add constraint zucs_pk primary key(codigo); 

-- Add foreign keys 
alter table ydsd add foreign key (nr) references ydocentes(nr); 
alter table ydsd add foreign key (id) references ytiposaula(id); 
alter table ytiposaula add foreign key (ano_letivo, periodo, codigo) 
references yocorrencias(ano_letivo, periodo, codigo); 
alter table yocorrencias add foreign key (codigo) references yucs(codigo);

alter table zdsd add foreign key (nr) references zdocentes(nr); 
alter table zdsd add foreign key (id) references ztiposaula(id); 
alter table ztiposaula add foreign key (ano_letivo, periodo, codigo) 
references zocorrencias(ano_letivo, periodo, codigo); 
alter table zocorrencias add foreign key (codigo) references zucs(codigo);


-- Create indexes 
