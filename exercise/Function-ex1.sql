/*Write a function that should return BMI and take height and weight as parameters. Display the appropriate message on the console depending on the result: <16 "you need to eat more" >=16 and <25 "you need to eat more" >=25 "do some push-ups".*/

CREATE OR REPLACE FUNCTION bmi_counter(v_growth IN NUMBER , v_weight IN NUMBER) RETURN NUMBER
IS
    v_bmi       NUMBER;
    v_comm VARCHAR2(30);
    ex_too_big EXCEPTION;
    PRAGMA EXCEPTION_INIT(ex_too_big, -2000);
BEGIN
    IF v_growth > 225 THEN RAISE ex_too_big ;
    END IF;
    v_bmi := round(v_weight /(power((v_growth * 0.01), 2)), 2);
    IF v_bmi < 16 THEN
        v_comm := 'you need to eat more';
    ELSIF
        v_bmi >= 16
        AND v_bmi < 25
    THEN
        v_comm := 'you need to eat more';
    ELSIF v_bmi >= 25 THEN
        v_comm := 'o some push-ups';
    END IF;
    dbms_output.put_line(v_comm);
    RETURN v_bmi;
    EXCEPTION 
    WHEN ex_too_big THEN 
    DBMS_OUTPUT.PUT_LINE('Podany wzrost jest nienaturalnie duży. Upewnij sie i podaj poprawny wzrost');
END bmi_counter;
/

-- Program call
DECLARE
v_bmi NUMBER;
BEGIN
v_bmi := bmi_counter(180,80);
DBMS_OUTPUT.PUT_LINE(v_bmi);
END;