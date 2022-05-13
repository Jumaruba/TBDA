select UNIQUE(d.department_id), value(e).jobs.job_id as jobs, cardinality(value(e).jobs.employees_tab) as num_workers
from departments d, table(d.employees_tab) e; 