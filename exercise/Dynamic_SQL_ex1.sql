/*Write a procedure that will list all uncompiled objects in the user's schema_kurs_plsql. If you do not find any such object, then display the information: "All objects in the course_plsql schema are compiled".
Expand the program to attempt to compile uncompiled objects. If you fail to compile a given object, i.e. it will continue to return an error message, then log information about the error, name and type of the object to a dedicated log table.
ATTENTION. For compilation, use the command ALTER object_type object_name COMPILE or a dedicated package.*/


DROP TABLE log_error;

CREATE TABLE log_error (
    error_id    INTEGER GENERATED ALWAYS AS IDENTITY,
    error_cod   NUMBER,
    err_msg     VARCHAR(100),
    object_type VARCHAR2(100),
    object_name VARCHAR2(100)
);
/

CREATE OR REPLACE PACKAGE compile_checker IS
    FUNCTION results RETURN VARCHAR2;
END compile_checker;
/

CREATE OR REPLACE PACKAGE BODY compile_checker IS

    v_code NUMBER;
    v_errm VARCHAR2(64);

-- Main funtion
    FUNCTION results RETURN VARCHAR2 IS

        v_result   VARCHAR2(60);
        ex_err_comp EXCEPTION;
        PRAGMA exception_init ( ex_err_comp, -24344 );
        TYPE t_objects IS
            TABLE OF user_objects%rowtype INDEX BY PLS_INTEGER;
        nt_objects t_objects;
    BEGIN
        SELECT
            *
        BULK COLLECT
        INTO nt_objects
        FROM
            user_objects
        WHERE
            status = 'INVALID';

        IF SQL%found = true THEN
            FOR i IN nt_objects.first..nt_objects.last LOOP
                BEGIN
                    EXECUTE IMMEDIATE 'ALTER '
                                      || nt_objects(i).object_type
                                      || ' '
                                      || nt_objects(i).object_name
                                      || ' COMPILE';

                EXCEPTION
                    WHEN ex_err_comp THEN
                        v_code := sqlcode;
                        v_errm := substr(sqlerrm, 1, 64);
                        INSERT INTO log_error VALUES ( DEFAULT,
                        v_code,
                        v_errm,
                        nt_objects(i).object_type,
                        nt_objects(i).object_name );

                END;
            END LOOP;

            v_result := 'There are logged error about uncompiled objects';
        ELSE
            v_result := 'All objects are compiled';
        END IF;

        RETURN v_result;

    END results;

BEGIN
    NULL;
EXCEPTION
    WHEN OTHERS THEN
            v_errm := substr(sqlerrm, 1, 64);
            dbms_output.put_line(v_errm);
END compile_checker;
/



--Program execution
DECLARE
    results VARCHAR2(60);
BEGIN
    dbms_output.put_line(compile_checker.results);
END;

