/*Create an explicit cursor that will display all records from the REGIONS table in a WHILE loop.*/

DECLARE
CURSOR curr_reg IS SELECT * FROM regions;
v_variable curr_reg%ROWTYPE;
v_found BOOLEAN := TRUE ;
BEGIN
OPEN curr_reg;
WHILE v_found 
LOOP
FETCH curr_reg INTO v_variable;
v_found := curr_reg%FOUND;
IF v_found = TRUE THEN
DBMS_OUTPUT.PUT_LINE(v_variable.REGION_ID || '  ' || v_variable.REGION_NAME) ;
END IF;
v_found := curr_reg%FOUND;
END LOOP;
CLOSE curr_reg;
END;
