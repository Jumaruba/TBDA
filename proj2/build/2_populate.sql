insert into regions (region_id, region_name)
select * 
from gtd10.regions; 

insert into countries (country_id, country_name, region)
select c.country_id, c.country_name, ref(r)
from gtd10.countries c
inner join regions r on r.region_id = c.region_id; 

insert into locations (location_id, street_addreess, postal_code, city, countries)
select l.location_id,  street_address, postal_code, city, ref(c)
from gtd10.locations l
inner join countries c on c.country_id = l.country_id ; 

insert into jobs (job_id, job_title, min_salary, max_salary) 
select j.job_id, j.job_title, j.min_salary, j.max_salary 
from gtd10.jobs j; 


insert into employees (employee_id, first_name, last_name, email, 
    phone_number, hire_date, salary, commission_pct, jobs)
select e.employee_id, e.first_name, e.last_name, e.email, 
    e.phone_number, e.hire_date, e.salary, e.commission_pct, ref(j)
from gtd10.employees e
inner join jobs j  on j.job_id = e.job_id; 

insert into departments (department_id, department_name, manager, locations)
select d.department_id, d.department_name, ref(e), ref(l) 
from gtd10.departments d 
inner join employees e on e.employee_id = d.manager_id
inner join locations l on l.location_id = d.location_id; 

update employees e 
set e.department = (
    select ref(d)
    from departments d
    inner join gtd10.employees ge on ge.department_id = d.department_id
    where ge.employee_id = e.employee_id 
);

insert into job_history (start_date, end_date, department, employee, jobs) 
select jh.start_date, jh.end_date, ref(d), ref(e), ref(j)  
from gtd10.job_history jh 
inner join departments d on d.department_id = jh.department_id
inner join employees e on e.employee_id = jh.employee_id 
inner join jobs j on j.job_id = jh.job_id; 


-- Add nested tables 
update regions r 
set r.countries_tab = cast(multiset(
    select ref(c)
    from countries c 
    where c.region.region_id = r.region_id
) as countries_tab_t); 


update countries c 
set c.locations_tab = cast(multiset(
    select ref(l)
    from locations l 
    where l.countries.country_id = c.country_id
) as locations_tab_t); 


update locations l 
set l.departments_tab = cast(multiset(
    select ref(d) 
    from departments d 
    where d.locations.location_id = l.location_id
) as departments_tab_t);  


update jobs j
set j.job_history_tab = 
    cast(multiset(
        select ref(jh) 
        from job_history jh
        where jh.jobs.job_id = j.job_id
    ) as job_history_tab_t),
j.employees_tab = cast(multiset(
        select ref(e)
        from employees e
        where e.jobs.job_id = j.job_id
    ) as employees_tab_t);


update departments d
set d.job_history_tab =
    cast(multiset(
        select ref(jh)
        from job_history jh
        where jh.department.department_id = d.department_id
    ) as job_history_tab_t),
d.employees_tab =
    cast(multiset(
        select ref(emp)
        from employees emp
        where emp.department.department_id = d.department_id
    ) as employees_tab_t);

update employees e
set e.job_history_tab =
    cast(multiset(
        select ref(jh)
        from job_history jh
        where jh.employee.employee_id = e.employee_id 
    ) as job_history_tab_t),
e.responsible_of_emp_tab =
    cast(multiset(
        select ref(emp)
        from employees emp
        where emp.employee_id = e.manager.employee_id
    ) as employees_tab_t),
e.manager_of_dep_tab = 
    cast(multiset(
        select ref(d)
        from departments d
        where d.manager.employee_id = e.employee_id
    ) as departments_tab_t);

