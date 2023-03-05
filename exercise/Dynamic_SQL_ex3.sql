/*Write an anonymous block that will create a subsidiaries_company table with any set of columns you 
choose. The block should allow you to run it multiple times without returning an error that the table
already exists.*/

DECLARE
v_table_name VARCHAR2(20);
v_columns VARCHAR2(200);
TYPE t_objects IS
TABLE OF all_tables%rowtype INDEX BY PLS_INTEGER;
nt_objects t_objects;
BEGIN
v_table_name := 'COMPANY_AFFILIATES';
v_columns := '(id INTEGER, name_a number, b number, x NUMBER) ';

SELECT * BULK COLLECT INTO nt_objects  FROM  all_tables WHERE table_name = v_table_name AND OWNER = 'KURS_PLSQL';
IF SQL%FOUND = TRUE THEN

EXECUTE IMMEDIATE 'DROP  TABLE '|| v_table_name ;
DBMS_OUTPUT.PUT_LINE('1');
EXECUTE IMMEDIATE 'CREATE TABLE '|| v_table_name|| v_columns  ;
ELSE
DBMS_OUTPUT.PUT_LINE('2');
EXECUTE IMMEDIATE 'CREATE TABLE '|| v_table_name|| v_columns  ;
END IF;
END;
/
