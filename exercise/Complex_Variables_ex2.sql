/*Create a nested table collection containing numbers from 1 to 10. Then, using the DELETE method, delete elements 2, 5 and 9. 
Then display the contents of the entire collection using the NEXT method.
Attention. You need the NEXT method to iterate only over the elements of the collection in the loop, i.e. to go from index 1 
to index 3, and from index 4 to index 6, etc. In other words, your loop should make 7, not 10, iterations, because that's 
how many elements the collection contains.*/

DECLARE
TYPE type_nt IS TABLE OF VARCHAR2(15);
nt_type type_nt := type_nt('1', '2', '3', '4', '5', '6', '7', '8', '9', '10');
v_indeks VARCHAR(20);
BEGIN
nt_type.DELETE(2);
nt_type.DELETE(5);
nt_type.DELETE(9);
v_indeks := nt_type.FIRST;    
while (v_indeks IS NOT NULL)
LOOP
DBMS_OUTPUT.PUT_LINE(nt_type(v_indeks));
v_indeks := nt_type.next(v_indeks);
END LOOP;
END;
