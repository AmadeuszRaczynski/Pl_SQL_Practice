/*Write an explicit cursor with a parameter that will return a list of employees from the department name given in the parameter 
(department_name).*/


DECLARE
CURSOR curr_dep(in_DEPARTMENT_NAME VARCHAR2)  IS (SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_NAME 
FROM EMPLOYEES e JOIN DEPARTMENTS d ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE in_DEPARTMENT_NAME = d.DEPARTMENT_NAME);
v_dep curr_dep%ROWTYPE;
BEGIN
OPEN curr_dep('Shipping');
LOOP
FETCH curr_dep INTO v_dep;
EXIT WHEN curr_dep%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(to_char(v_dep.EMPLOYEE_ID) || '  ' || v_dep.DEPARTMENT_NAME || '  ' || v_dep.FIRST_NAME || '  ' || v_dep.LAST_NAME ) ;
END LOOP;
END;
