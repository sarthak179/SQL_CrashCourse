USE classicmodels;

SELECT * FROM customers;

SELECT firstName, lastName
FROM employees
WHERE officeCode = 1
ORDER BY firstName
LIMIT 3; 

SELECT firstName, 
	   lastName, 
	   email
FROM employees;

SELECT productCode,
		productName,
        buyPrice,
        MSRP AS sellingPrice,
        (MSRP*0.9 + 4) as discountedPrice
FROM products;

SELECT *
FROM orders
WHERE status <> "Shipped";

SELECT *
FROM payments
WHERE amount > 40000
ORDER BY amount DESC;

SELECT *
FROM payments
WHERE amount >= 40000 AND amount <= 60000;

SELECT *
FROM payments
WHERE NOT (amount >= 40000 AND amount <= 60000);

SELECT *
FROM payments
WHERE (amount >= 40000 OR amount <= 60000)
AND paymentDate >= '2005-05-25';

SELECT *
FROM employees
WHERE officeCode IN (1,2,4)
ORDER BY officeCode;

SELECT *
FROM employees
WHERE officeCode NOT IN (1,2,4)
ORDER BY officeCode;

SELECT *
FROM customers
WHERE creditLimit BETWEEN 20000 AND 40000
ORDER BY creditLimit;

SELECT *
FROM payments
WHERE amount > 20000
AND paymentDate BETWEEN '2003-05-31' AND '2004-05-31'
ORDER BY amount DESC;

SELECT *
FROM employees
WHERE jobTitle LIKE '%sale%';

-- underscore means single charcter match
SELECT *
FROM employees
WHERE firstName LIKE '____y';

-- REGEX operator
-- ^ beginning of string\
-- $ end of string
-- | logical OR
-- [abcd]
-- [a-z]

SELECT *
FROM employees
WHERE jobTitle REGEXP "sale";

SELECT *
FROM employees
WHERE jobTitle REGEXP "^sale";

SELECT *
FROM employees
WHERE jobTitle REGEXP "rep$";

SELECT *
FROM employees
WHERE firstName REGEXP "^a|^b";

SELECT *
FROM employees
WHERE firstName REGEXP "^[a-h]"
ORDER BY firstName;

SELECT *
FROM employees
WHERE firstName REGEXP "^[a-h]|lie$"
ORDER BY firstName;

SELECT *
FROM customers
WHERE phone REGEXP "555$";

SELECT *
FROM orders
WHERE comments IS NULL;

SELECT *
FROM orders
WHERE shippedDate IS NOT NULL;

SELECT *
FROM customers
ORDER BY city DESC, contactLastName;

SELECT *
FROM customers
LIMIT 20, 20;  -- skip first 20 records and give next 20;

SELECT *
FROM customers
ORDER BY creditLimit DESC
LIMIT 5;
