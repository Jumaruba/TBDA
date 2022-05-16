
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

