/*Write a function that will return the employee's new salary depending on his current earnings, i.e. if the employee:
earning less than 5,000 is a 20% raise
earning between 5000 and 7000 is a 15% increase
others increase by 10%
Use the function returning the new salary in the update_salary procedure, which will modify the current salary of the employee to the one returned by the function.
Call the procedure update_salary for department 50.

*** Replace the above program with a single UPDATE statement.*/

CREATE OR REPLACE FUNCTION accountant(in_salary IN EMPLOYEES.SALARY%TYPE ) RETURN EMPLOYEES.SALARY%TYPE
IS
v_new_salary EMPLOYEES.SALARY%TYPE;
BEGIN
IF in_salary  < 5000 THEN 
v_new_salary := in_salary*1.2;
ELSIF in_salary  >= 5000 AND in_salary <= 7000 THEN
v_new_salary := in_salary*1.15;
ELSE
v_new_salary := in_salary*1.1;
END IF;
RETURN v_new_salary;
END accountant;
/



CREATE OR REPLACE PROCEDURE aktualizuj_pensję(in_dep_id IN EMPLOYEES.EMPLOYEE_ID%TYPE) 
IS
BEGIN
UPDATE EMPLOYEES SET SALARY = accountant(SALARY)
WHERE DEPARTMENT_ID  = in_dep_id;
END aktualizuj_pensję;
/

BEGIN
aktualizuj_pensję(50);
END;
/


 -- *** 
UPDATE  EMPLOYEES SET SALARY =
CASE
WHEN salary < 5000 THEN
salary*1.2
WHEN salary >= 5000 AND salary <= 7000 THEN
salary*1.15
WHEN salary > 7000 THEN
salary*1.1
END
/
