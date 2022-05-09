create or replace type coutries_t as object {
    country_id char(2), 
    region_name varchar2(25)
}

create or replace type regions_t as object {
    region_id number,
    region_name: varchar2,
    countries countries_t
}

create or replace type locations_t as object {
    location_id number(4), 
    street_addreess varchar2(40),
    postal_code varchar2(12),
    city varchar2(30),
    state_province(25),
    countries countries_t
}


create or replace type employees_t as object (
    employee_id NUMBER(6),
    first_name VARCHAR2(20),
    last_name VARCHAR2(25),
    email VARCHAR2(25),
    phone_number VARCHAR2(20),
    hire_date DATE,
    job_id VARCHAR2(10),
    salary NUMBER(8)
    comission_pct NUMBER(2),
    manager_id NUMBER(6),
    department_id NUMBER(4)
)

create or replace type jobs_t as object (
    job_id VARCHAR2(10),
    job_title VARCHAR2(35),
    min_salary NUMBER(6),
    max_salary NUMBER(6)
)