/*Write a procedure that will call the procedure given in the parameter.
Check if the value passed in the parameter is indeed the name of the procedure. If not, generate it
"The specified procedure name does not exist" error message.
Attention. To check, use the dictionary all_procedures.*/


DROP PROCEDURE run_procedure;
CREATE OR REPLACE PROCEDURE run_procedure(in_procedure_name VARCHAR2)
IS
TYPE t_objects IS
TABLE OF all_procedures%rowtype INDEX BY PLS_INTEGER;
nt_objects t_objects;
BEGIN
SELECT * BULK COLLECT INTO nt_objects  FROM all_procedures WHERE object_name = in_procedure_name AND object_type = 'PROCEDURE';
IF sql%found = TRUE THEN
    EXECUTE IMMEDIATE 'BEGIN '||in_procedure_name||'; END;';
    DBMS_OUTPUT.PUT_LINE('The procedure run successfuly');
ELSE 
DBMS_OUTPUT.PUT_LINE('The procedure name specified does not exist');
END IF;
END run_procedure;
/
