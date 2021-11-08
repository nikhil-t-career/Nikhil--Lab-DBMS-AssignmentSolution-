#=====================Questions and Solutions====================

-- 3) Display the number of the customer group by their genders who have placed any order
-- of amount greater than or equal to Rs.3000.
SELECT
	COUNT(CUSTOMER_ID),
	CUSTOMER_GENDER
FROM
	ORDER_DIR.CUSTOMER
GROUP BY
	CUSTOMER_GENDER ;

-- OUTPUT
-- 3	M
-- 2	F



-- 4) Display all the orders along with the product name ordered by a customer having
-- Customer_Id=2.

SELECT
	O.CUSTOMER_ID ,
	O.ORDER_ID ,
	PD.PRODUCT_DETAILS_ID ,
	P.PRODUCT_ID ,
	P.PRODUCT_NAME
FROM
	ORDER_DIR.ORDERS O
JOIN ORDER_DIR.PRODUCT_DETAILS PD ON
	O.PRODUCT_DETAILS_ID = PD.PRODUCT_DETAILS_ID
JOIN ORDER_DIR.PRODUCT P ON
	PD.PRODUCT_ID = P.PRODUCT_ID
WHERE
	O.CUSTOMER_ID = 2;

-- OUTPUT
-- 2	50	1	1	GTA V





-- 5) Display the Supplier details who can supply more than one product.

SELECT
	*
FROM
	ORDER_DIR.SUPPLIER S
WHERE
	S.SUPPLIER_ID IN (
	SELECT
		PD.SUPPLIER_ID
	FROM
		ORDER_DIR.PRODUCT_DETAILS PD
	GROUP BY
		PD.SUPPLIER_ID
	HAVING
		COUNT(PD.PRODUCT_ID) > 1);

-- OUTPUT
-- 1	Rajesh Retails	Delhi	1234567890
	
	
	
	

-- 6) Find the category of the product whose order amount is minimum.
-- JOIN ORDER -> PRODUCT_DETAIILS -> PRODUCT -> CATEGORY
SELECT
	O.PRODUCT_DETAILS_ID,
	P.PRODUCT_ID ,
	P.PRODUCT_NAME,
	C.CATEGORY_NAME,
	SUM(O.ORDER_AMOUNT)
FROM
	ORDER_DIR.ORDERS O
JOIN ORDER_DIR.PRODUCT_DETAILS PD ON
	O.PRODUCT_DETAILS_ID = PD.PRODUCT_DETAILS_ID
JOIN ORDER_DIR.PRODUCT P ON
	PD.PRODUCT_ID = P.PRODUCT_ID
JOIN ORDER_DIR.CATEGORY C ON
	P.CATEGORY_ID = C.CATEGORY_ID
GROUP BY
	O.PRODUCT_DETAILS_ID
ORDER BY
	SUM(O.ORDER_AMOUNT)
LIMIT 1;

-- OUTPUT
-- 5	4	OATS	GROCERIES	1500
	
	



-- 7) Display the Id and Name of the Product ordered after “2021-10-05”.
-- ORDER AFTER DATE -> PRODUCT_DETAILS -> PRODUCT ID AND NAME

SELECT
	O.ORDER_ID ,
	O.ORDER_DATE,
	PD.PRODUCT_ID ,
	P.PRODUCT_NAME
FROM
	ORDER_DIR.ORDERS O
JOIN ORDER_DIR.PRODUCT_DETAILS PD ON
	O.PRODUCT_DETAILS_ID = PD.PRODUCT_DETAILS_ID
JOIN ORDER_DIR.PRODUCT P ON
	PD.PRODUCT_ID = P.PRODUCT_ID
WHERE
	O.ORDER_DATE > '2021-10-05';


-- OUTPUT
-- 20	2021-10-12	4	OATS
-- 50	2021-10-06	1	GTA V




-- 8) Print the top 3 supplier name and id and their rating on the basis of their rating along
-- with the customer name who has given the rating.
-- RATING TABLE -> SUPPLIER -> CUSTOMER TABLE JOINS AND TOP 3
SELECT
	R.RATING_ID ,
	S.SUPPLIER_NAME ,
	C.CUSTOMER_NAME ,
	R.RATING_STARS
FROM
	ORDER_DIR.RATINGS R
JOIN ORDER_DIR.SUPPLIER S ON
	R.SUPPLIER_ID = S.SUPPLIER_ID
JOIN ORDER_DIR.CUSTOMER C ON
	R.CUSTOMER_ID = C.CUSTOMER_ID
ORDER BY
	R.RATING_STARS DESC
LIMIT 3;


-- OUTPUT
-- 3	Rajesh Retails	PULKIT	5
-- 1	Appario Ltd.	AMAN	4
-- 5	Mittal Ltd.		MEGHA	4


-- 9) Display customer name and gender whose names start or end with character 'A'.
SELECT
	C.CUSTOMER_NAME ,
	C.CUSTOMER_GENDER
FROM
	ORDER_DIR.CUSTOMER C
WHERE
	C.CUSTOMER_NAME LIKE 'A%'
	OR C.CUSTOMER_NAME LIKE '%A';

/*
OUTPUT

AAKASH	M
AMAN	M
NEHA	F
MEGHA	F

*/



-- 10) Display the total order amount of the male customers.
-- ORDER -> CUSTOMER
SELECT
	SUM(O.ORDER_AMOUNT) ,
	C.CUSTOMER_GENDER
FROM
	ORDER_DIR.ORDERS O
JOIN ORDER_DIR.CUSTOMER C ON
	O.CUSTOMER_ID = C.CUSTOMER_ID
WHERE
	C.CUSTOMER_GENDER = 'M'
GROUP BY
	C.CUSTOMER_GENDER;

/*
OUTPUT

34500	M
*/





-- 11) Display all the Customers left outer join with the orders.
-- CUSTOMER -> ORDER
SELECT
	C.CUSTOMER_ID ,
	C.CUSTOMER_NAME ,
	O.ORDER_ID
FROM
	ORDER_DIR.CUSTOMER C
LEFT OUTER JOIN ORDER_DIR.ORDERS O ON
	C.CUSTOMER_ID = O.CUSTOMER_ID ;

/*

OUTPUT

1	AAKASH	26
2	AMAN	50
3	NEHA	20
4	MEGHA	30
5	PULKIT	25

*/



-- 12) Create a stored procedure to display the Rating for a Supplier if any along with the
-- Verdict on that rating if any like if rating >4 then “Genuine Supplier” if rating >2 “Average
-- Supplier” else “Supplier should not be considered”.


-- ANSWER FOR STORED PROC IN SEPARATE FILE AND BELOW AS WELL  
-- UNCOMMENT BELOW STORED PROC
/*
CREATE PROCEDURE ORDER_DIR.SUPPLIER_RATINGS()
BEGIN
	SELECT
	S.SUPPLIER_ID,
	S.SUPPLIER_NAME,
	R.RATING_STARS,
	CASE 
		WHEN R.RATING_STARS > 4 THEN 'Genuine Supplier'
		WHEN R.RATING_STARS > 2 THEN 'Average Supplier'
		ELSE 'Supplier should not be considered'
	END AS VERDICT
FROM
	ORDER_DIR.RATINGS R
INNER JOIN ORDER_DIR.SUPPLIER S ON
	R.SUPPLIER_ID = S.SUPPLIER_ID;
END

*/ 
-- UNCOMMENT ABOVE

/*
OUTPUT

2	Appario Ltd.	4	Average Supplier
4	Bansal Retails	3	Average Supplier
1	Rajesh Retails	5	Genuine Supplier
3	Knome products	2	Supplier should not be considered
5	Mittal Ltd.		4	Average Supplier
*/





