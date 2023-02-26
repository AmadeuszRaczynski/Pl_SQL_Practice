/*Create a standalone error handler. The log table should contain information about the date of the error, the user performing the operation, the error code and error message.*/

DROP TABLE log_error;
CREATE  TABLE log_error (date_of_err TIMESTAMP, user_db VARCHAR2(40), error_code  NUMBER, error_msg   VARCHAR2(4000));
/

CREATE OR REPLACE PROCEDURE auto_log_error(in_date_of_err LOG_ERROR.DATE_OF_ERR%TYPE, in_user_db LOG_ERROR.USER_DB%TYPE,
in_error_code LOG_ERROR.ERROR_CODE%TYPE,in_err_msg LOG_ERROR.ERROR_MSG%TYPE)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
INSERT INTO log_error(date_of_err, user_db, error_code, error_msg )
VALUES (in_date_of_err , in_user_db , in_error_code , in_err_msg );
COMMIT;
END  auto_log_error;
/

BEGIN
    INSERT INTO countries ( country_id, country_name) VALUES (  'AR', 'Malta');
    EXCEPTION
    WHEN OTHERS THEN
    auto_log_error(in_date_of_err => SYSTIMESTAMP, in_user_db => USER,in_error_code => sqlcode, 
    in_err_msg => sqlerrm);
END;
/
