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

-- Missing the employees reference
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

insert into job_history (start_date, end_date, department, employee, jobs) 
select jh.start_date, jh.end_date, ref(d), ref(e), ref(j)  
from gtd10.job_history jh 
inner join departments d on d.department_id = jh.department_id
inner join employees e on e.employee_id = jh.employee_id 
inner join jobs j on j.job_id = jh.job_id; 