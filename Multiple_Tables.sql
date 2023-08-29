SELECT *
FROM payments;

-- Inner Join
-- customerNumber is present in payments table, get customerName from customers table
SELECT pay.customerNumber, paymentDate, 
		amount, customerName
FROM payments pay
INNER JOIN customers cust
ON pay.customerNumber = cust.customerNumber;


-- joining multiple tables
SELECT orderNumber, status,
		o.customerNumber, c.customerName,
        c.salesRepEmployeeNumber, e.firstName,
        e.lastName, e.jobTitle
FROM orders o
INNER JOIN customers c 
ON o.customerNumber = c.customerNumber
INNER JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber;


-- self join
SELECT e1.firstName, e1.jobTitle, e1.employeeNumber,
		e2.firstName as ManagerName, e2.jobTitle as ManagerTitle, e2.employeeNumber as ManagerId
FROM employees e1
INNER JOIN employees e2
ON e1.reportsTo = e2.employeeNumber;


-- implicit join
SELECT p.customerNumber, c.customerName,
		p.checkNumber, p.paymentDate, p.amount
FROM payments p, customers c
WHERE p.customerNumber = c.customerNumber;


-- outer join
-- Customer -> what orders have been placed by each customer

-- problem with inner join -> we won't get customers who have not placed any order

SELECT c.customerNumber, c.customerName,
		o.orderNumber
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber;

-- left join will retain all records from left table
SELECT c.customerNumber, c.customerName,
		o.orderNumber
FROM customers c
LEFT JOIN orders o
ON c.customerNumber = o.customerNumber;

SELECT c.customerNumber
FROM customers c
WHERE c.customerNumber NOT IN (SELECT customerNumber FROM orders);


-- self outer join
-- in SELF INNER JOIN we did not get President entry as he does not reports to anyone 
SELECT e1.employeeNumber, e1.firstName, e1.jobTitle,
		e2.employeeNumber, e2.firstName, e2.jobTitle
FROM employees e1
LEFT JOIN employees e2
ON e1.reportsTo = e2.employeeNumber;


-- USING clause
-- column name should be same on which we are trying to JOIN
SELECT c.customerNumber, c.customerName,
		o.orderNumber
FROM customers c
LEFT JOIN orders o
USING (customerNumber);

SELECT c.customerNumber, c.customerName,
		o.orderNumber
FROM customers c
JOIN orders o
USING (customerNumber);

SELECT orderNumber, status,
		o.customerNumber, c.customerName,
        c.salesRepEmployeeNumber, e.firstName,
        e.lastName, e.jobTitle
FROM orders o
INNER JOIN customers c 
USING (customerNumber)
INNER JOIN employees e
ON e.employeeNumber = c.salesRepEmployeeNumber;


-- Natural JOIN (Not recommended)
-- we don't specify the columns
SELECT orderNumber, customerName, customerNumber
FROM orders
NATURAL JOIN customers;