/*Napisz program, który sprawdzi czy podana w parametrze liczba jest parzysta czy nie. Wywołaj funkcję na 2 sposoby:
w poleceniu SELECT dla wszystkich id pracownika z tabeli employees
w programie PL/SQL w pętli zwracającej liczby od 1 do 10
*/

CREATE OR REPLACE FUNCTION checker (
    in_number IN NUMBER
) RETURN VARCHAR2 IS
    v_result NUMBER;
    v_stat VARCHAR2(100);
BEGIN
    v_result := MOD(in_number, 2);
    IF v_result = 0 THEN
    v_stat := 'Podana liczba jest parzysta';
      --dbms_output.put_line('Podana liczba: ' || in_number || ' jest liczba parzysta');
    ELSE
    v_stat := 'Podana liczba jest nieparzysta';
      --dbms_output.put_line('Podana liczba: ' || in_number || ' jest liczba nieparzysta');
    END IF;
    RETURN  v_stat;
END checker;
/


 -- Rozwiązanie 1:
SELECT EMPLOYEES.EMPLOYEE_ID, checker (EMPLOYEE_ID) FROM EMPLOYEES;

 -- Rozwiązanie 2:
DECLARE
    v_result VARCHAR2(100);
BEGIN
FOR i IN 1..10
LOOP
    v_result := checker(i);
    dbms_output.put_line(i || '  ' || v_result );
END LOOP;
END;
