/*Create a text-indexed associative collection. Save a list of all predefined Oracle exceptions to it. The index of the collection is the 
ORA code, the value stored in the collection is the name of the exception, e.g. collection(‘ora-01422’) should return “too_many_rows” and 
collection(‘ora-01001’) should return “invalid_cursor”. Use a WHILE loop to display the contents of the collection in the console.*/




DECLARE
TYPE type_at IS TABLE OF   VARCHAR2(100) INDEX BY VARCHAR2(20);
kolekcja_at type_at := type_at 
('ora-6530' => 'ACCESS_INTO_NULL',
'ora-6592' => 'CASE_NOT_FOUND',
'ora-6531'  => 'COLLECTION_IS_NULL',
'ora-6511'  => 'CURSOR_ALREADY_OPEN',
'ora-1'     => 'DUP_VAL_ON_INDEX',
'ora-1001'  => 'INVALID_CURSOR',
'ora-1722'  => ' INVALID_NUMBER',
'ora-1017'  => 'LOGIN_DENIED',
'ora+100'   => 'NO_DATA_FOUND',
'ora-6548'  => 'NO_DATA_NEEDED',
'ora-1012'  => 'NOT_LOGGED_ON',
'ora-6501'  => 'PROGRAM_ERROR',
'ora-6504'  => 'ROWTYPE_MISMATCH',
'ora-30625' => 'SELF_IS_NULL',
'ora-6500'  => 'STORAGE_ERROR',
'ora-6533'  => 'SUBSCRIPT_BEYOND_COUNT',
'ora-6532'  => 'SUBSCRIPT_OUTSIDE_LIMIT',
'ora-1410'  => 'SYS_INVALID_ROWID',
'ora-51'    => 'TIMEOUT_ON_RESOURCE',
'ora-1422'  => 'TOO_MANY_ROWS',
'ora-6502'  => 'VALUE_ERROR',
'ora-1476'  => 'ZERO_DIVIDE');
v_indeks VARCHAR(20);
BEGIN
v_indeks := kolekcja_at.FIRST;    
while (v_indeks IS NOT NULL)
LOOP
DBMS_OUTPUT.PUT_LINE(v_indeks || '  ' || kolekcja_at(v_indeks));
v_indeks := kolekcja_at.next(v_indeks);
END LOOP;
END;
