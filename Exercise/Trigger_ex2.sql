/*Create a complex trigger to validate an employee's salary (80%-120% of the department's average) only when there are more than 5 people working in that employee's department. Otherwise, the range of 80%-120% calculate based on the earnings of the entire company.
Attention. When no employee is employed in the company, the trigger should not perform any validation.*/

DROP TRIGGER zlozony_wyzwalacz;
CREATE OR REPLACE TRIGGER zlozony_wyzwalacz
FOR INSERT OR UPDATE OF SALARY ON employees
COMPOUND TRIGGER
    TYPE rec_emp IS RECORD (department_id departments.department_id%TYPE, numb_of_empl NUMBER
                          , department_name departments.department_name%TYPE
                          , avg_salary employees.salary%TYPE);
    TYPE at_emp IS TABLE OF rec_emp INDEX BY PLS_INTEGER;
    v_emp at_emp;
    v_avg_sal NUMBER ;
    BEFORE STATEMENT
    IS
    BEGIN
        SELECT  d.department_id, COUNT(e.EMPLOYEE_ID) AS NUMBER_OF_EMPL, d.department_name, round(avg(e.salary),2) avg_salary
          BULK COLLECT INTO v_emp
          FROM employees e 
    INNER JOIN departments d
            ON d.department_id = e.department_id
         GROUP BY d.department_id, d.department_name;
      
    SELECT ROUND(AVG(EMPLOYEES.SALARY),2) INTO v_avg_sal  FROM EMPLOYEES;
    
    END BEFORE STATEMENT;
    
    BEFORE EACH ROW
    IS
    BEGIN
        FOR i IN v_emp.FIRST..v_emp.LAST
        LOOP
            IF :NEW.department_ID = v_emp(i).department_id AND :NEW.salary NOT BETWEEN v_emp(i).avg_salary * 0.8 AND v_emp(i).avg_salary * 1.2
                AND v_emp(i).numb_of_empl >5
            THEN
                RAISE_APPLICATION_ERROR(-20001, ' Średnia pensja w departamencie '||v_emp(i).department_name||' wynosi '||v_emp(i).avg_salary
                ||'. Nowa pensja pracownika '||:NEW.employee_ID||'('||:NEW.salary||') przekracza dopuszczalne 20% odchylenie od średniej.');
           ELSIF     :NEW.department_ID = v_emp(i).department_id AND :NEW.salary NOT BETWEEN v_avg_sal * 0.8 AND v_avg_sal * 1.2
                AND v_emp(i).numb_of_empl <= 5  AND v_emp(i).numb_of_empl > 0      
           THEN
           RAISE_APPLICATION_ERROR(-20001, ' Średnia pensja w firmie wynosi '|| v_avg_sal
                ||'. Nowa pensja pracownika '||:NEW.employee_ID||'('||:NEW.salary||') przekracza dopuszczalne 20% odchylenie od średniej.');
            
            END IF;
        END LOOP;
    END BEFORE EACH ROW;
END zlozony_wyzwalacz;
/
