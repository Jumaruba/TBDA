DROP TABLE countries CASCADE CONSTRAINTS; 
DROP TABLE departments CASCADE CONSTRAINTS; 
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE job_history CASCADE CONSTRAINTS;
DROP TABLE jobs CASCADE CONSTRAINTS   
DROP TABLE locations CASCADE CONSTRAINTS;  
DROP TABLE regions CASCADE CONSTRAINTS;   


create TABLE countries AS SELECT * FROM GTD10.countries; 
create TABLE departments AS SELECT * FROM GTD10.departments; 
create TABLE employees AS SELECT * FROM GTD10.employees; 
create TABLE job_history AS SELECT * FROM GTD10.job_history; 
create TABLE jobs AS SELECT * FROM GTD10.jobs;
create TABLE locations AS SELECT * FROM GTD10.locations;
create TABLE regions AS SELECT * FROM GTD10.regions;

