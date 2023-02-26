/*Create a package in the PL_SQL_Practice scheme, which will have 4 programs for managing products in the company:
procedure for adding/removing/modifying products (deleting and modifying products should be based on the product_id parameter)
a function that returns information about products (all columns from the products table based on the product_id parameter)*/


CREATE OR REPLACE PACKAGE prod_manage 
IS
PROCEDURE adding_prod(in_prod_name IN PRODUCTS.PRODUCT_NAME%TYPE);
PROCEDURE delete_prod(in_prod_id IN PRODUCTS.PRODUCT_ID%TYPE);
PROCEDURE modify_prod(in_prod_id IN PRODUCTS.PRODUCT_ID%TYPE, in_prod_name IN PRODUCTS.PRODUCT_NAME%TYPE );
FUNCTION prod_info(in_prod_id IN PRODUCTS.PRODUCT_ID%TYPE) RETURN PRODUCTS%ROWTYPE ;
END prod_manage ;
/

CREATE OR REPLACE PACKAGE BODY prod_manage
IS
-- Procedura dodawania produktów
PROCEDURE adding_prod(in_prod_name IN PRODUCTS.PRODUCT_NAME%TYPE) 
IS
BEGIN
INSERT INTO PRODUCTS ( PRODUCT_NAME) VALUES (in_prod_name);
END adding_prod; 
-- Procedura do usuwania produktów
PROCEDURE delete_prod(in_prod_id IN PRODUCTS.PRODUCT_ID%TYPE)
IS
BEGIN
DELETE FROM PRODUCTS WHERE in_prod_id = PRODUCTS.PRODUCT_ID;
END delete_prod  ;
-- Procedura do modyfikacji produktów
PROCEDURE modify_prod(in_prod_id IN PRODUCTS.PRODUCT_ID%TYPE, in_prod_name IN PRODUCTS.PRODUCT_NAME%TYPE )
IS
BEGIN
UPDATE PRODUCTS SET PRODUCT_NAME = in_prod_name
WHERE in_prod_id = PRODUCTS.PRODUCT_ID;
END modify_prod ;
-- Funkcja do zwracania info o produktach
FUNCTION prod_info(in_prod_id IN PRODUCTS.PRODUCT_ID%TYPE) RETURN PRODUCTS%ROWTYPE 
IS
v_zmienna PRODUCTS%ROWTYPE;
BEGIN
SELECT * INTO v_zmienna FROM PRODUCTS WHERE in_prod_id = PRODUCTS.PRODUCT_ID;
RETURN v_zmienna;
END prod_info;
END prod_manage;
/
