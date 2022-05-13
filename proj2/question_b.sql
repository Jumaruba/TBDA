select UNIQUE(d.department_id), value(e).jobs.job_id as jobs, cardinality(value(e).jobs.employees_tab) as num_workers
from departments d, table(d.employees_tab) e; 

-- Perhaps the tab employees_tab from jobs could be deleted. 
-- Because we can relate the department with the job by connecting with the employee. 

-- There's a certain cost of calculating this query by linking the departments with the jobs (?)

-- Here we join the departments and jobs by the employee. The difference is that the employees that doens't have an department 
-- are shown. While in the first query they are not. 
select UNIQUE(e.department.department_id) as department, e.jobs.job_id as jobs, count(employee_id) as employee_cnt
from employees e
group by department, jobs;
