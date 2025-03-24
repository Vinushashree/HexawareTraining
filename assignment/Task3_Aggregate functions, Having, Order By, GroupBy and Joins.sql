use MyShopDB;

-- 1. Query to retrieve a list of all orders along with customer information:

SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName, c.Email, c.Phone
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 2. Query to find the total revenue generated by each electronic gadget product:

SELECT p.ProductName, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

-- 3. Query to list all customers who have made at least one purchase, including their names and contact information:

SELECT DISTINCT c.FirstName, c.LastName, c.Email, c.Phone, c.Address
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID;

-- 4. Query to find the most popular electronic gadget (the one with the highest total quantity ordered):

SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantityOrdered DESC;

-- 5. Query to retrieve a list of electronic gadgets along with their corresponding categories:

SELECT ProductName, Description
FROM Products
WHERE ProductName LIKE '%Electronic%';  


-- 6. Query to calculate the average order value for each customer:

SELECT c.FirstName, c.LastName, AVG(o.TotalAmount) AS AverageOrderValue
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;

-- 7. Query to find the order with the highest total revenue:

SELECT TOP 1 o.OrderID, c.FirstName, c.LastName, c.Email, SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID, c.FirstName, c.LastName, c.Email
ORDER BY TotalRevenue DESC;


-- 8. Query to list electronic gadgets and the number of times each product has been ordered:

SELECT p.ProductName, COUNT(od.OrderID) AS TimesOrdered
FROM Products p
JOIN OrderDetails od ON p.ProductID = od.ProductID
GROUP BY p.ProductName;

-- 9. Query to find customers who have purchased a specific electronic gadget product:
SELECT c.FirstName, c.LastName, c.Email
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.ProductName = 'Bluetooth Speaker'; 

-- 10. Query to calculate the total revenue generated by all orders placed within a specific time period:

DECLARE @StartDate DATE, @EndDate DATE;
SET @StartDate = '2023-08-15';  
SET @EndDate = '2024-10-14';    

SELECT SUM(od.Quantity * p.Price) AS TotalRevenue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE o.OrderDate BETWEEN @StartDate AND @EndDate;