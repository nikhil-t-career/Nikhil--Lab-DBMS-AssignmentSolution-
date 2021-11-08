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

/*
output

2	Appario Ltd.	4	Average Supplier
4	Bansal Retails	3	Average Supplier
1	Rajesh Retails	5	Genuine Supplier
3	Knome products	2	Supplier should not be considered
5	Mittal Ltd.	4	Average Supplier

*/