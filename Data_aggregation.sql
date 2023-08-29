-- aggregate functions in MySQL
-- MAX() MIN() AVG() SUM() COUNT()
-- COUNT() counts NON null values only

SELECT MAX(amount) as highestPyament,
		MIN(amount) as lowestPyament,
        AVG(amount) as averagePayment,
        SUM(amount) as totalPayment
FROM payments;


SELECT COUNT(*) as totalOrders,
		COUNT(requiredDate) as totalOrders,
		COUNT(shippedDate) as shippedOrders
FROM orders;

SELECT COUNT(*)
FROM orders
WHERE status = 'In Process';

SELECT MAX(paymentDate),
		MIN(paymentDate)
FROM payments;

SELECT MAX(checkNumber),
		MIN(checkNumber)
FROM payments;


-- GROUP BY

SELECT COUNT(*)
FROM products;

SELECT DISTINCT productLine
FROM products;

SELECT productLine, COUNT(*) as productCount
FROM products
GROUP BY productLine;

-- count of employees, officecode, location that work in the same location
SELECT o.officeCode, o.city, 
		COUNT(employeeNumber) as numberOfEmployees
FROM employees e
INNER JOIN offices o
ON e.officeCode = o.officeCode
GROUP BY e.officeCode;


-- HAVING clause
SELECT e.officeCode, o.city,
		COUNT(employeeNumber) as employeeCount
FROM employees e 
INNER JOIN offices o
ON e.officeCode = o.officeCode
GROUP BY e.officeCode
HAVING employeeCount >= 4
ORDER BY employeeCount DESC;


-- query sequence FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> DISTINCT -> ORDER BY -> LIMIT

-- display number of orders country wise, display only orders where order count > 20
SELECT c.country, o.orderNumber,
		COUNT(orderNumber) as totalOrders
FROM orders o
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
WHERE c.country IN ("USA", "France")
GROUP By c.country
HAVING totalOrders > 20
ORDER BY totalOrders DESC;


-- total payments from each customer after a certain date
SELECT c.customerNumber,c.customerName,
		SUM(amount) as totalAmount
FROM payments p
INNER JOIN customers c
ON p.customerNumber = c.customerNumber
WHERE p.paymentDate > '2004-04-14'
GROUP BY c.customerNumber
ORDER BY totalAmount DESC;


-- Value of each unique order sorted by total order value
SELECT o.orderNumber, od.productCode,
        c.customerName, SUM(od.quantityOrdered*od.priceEach) as orderTotal
FROM orders o
INNER JOIN orderdetails od
ON o.orderNumber = od.orderNumber
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
GROUP BY o.orderNumber
ORDER BY orderTotal DESC;


-- Value of each unique order, customer Name and sales employee sorted by total order value 
SELECT od.orderNumber, od.productCode,
		c.customerNumber, c.customerName, e.firstName,
        SUM(od.quantityOrdered*od.priceEach) as totalOrderValue
FROM orderdetails od
INNER JOIN orders o
ON od.orderNumber = o.orderNumber
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
INNER JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY od.orderNumber
ORDER BY totalOrderValue DESC;


-- number of orders each customer has placed with sales employee name
SELECT c.customerNumber, c.customerName,
		COUNT(orderNumber) as totalOrders,
        e.employeeNumber, e.firstName
FROM orders o
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
INNER JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY o.customerNumber;


-- number of orders to each sales representative
SELECT e.employeeNumber, e.firstName,
		COUNT(orderNumber) as totalOrderByEmployee
FROM orders o
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
INNER JOIN employees e
ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY e.employeeNumber;


-- number of orders by each country on each date
SELECT c.country, o.orderDate,
		COUNT(orderNumber) as totalOrders
FROM orders o
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
GROUP BY c.country, o.orderDate;


-- find customers whose total order value > 80,000 across all their orders
SELECT c.customerNumber, c.customerName,
	SUM(od.quantityOrdered*od.priceEach) as totalOrderValue
FROM orderdetails od
INNER JOIN orders o
ON od.orderNumber = o.orderNumber
INNER JOIN customers c
ON o.customerNumber = c.customerNumber
GROUP BY c.customerNumber
HAVING totalOrderValue > 80000;
