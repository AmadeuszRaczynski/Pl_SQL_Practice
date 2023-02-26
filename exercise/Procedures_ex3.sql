/*Write a procedure that will list all uncompiled objects in the user's schema_kurs_plsql. If you do not find any such object, then display the information: "All objects in the course_plsql schema are compiled".*/

CREATE OR REPLACE PROCEDURE compile_info IS
TYPE t_objects IS TABLE OF user_objects%ROWTYPE INDEX BY PLS_INTEGER;
nt_objects t_objects;
BEGIN
SELECT * BULK COLLECT INTO nt_objects FROM user_objects
WHERE status = 'INVALID';
IF sql%FOUND = TRUE THEN
FOR i IN nt_objects.FIRST..nt_objects.LAST
LOOP
DBMS_OUTPUT.PUT_LINE (nt_objects(i).object_type || '  ' || nt_objects(i).object_name );
END LOOP;
ELSE
DBMS_OUTPUT.PUT_LINE ('Wszystkie obiekty w schemacie kurs_plsql są skompilowane');
END IF;
END;
