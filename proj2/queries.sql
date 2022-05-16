-- QUERY B ======================================================================================

-- First approach (wrong one)

select unique(d.department_id) as department_id, value(e).jobs.job_id as jobs, cardinality(value(e).jobs.employees_tab) as num_workers
from departments d, table(d.employees_tab) e; 

-- Second approach (correct one)
select unique(e.department.department_id) as department_id, e.jobs.job_id as jobs, count(employee_id) as employee_cnt
from employees e
group by department, jobs;

-- Third approach (wrong one)
select unique(value(e).department.department_id) as department_id, j.job_id as jobs, cardinality(j.employees_tab) as num_workers
from jobs j, table(j.employees_tab) e;

-- QUERY C =====================================================================================

-- First approach

create view maxSalariesByDepartment as select max(e.salary) as maxSalary,value(d).department_name as departmentName 
from employees e,table(e.manager_of_dep_tab) d 
where value(d).department_name is not null 
group by value(d).department_name;

select employee_id,e.department.department_name, maxSalary
from employees e
inner join maxSalariesByDepartment msbd on e.salary = msbd.maxSalary 
and e.department.department_name = msbd.departmentName;

-- Second approach 

select value(d).department_id as department_id, value(d).department_name as department_name, e.employee_id, e.first_name, e.last_name, max(e.salary) max_salary
from employees e, table(e.manager_of_dep_tab) d
group by e.employee_id, e.first_name, e.last_name, value(d).department_name, value(d).department_id;


-- Corrected approach

select department_id, department_name, get_best_paid_employee(department_id) best_paid_employee,
    value(e).salary salary
from departments d, table(d.employees_tab) e
where value(e).employee_id = get_best_paid_employee(department_id)
order by salary;

-- QUERY D ======================================================================================
 
create view employeesMinEndDate as select distinct(jh.employee.employee_id) as employeeId,min(jh.end_date) as endDate 
from job_history jh 
group by jh.employee.employee_id;
 
create view employeesMaxStartDate as 
select distinct(jh.employee.employee_id) as employeeId,max(jh.start_date) as startDate 
from job_history jh 
group by jh.employee.employee_id; 

select med.employeeId 
from employeesMinEndDate med 
inner join employeesMaxStartDate msd on msd.employeeId = med.employeeId 
where msd.startDate - med.endDate > 1;

drop view employeesMinEndDate;
drop view employeesMaxStartDate;

------------------------------------------------------------------------------

create view employeesWithEndDate as select distinct(jh.employee.employee_id) as employeeId,max(jh.end_date+1) as endDate from job_history jh group by jh.employee.employee_id;   

create view employeesWithoutEndDate as select e.employee_id,e.hire_date from employees e where e.employee_id not in (select employeeId from employeesWithEndDate);

create view employeesJobDuration as select * from employeesWithEndDate union all select * from employeesWithoutEndDate;

select * from employeesJobDuration order by months_between(current_date,endDate) desc;

drop view employeesWithEndDate;

drop view employeesWithoutEndDate;

drop view employeesJobDuration;



-- QUERY E =======================================================================================

select e.department.locations.countries.country_id as country, avg(salary) as avg_salary
from employees e
group by e.department.locations.countries.country_id
order by avg_salary;

-- QUERY F ========================================================================================

select  d.department_id, d.department_name, round(d.ever_worked()/total_employees(), 3) as percentage_employees
from departments d;