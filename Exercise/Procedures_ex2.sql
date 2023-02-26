/*Create a procedure called display_supervisor_employee, which will display the employee's first and 
last name and the first and last name of his supervisor (manager_id). Employee_id should be passed in 
the parameter of the procedure. For example: EXECUTE display_employee_supervisor(101); should return 
"Steven King is the supervisor of employee: Neena Jochhar".*/

set SERVEROUTPUT on;

CREATE OR REPLACE PROCEDURE display_supervisor_employee (in_id_empl IN NUMBER) IS
BEGIN
FOR i IN (SELECT e.FIRST_NAME AS first_name_empl, e.LAST_NAME AS last_name_epml, d.FIRST_NAME AS first_name_super, d.LAST_NAME AS last_name_super   FROM 
EMPLOYEES e LEFT JOIN EMPLOYEES d ON e.MANAGER_ID = d.EMPLOYEE_ID   
WHERE in_id_empl = e.EMPLOYEE_ID)
LOOP
DBMS_OUTPUT.PUT_LINE(i.first_name_super || '  ' || i.last_name_super   || ' jest przełożonym pracownika: ' ||  i.first_name_empl ||  '  ' || i.last_name_epml || '  ');
END LOOP;
END display_supervisor_employee;


EXECUTE display_supervisor_employee(101);