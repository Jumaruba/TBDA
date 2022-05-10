
create or replace type regions_t; 
/
create or replace type countries_t; 
/
create or replace type locations_t; 
/
create or replace type employees_t; 
/
create or replace type jobs_t; 
/ 
create or replace type job_history_t; 
/
create or replace type departments_t; 
/
create or replace type departments_employees_t; 
/



create or replace type regions_t as object (
    region_id number,
    region_name varchar2(25)
);
/

create or replace type countries_t as object (
    country_id char(2), 
    region_name varchar2(25),
    region REF regions_t
);
/

create or replace type locations_t as object (
    location_id number(4), 
    street_addreess varchar2(40),
    postal_code varchar2(12),
    city varchar2(30),
    state_province varchar2(25),
    countries REF countries_t
);
/

create or replace type employees_t as object (
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25),
    email VARCHAR2(25),
    phone_number VARCHAR2(20),
    hire_date DATE,
    salary NUMBER(8),
    comission_pct NUMBER(2),
    department REF departments_t,
    jobs REF jobs_t,
    employees REF employees_t
);
/

create or replace type jobs_t as object (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35),
    min_salary NUMBER(6),
    max_salary NUMBER(6)
);
/

create or replace type job_history_t as object (
    star_date DATE,
    end_date DATE,
    department REF departments_t,
    employee REF employees_t,
    jobs REF jobs_t
);
/

create or replace type departments_t as object (
    department_id NUMBER(4),
    department_name VARCHAR2(30),
    locations REF locations_t,
    departments_employees REF  departments_employees_t
);
/


-- Creating nested tables. The "set" ones. 
create or replace type countries_tab_t as table of ref countries_t;
/
create or replace type locations_tab_t as table of ref locations_t; 
/
create or replace type departments_tab_t as table of ref departments_t; 
/
create or replace type job_history_tab_t as table of ref job_history_t; 
/
create or replace type employees_tab_t as table of ref employees_t; 
/

-- Add the nested tables.
alter type regions_t add attribute(countries_tab countries_tab_t) cascade; 
alter type countries_t add attribute(locations_tab locations_tab_t) cascade;
alter type locations_t add attribute(departments_tab departments_tab_t) cascade;
alter type departments_t add attribute(job_history_tab job_history_tab_t) cascade;
alter type jobs_t add attribute(job_history_tab job_history_tab_t, employees_tab employees_tab_t) cascade;
alter type employees_t add attribute(employees_tab employees_tab_t, job_history_tab job_history_tab_t) cascade; 

/
-- many to many auxiliar table 
create or replace type departments_employees_t as object ( 
    departments_tab departments_tab_t,
    employees_tab employees_tab_t
); 

/
-- Creating tables 
create table regions of regions_t
    nested table countries_tab store as r_countries_nt;
/ 

create table countries of countries_t 
    nested table locations_tab store as c_locations_nt; 
/ 

create table locations of locations_t 
    nested table departments_tab store as l_departments_nt; 
/ 

create table departments of departments_t 
    nested table job_history_tab store as d_job_history_nt; 
/ 

create table jobs of jobs_t 
    nested table job_history_tab store as job_history_nt
    nested table employees_tab store as j_employees_nt; 
/ 

create table employees of employees_t 
    nested table employees_tab store as employees_nt 
    nested table job_history_tab store as e_job_history_nt;
/ 

create table departments_employees of departments_employees_t
    nested table departments_tab store as de_departments_nt 
    nested table employees_tab store as de_employees_nt; 
/ 