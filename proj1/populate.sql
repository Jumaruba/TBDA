-- DROP all tables 
DROP TABLE xdocentes CASCADE CONSTRAINTS PRUGE; 
DROP TABLE xdsd CASCADE CONSTRAINTS PRUGE; 
DROP TABLE xocorrencias CASCADE CONSTRAINTS PRUGE;
DROP TABLE xtiposaula CASCADE CONSTRAINTS PRUGE;
DROP TABLE xucs CASCADE CONSTRAINTS PRUGE; 

DROP TABLE ydocentes CASCADE CONSTRAINTS PRUGE; 
DROP TABLE ydsd CASCADE CONSTRAINTS PRUGE; 
DROP TABLE yocorrencias CASCADE CONSTRAINTS PRUGE;
DROP TABLE ytiposaula CASCADE CONSTRAINTS PRUGE;
DROP TABLE yucs CASCADE CONSTRAINTS PRUGE; 

DROP TABLE zdocentes CASCADE CONSTRAINTS PRUGE; 
DROP TABLE zdsd CASCADE CONSTRAINTS PRUGE; 
DROP TABLE zocorrencias CASCADE CONSTRAINTS PRUGE;
DROP TABLE ztiposaula CASCADE CONSTRAINTS PRUGE;
DROP TABLE zucs CASCADE CONSTRAINTS PRUGE; 

-- Create tables 

create TABLE xdocentes AS SELECT * FROM GTD10.xdocentes; 
create TABLE xdsd AS SELECT * FROM GTD10.xdsd; 
create TABLE xocorrencias AS SELECT * FROM GTD10.xocorrencias; 
create TABLE xtiposaula AS SELECT * FROM GTD10.xtiposaula; 
create TABLE xucs AS SELECT * FROM GTD10.xucs;


create TABLE ydocentes AS SELECT * FROM GTD10.xdocentes; 
create TABLE ydsd AS SELECT * FROM GTD10.xdsd; 
create TABLE yocorrencias AS SELECT * FROM GTD10.xocorrencias; 
create TABLE ytiposaula AS SELECT * FROM GTD10.xtiposaula; 
create TABLE yucs AS SELECT * FROM GTD10.xucs; 


create TABLE zdocentes AS SELECT * FROM GTD10.xdocentes; 
create TABLE zdsd AS SELECT * FROM GTD10.xdsd; 
create TABLE zocorrencias AS SELECT * FROM GTD10.xocorrencias; 
create TABLE ztiposaula AS SELECT * FROM GTD10.xtiposaula; 
create TABLE zucs AS SELECT * FROM GTD10.xucs; 


-- Add primary keys
alter TABLE ydocentes ADD CONSTRAINT ydocentes_pk PRIMARY KEY (nr); 
alter TABLE ydsd ADD CONSTRAINT ydsd_pk PRIMARY KEY (nr, id); 
alter TABLE ytiposaula ADD CONSTRAINT ytiposaula_pk PRIMARY KEY (id); 
alter TABLE yocorrencias ADD CONSTRAINT yocorrencias_pk PRIMARY KEY (codigo, ano_letivo, periodo);
alter TABLE yucs ADD CONSTRAINT yucs_pk PRIMARY KEY(codigo); 

alter TABLE zdocentes ADD CONSTRAINT zdocentes_pk PRIMARY KEY (nr); 
alter TABLE zdsd ADD CONSTRAINT zdsd_pk PRIMARY KEY (nr, id); 
alter TABLE ztiposaula ADD CONSTRAINT ztiposaula_pk PRIMARY KEY (id); 
alter TABLE zocorrencias ADD CONSTRAINT zocorrencias_pk PRIMARY KEY (codigo, ano_letivo, periodo);
alter TABLE zucs ADD CONSTRAINT zucs_pk PRIMARY KEY(codigo); 

-- Add foreign keys 
alter TABLE ydsd ADD FOREIGN KEY (nr) REFERENCES ydocentes(nr); 
alter TABLE ydsd ADD FOREIGN KEY (id) REFERENCES ytiposaula(id); 
alter TABLE ytiposaula ADD FOREIGN KEY (ano_letivo, periodo, codigo) 
REFERENCES yocorrencias(ano_letivo, periodo, codigo); 
alter TABLE yocorrencias ADD FOREIGN KEY (codigo) REFERENCES yucs(codigo);

alter TABLE zdsd ADD FOREIGN KEY (nr) REFERENCES zdocentes(nr); 
alter TABLE zdsd ADD FOREIGN KEY (id) REFERENCES ztiposaula(id); 
alter TABLE ztiposaula ADD FOREIGN KEY (ano_letivo, periodo, codigo) 
REFERENCES zocorrencias(ano_letivo, periodo, codigo); 
alter TABLE zocorrencias ADD FOREIGN KEY (codigo) REFERENCES zucs(codigo);


-- Create indexes 
