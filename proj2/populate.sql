DROP TABLE countries CASCADE CONSTRAINTS PRUGE; 
DROP TABLE departments CASCADE CONSTRAINTS PRUGE; 
DROP TABLE employees CASCADE CONSTRAINTS PRUGE;
DROP TABLE job_history CASCADE CONSTRAINTS PRUGE;
DROP TABLE jobs CASCADE CONSTRAINTS PRUGE;  
DROP TABLE locations CASCADE CONSTRAINTS PRUGE;  
DROP TABLE regions CASCADE CONSTRAINTS PRUGE;   


create TABLE countries AS SELECT * FROM GTD10.countries; 
create TABLE departments AS SELECT * FROM GTD10.departments; 
create TABLE employees AS SELECT * FROM GTD10.employees; 
create TABLE job_history AS SELECT * FROM GTD10.job_history; 
create TABLE jobs AS SELECT * FROM GTD10.jobs;
create TABLE locations AS SELECT * FROM GTD10.locations;
create TABLE regions AS SELECT * FROM GTD10.regions;
