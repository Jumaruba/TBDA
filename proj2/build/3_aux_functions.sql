
-- EVER_WORKED ======================================================================
-- Get's the total number of employees that has ever worked in the enterprise. 

alter type departments_t add member function ever_worked return number cascade;

create or replace type body departments_t as
   
    member function ever_worked return number is 
    num_ever_worked number; 
    begin 
    
        select count(e.employee_id) into num_ever_worked
        from employees e
        where employee_id in (
        select value(et).employee_id 
        from departments d, table(d.employees_tab) et
        where d.department_id = self.department_id
    ) 
    or e.employee_id in (
        select value(jh).employee.employee_id
        from departments d, table(d.job_history_tab) jh
        where d.department_id = self.department_id
    );
        return num_ever_worked;
    end ever_worked; 
    
end; 
/


-- TOTAL_EMPLOYEES =====================================================================
-- Get's the total number of employees in the enterprise. 
create or replace function total_employees return number is
    num_employees number; 

begin 
    select count(employee_id) into num_employees
    from employees; 
    
    return num_employees;
end total_employees; 
/ 


-- GET_BEST_PAID_EMPLOYEE ===============================================================
-- Get's the best paid employee in a department. 

create or replace function get_best_paid_employee(dep_id number) return number is 
    emp_id number;
begin 
    select value(e).employee_id into emp_id
    from employees e 
    where e.salary in (
        select max(value(e).salary) 
        from departments d, table(d.employees_tab) e
        where d.department_id = dep_id
    ) and e.department.department_id = dep_id; 
    return emp_id;
end; 


-- EMPLOYEES WITH END DATE : member functions. 
create or replace function get_history_end_date(employee_id number) return date is 
    end_date date; 
begin 
    select max(jh.end_date+1) as endDate into end_date 
    from job_history jh 
    where jh.employee.employee_id = employee_id;
    
    return end_date; 
end get_history_end_date; 

-- GET EMPLOYEES MIN END DATE ===============================================================
create or replace function get_min_history_end_date(employee_id number) return date is 
    end_date date; 
begin
    select min(jh.end_date) as endDate into end_date
    from job_history jh 
    where jh.employee.employee_id = employee_id; 

    return end_date;
end get_min_history_end_date; 


-- GET EMPLOYEES MAX START DATE =============================================================
create or replace function get_max_history_start_date(employee_id number) return date is 
    start_date date;
begin 
    select max(jh.start_date) into start_date
    from job_history jh 
    where jh.employee.employee_id = employee_id; 
    
    return start_date; 
end get_max_history_start_date;

-- GET EMPLOYEES WITH END DATE ===============================================================
alter type employees_t add member function job_start_date return date cascade; 

create or replace type body employees_t as 
    member function job_start_date return date is 
        start_date date; end_date date; 
    begin 
        select max(value(jh).end_date+1) into end_date
        from table(self.job_history_tab) jh; 

        if end_date != null then 
            return end_date; 
        else 
            return self.hire_date;
        end if;  
    end job_start_date;
end;  
       