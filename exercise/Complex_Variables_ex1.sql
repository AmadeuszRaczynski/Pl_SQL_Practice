/*Using the %ROWTYPE anchor, load the entire departments table into the collection:
 - associative
 - nested
 - varray
Use a FOR loop to display the department name and manager_id on the console.*/
 
 
 SET SERVEROUTPUT ON;

--associative
DECLARE
    TYPE departments2 IS
        TABLE OF departments%rowtype INDEX BY PLS_INTEGER;
     type_at departments2 ;
BEGIN
    SELECT
        *
    BULK COLLECT
    INTO  type_at
    FROM
        departments;
    FOR i IN  type_at.first.. type_at.last LOOP
        dbms_output.put_line( type_at(i).department_name || '  ' ||  type_at(i).manager_id);
    END LOOP;
END;

--nested
DECLARE
    TYPE departments2 IS
        TABLE OF departments%rowtype;
     type_nt departments2 ;
BEGIN
    SELECT
        *
    BULK COLLECT
    INTO  type_nt
    FROM
        departments;
    FOR i IN  type_nt.first.. type_nt.last LOOP
        dbms_output.put_line( type_nt(i).department_name || '  ' ||  type_nt(i).manager_id);
    END LOOP;
END;

-- varray
DECLARE
    TYPE departments2 IS
        VARRAY(100) OF departments%rowtype;
     type_vr departments2 ;
BEGIN
    SELECT
        *
    BULK COLLECT
    INTO  type_vr
    FROM
        departments;
    FOR i IN  type_vr.first.. type_vr.last LOOP
        dbms_output.put_line( type_vr(i).department_name || '  ' ||  type_vr(i).manager_id);
    END LOOP;
END;
