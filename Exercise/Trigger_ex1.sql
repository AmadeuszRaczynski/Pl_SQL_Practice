/*Write a trigger that will prevent logging into the database on weekends (Saturday and Sunday).
** Write a trigger that will additionally prohibit logging into the database outside of 7.00-18.00 on working days (Monday to Friday).*/

DROP TRIGGER logon_try_week
;
CREATE OR REPLACE TRIGGER logon_try
AFTER LOGON ON DATABASE
BEGIN
IF (to_char(sysdate, 'd'))= 6 OR (to_char(sysdate, 'd')) = 7 THEN
RAISE_APPLICATION_ERROR(-20001, 'Nie mozesz sie zalogowac do bazy');
END IF;
END logon_try;


CREATE OR REPLACE TRIGGER logon_try_mon_fr
AFTER LOGON ON DATABASE
BEGIN
IF (to_char(sysdate, 'd')) IN (1,2,3,4,5) AND (to_char(sysdate,'HH24:MI:SS') < '07:00:00' OR to_char(sysdate,'HH24:MI:SS') > '18:00:00')  THEN
RAISE_APPLICATION_ERROR(-20001, 'Nie mozesz sie zalogowac do bazy');
END IF;
END logon_try;
