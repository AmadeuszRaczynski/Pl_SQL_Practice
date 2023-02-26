/*Write an explicit cursor with a parameter that will return a list of employees from the given parameter
department name(department_name).
Expand the above program with: increasing employees' salaries by 20%
wait for locking records for a maximum of 6 seconds only locking records from the table
employees use where current of*/

DECLARE
CURSOR curr_dep(in_DEPARTMENT_NAME VARCHAR2)  
IS SELECT e.salary, e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME 
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE in_DEPARTMENT_NAME = d.DEPARTMENT_NAME
FOR UPDATE OF e.EMAIL WAIT 6;
v_dep curr_dep%ROWTYPE;
BEGIN
OPEN curr_dep('Shipping');
LOOP
FETCH curr_dep INTO v_dep;
EXIT WHEN curr_dep%NOTFOUND;
UPDATE EMPLOYEES
SET SALARY = salary + salary*0.2
WHERE CURRENT OF curr_dep;
DBMS_OUTPUT.PUT_LINE(to_char(v_dep.EMPLOYEE_ID) || '  ' || v_dep.DEPARTMENT_NAME || '  ' || v_dep.FIRST_NAME || '  ' || v_dep.LAST_NAME || '  ' || v_dep.salary ) ;
END LOOP;
END;

