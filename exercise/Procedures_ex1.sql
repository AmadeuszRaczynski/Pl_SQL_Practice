/*Create a routine with any (sensible) name that will change the country_name to uppercase for all countries from the region id parameter. In the parameter in the OUT mode, return information about the number of modified records. The result of running the procedure should be: "The name of x countries belonging to region_id region has been modified."
Call the program with the named notation for the region with id=4.*/

CREATE OR REPLACE PROCEDURE converter(in_region_id IN COUNTRIES.REGION_ID%TYPE , out_modified_rows  OUT NUMBER)
IS
BEGIN
UPDATE COUNTRIES SET  COUNTRY_NAME = UPPER(COUNTRY_NAME)
WHERE in_region_id = REGION_ID;
out_modified_rows := sql%ROWCOUNT;
END converter;

DECLARE
v_rowcount NUMBER ;
v_region_id COUNTRIES.REGION_ID%TYPE := 4;
BEGIN
converter( v_region_id, v_rowcount);
DBMS_OUTPUT.PUT_LINE('Zmodyfikowano nazwę ' ||  v_rowcount || ' krajów należących do regionu ' || v_region_id);
END;