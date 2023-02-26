# ORACLE PRACTICE FROM ZERO TO HERO


## Table of Contents 
1. About
2. Tools
3. Prerequisites
4. Tasks and answers


#### About

In my repository I would like to present the progress of my development in the field of databases. I will particularly focus on the Oracle implementation using the PL/SQL programming language. The tasks will be performed on the "PL_SQL_Practice" user schema which you download from my github.

Programs and projects will be divided into the following modules:

1. MODULE: COMPOUND VARIABLES
2. MODULE: CURSORS
3. MODULE: PROCEDURES
4. MODULE: FUNCTIONS
5. MODULE: PL/SQL PACKAGE
6. MODULE: TRIGGERS
7. MODULE: JOB SCHEDULER (not added yet)
8. MODULE: DYNAMIC SQL (not added yet)


#### Tools 

* `PL/SQL`
* `SQL`
* `Data Modeler 21.2.0.183`
* `SQL Developer Version 22.2.1.234`
* `Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production`

#### Prerequisites

1. Installing SQL Developer on Windows
2. Installing Oracle Database 21c on Windows 10/11 
3. Download Source Files
5. Create New User using "PL_SQL_Practice" schema




## Installing SQL Developer on Windows

 Here is good tutorial for install SQL DEVELOPER on Windows 10 x64 bit [here](https://www.youtube.com/watch?v=zliF8kXVmeE) but if You would have a problem [here](https://docs.oracle.com/en/database/oracle/sql-developer/22.2/rptug/sql-developer-concepts-usage.html#GUID-156BEBA3-2F9B-4CE0-8E91-728581FF46AB) is documentation on this subject. 

## Installing Oracle Database 21c on Windows 10/11 

After installing SQL Developer, you need to install the Oracle database. In our case, it will be the latest version of Oracle Database 21C. Here is a good tutorial to do it.  [here](https://www.youtube.com/watch?v=-h2NJmake20). 

## Download Source Files

To create new User: PL_SQL_Practice you need to download it from [here]


## Create New User using "PL_SQL_Practice" schema

Next step is to open SQL Developer and do the following steps:
1. To create new user use the code below: 

![FirstImage](https://user-images.githubusercontent.com/125867556/221382674-ed3d9b75-4de6-4b6f-8dc6-c08e6d7bc5f6.png)

2. Next step is  adding New Connection and fill the necessary information:
UserName: PL/SQL/Pratice
Password: password123
*Important to be connected to container XEPDB1

![SecontImage](https://user-images.githubusercontent.com/125867556/221382841-9e3a4f9c-28ae-4db2-a02d-3cad1876be87.JPG)

3. Last step is to copy attached sript: "PL/SQL_Practice", paste it in Worksheet of your created user and Run this sript. 

![ThirdImage](https://user-images.githubusercontent.com/125867556/221383093-7a27805c-88a4-4803-ae66-4923a7be2c2c.JPG)

4. After it you will have ready environment to get my attached scripts and test it.

![FiveImaage](https://user-images.githubusercontent.com/125867556/221383230-ddcdbd53-fe32-4bd5-b54a-00c08ebdbce8.JPG)


#### TASKS AND ANSWERS

*TASKS AND ANSERWS OF EACH MODULES ARE ATTACHED INTO SEPARATELY FILES.

To present how it works I will show simple exemplary task:

1. Write a function that should return BMI and take height and weight as parameters. Display the appropriate message on the console depending on the result:
<16 "you need to eat more" >=16 and <25 "you need to eat more" >=25 "do some push-ups".

2. Solution: 

```sql
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

```


## Contact

If You have any problem please contact me. Any advices or guidance are welcome.

Amadeusz RACZYŃKI

LinkedIn: www.linkedin.com/in/amadeusz-raczyński-6a336b222





