/*Create an overloaded get_high_dept_salary function in the package that returns the highest salary in the department id parameter. The second function is to additionally contain another parameter job_id, so that it returns the highest salary in a given department for a given position.
Then call the function in any way so that the first time the function is used with 1 parameter, the second time with two.*/

CREATE OR REPLACE PACKAGE pak_1 
IS
FUNCTION get_high_dept_salary(in_dep_id IN EMPLOYEES.DEPARTMENT_ID%TYPE) RETURN EMPLOYEES.SALARY%TYPE;
FUNCTION get_high_dept_salary(in_dep_id IN EMPLOYEES.DEPARTMENT_ID%TYPE, in_job_id IN EMPLOYEES.JOB_ID%TYPE ) RETURN EMPLOYEES.SALARY%TYPE;
END pak_1 ;
/

CREATE OR REPLACE PACKAGE BODY pak_1 
IS 
FUNCTION get_high_dept_salary(in_dep_id IN EMPLOYEES.DEPARTMENT_ID%TYPE) RETURN EMPLOYEES.SALARY%TYPE
IS 
v_zmienna EMPLOYEES.SALARY%TYPE;
BEGIN
SELECT  max(EMPLOYEES.SALARY) INTO v_zmienna FROM EMPLOYEES WHERE in_dep_id = EMPLOYEES.DEPARTMENT_ID;
RETURN v_zmienna;
END;
FUNCTION get_high_dept_salary(in_dep_id IN EMPLOYEES.DEPARTMENT_ID%TYPE, in_job_id IN EMPLOYEES.JOB_ID%TYPE) RETURN EMPLOYEES.SALARY%TYPE
IS 
v_zmienna EMPLOYEES.SALARY%TYPE;
BEGIN
SELECT  max(EMPLOYEES.SALARY) INTO v_zmienna FROM EMPLOYEES WHERE in_dep_id = EMPLOYEES.DEPARTMENT_ID AND in_job_id = EMPLOYEES.JOB_ID ;
RETURN v_zmienna;
END;
END pak_1 ;
/
