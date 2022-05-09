drop type regions_t;
drop type countries_t;
drop type locations_t;
drop type employees_t;
drop type jobs_t;
drop type job_history_t;
drop type departments_t; 

create or replace type regions_t;
create or replace type countries_t;
create or replace type locations_t;
create or replace type employees_t;
create or replace type jobs_t;
create or replace type job_history_t;
create or replace type departments_t;

create or replace type regions_t as object (
    region_id number,
    region_name varchar2(25)
);

create or replace type countries_t as object (
    country_id char(2), 
    region_name varchar2(25),
    region REF regions_t
);

create or replace type locations_t as object (
    location_id number(4), 
    street_addreess varchar2(40),
    postal_code varchar2(12),
    city varchar2(30),
    state_province varchar2(25),
    countries REF countries_t
);

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
    jobs REF jobs_t
);

create or replace type jobs_t as object (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35),
    min_salary NUMBER(6),
    max_salary NUMBER(6),
    job_history REF job_history_t
);

create or replace type job_history_t as object (
    star_date DATE,
    end_date DATE,
    department REF departments_t,
    employee REF employees_t
);

create or replace type departments_t as object (
    department_id NUMBER(4),
    department_name VARCHAR2(30),
    employee REF employees_t,
    locations REF locations_t
);