/*Create a table present_list consisting of 2 columns named: date and number_employees. Write a job that will run from Monday to Friday at 14.30. The purpose of the job is to log information about the number of employees at work on a given day to the current_list table (number of records from the employees table).
Attention. Joba should use a defined schedule and program (procedure).*/

-- Table for logs
CREATE TABLE lists_of_presents (d_date DATE, empl_numb NUMBER);

-- Job Schedule
BEGIN
DBMS_SCHEDULER.create_schedule
(schedule_name => 'Daily_harmonogram',
start_date => SYSTIMESTAMP,
repeat_interval => 'FREQ=DAILY; BYDAY=MON,TUE,WED,THU,FRI; BYHOUR=14; BYMINUTE=30;' ,
end_date => NULL,
comments => 'Powtarzany w dni robocze');
end;
/

-- Login procedure
CREATE OR REPLACE PROCEDURE log_info
IS
BEGIN
INSERT INTO lists_of_presents VALUES (SYSTIMESTAMP,
(SELECT COUNT(employees.employee_id) FROM EMPLOYEES));
END log_info;

-- JOB PROGRAM 
BEGIN
DBMS_SCHEDULER.create_program 
(program_name => 'add_info',
program_type => 'STORED_PROCEDURE',
program_action => 'log_info',
enabled => TRUE);
END;

-- JOB
BEGIN
DBMS_SCHEDULER.create_job
(job_name => 'Logging_Job',
program_name => 'add_info',
schedule_name => 'Daily_harmonogram',
enabled => TRUE,
comments => 'Job log info into lists_of_presents table.');
END;
/

-- Job execution
BEGIN
DBMS_SCHEDULER.run_JOB(job_name =>  'Logging_Job');
END;
