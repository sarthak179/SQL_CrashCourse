-- subqueries
-- find products that have same product line as of "1917 Grand Touring Sedan"
SELECT *
FROM products
WHERE productLine = 
	(SELECT productLine 
    FROM products 
    WHERE productName = "1917 Grand Touring Sedan");
    

-- find cars that are costlier than "1917 Grand Touring Sedan"
SELECT * 
FROM products
WHERE productLine REGEXP "car" 
AND MSRP > 
	(SELECT MSRP
    FROM products 
    WHERE productName = "1917 Grand Touring Sedan");
    
    
-- find cars costlier than average cost of all cars
SELECT *
FROM products
WHERE productLine REGEXP "car"
AND MSRP > (SELECT AVG(MSRP)
			FROM products
			WHERE productLine REGEXP "car");
            
            
-- customers who have never placed an order
SELECT *
FROM customers
WHERE customerNumber NOT IN (SELECT DISTINCT customerNumber
						FROM orders);

SELECT *
FROM customers c
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE orderNumber IS NULL;


-- customers who have ordered the product with product code "S18_1749"
SELECT DISTINCT c.customerNumber, c.customerName
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
ON od.orderNumber = o.orderNumber
WHERE od.productCode = "S18_1749";


-- ALL Keyword
-- find products costlier than all trucks
SELECT *
FROM products
WHERE MSRP > ALL(SELECT MSRP FROM products WHERE productLine REGEXP "truck");


-- ANY keyword
-- select clients who have made atleast two payments
SELECT * 
FROM customers 
WHERE customerNumber IN (SELECT customerNumber
						FROM payments 
						GROUP BY customerNumber
						HAVING COUNT(*) >= 2);
                        
SELECT * 
FROM customers 
WHERE customerNumber = ANY(SELECT customerNumber
						FROM payments 
						GROUP BY customerNumber
						HAVING COUNT(*) >= 2);           
                        

-- correlated subquery
-- find products whose price is higher than avg MSRP in their corresponding product line
-- slow in execution. but powerful and useful
SELECT *
FROM products p 
WHERE MSRP > (SELECT AVG(MSRP)
				FROM products
                WHERE productLine = p.productLine);


-- EXISTS
-- customer who have made atleast one payment
SELECT *
FROM customers
WHERE customerNumber IN (SELECT DISTINCT customerNumber
						FROM payments);
                        
SELECT *
FROM customers c
WHERE EXISTS (SELECT customerNumber -- return true as soon as customer is found in payments table
				FROM payments
				WHERE customerNumber = c.customerNumber);      -- customerNumber of customers table matches customerNumber in payments table
     
     
-- subquery in SELECT clause
-- write a query which creates the following view of the payments table
-- add two more columns - averagePayment and difference
SELECT *, (SELECT AVG(amount) FROM payments) as averageAmount,
		(amount - (SELECT AVG(amount) FROM payments)) as difference
FROM payments;


-- subquery in FROM clause
-- write a query which creates the following view of the payments table
-- add two more columns - averagePayment and difference > 0
SELECT *
FROM (SELECT *, (SELECT AVG(amount) FROM payments) as averageAmount,
		(amount - (SELECT AVG(amount) FROM payments)) as difference
FROM payments) AS t
WHERE difference > 0;
                
                
