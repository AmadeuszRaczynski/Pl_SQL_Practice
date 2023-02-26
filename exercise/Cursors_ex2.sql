/*Check with %rowcount if there are departments in the database whose managers earn less than 8000.*/

DECLARE
v_rowcount NUMBER;
CURSOR cur_empl IS (SELECT e.EMPLOYEE_ID, e.DEPARTMENT_ID, e.SALARY, j.JOB_ID, j.JOB_TITLE FROM EMPLOYEES e JOIN JOBS j ON j.JOB_ID = e.JOB_ID  WHERE SALARY < 8000 AND e.JOB_ID LIKE '%MAN%');
BEGIN
FOR i IN cur_empl
LOOP
DBMS_OUTPUT.PUT_LINE(to_char(cur_empl%ROWCOUNT) || '  ' || '  ' || i.EMPLOYEE_ID || '  ' || i.DEPARTMENT_ID || '  ' ||  i.SALARY || '  ' ||  i.JOB_TITLE );
END LOOP;
END;
