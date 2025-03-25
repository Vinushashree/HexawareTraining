-- 1. Retrieve the names and emails of all customers.
SELECT FirstName, LastName, Email 
FROM Customers;


-- 2. List all orders with their order dates and corresponding customer names.

SELECT Orders.OrderID, Orders.OrderDate,Customers.FirstName,Customers.LastName
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID;


--  3. Insert a new customer record into the "Customers" table.

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES ('shree', 'Sharma', 'shree.sharma@example.com', '4567890123', '67 NG Nagar, Bangaluru, Karnataka');

Select * from Customers;

-- 4. Update the prices of all electronic gadgets in the "Products" table by increasing them by 10%.

Select * from Products;

UPDATE Products
SET Price = Price * 1.10;

Select * from Products;

--  5. Delete a specific order and its associated order details.


DELETE FROM OrderDetails 
WHERE OrderID = 4;

DELETE FROM Orders 
WHERE OrderID =4;


-- 6. Insert a new order into the "Orders" table.

Select * from Orders;

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES (1, '2024-04-15', 2340.00); 

Select * from Orders;

-- 7. Update the contact information of a specific customer.

UPDATE Customers
SET Email = 'rathi12l@email.com', Address = '123 west street,dial'
WHERE CustomerID = 1;


-- 8. Recalculate and update the total cost of each order.

UPDATE Orders
SET TotalAmount = (
    SELECT SUM(Product.Price * OrderDetails.Quantity)
    FROM OrderDetails 
    JOIN Products  ON OrderDetails.ProductID = Products.ProductID
    WHERE OrderDetails.OrderID = Orders.OrderID
);

-- 9. Delete all orders and their associated order details for a specific customer.

DELETE FROM OrderDetails WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = 8);

DELETE FROM Orders WHERE CustomerID = 8;
--  10. Insert a new electronic gadget product into the "Products" table.

INSERT INTO Products (ProductName, Description, Price)
VALUES ('Bluetooth Speaker', 'Portable speaker with excellent sound quality', 2500.00);

Select * from products;

-- 11. Update the status of a specific order.
ALTER TABLE Orders 
ADD Status VARCHAR(50);


UPDATE Orders
SET OrderStatus = 'Shipped'
WHERE OrderID = 5;

UPDATE Orders
SET OrderStatus = 'Pending'
WHERE OrderStatus IS NULL;



-- 12. Calculate and update the number of orders placed by each customer.
ALTER TABLE Customers 
ADD NumberOfOrders INT DEFAULT 0;

UPDATE Customers
SET NumberOfOrders = (
    SELECT COUNT(*)
    FROM Orders
    WHERE Orders.CustomerID = Customers.CustomerID
);

Select * from Customers;
