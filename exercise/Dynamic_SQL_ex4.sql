/*Write a program that removes all procedures, functions, triggers and packages from the user_plsql
schema (the object type should be passed in the parameter).*/


CREATE OR REPLACE PROCEDURE deleting_object_type (in_object_type IN VARCHAR2)
IS
ex_err_numb EXCEPTION  ;
PRAGMA EXCEPTION_INIT(ex_err_numb, -06502);
TYPE t_objects IS TABLE OF all_objects.object_name%type INDEX BY PLS_INTEGER;
nt_objects t_objects;
BEGIN
SELECT object_type|| ' ' ||object_name BULK COLLECT INTO nt_objects  FROM all_objects WHERE object_type = in_object_type 
AND OWNER = 'KURS_PLSQL' AND object_name != ( 'DELETING_OBJECT_TYPE');
FOR i IN nt_objects.FIRST..nt_objects.LAST
LOOP
EXECUTE IMMEDIATE 'DROP ' ||nt_objects(i);
DBMS_OUTPUT.PUT_LINE(nt_objects(i)|| ' dropped');
END LOOP;
EXCEPTION
WHEN ex_err_numb THEN 
DBMS_OUTPUT.PUT_LINE('No '|| in_object_type|| ' to drop');
END deleting_object_type;
/



--Executing
BEGIN
deleting_object_type('PROCEDURE');
END;
/



