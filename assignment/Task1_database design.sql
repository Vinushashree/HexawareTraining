create database MyshopDB
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT,
    QuantityInStock INT,
    LastStockUpdate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
	);

	
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES 
('Vinusha', 'Shree', 'vinusha.18@example.com', '3748790274', '098 MI Road, Goa, TamilNadu'),
('Thrisha', 'Anbu', 'th23an.22@example.com', '3475790377', '987 Park Street, Kolkata, West Bengal'),
('Vishnu', 'Priya', 'v23.pri@example.com', '2112347588', '876 Sector 22, Noida, Uttar Pradesh'),
('Hema', 'Tharuni', 'hh34.th@example.com', '3546789033', '765 Jayanagar, Bangalore, Karnataka'),
('Vikash', 'Ram', 'vikash.12@example.com', '1234567890', '654 Andheri East, Mumbai, Maharashtra'),
('Aarav', 'Mishra', 'aarav.m@example.com', '9988776655', '101 Green Avenue, Pune, Maharashtra'),
('Diya', 'Iyer', 'diya.iyer@example.com', '8877665544', '202 Nehru Nagar, Chennai, TamilNadu'),
('Rajesh', 'Kumar', 'rajesh.k@example.com', '7766554433', '303 MG Road, Hyderabad, Telangana'),
('Sanya', 'Reddy', 'sanya.reddy@example.com', '6655443322', '404 Jubilee Hills, Hyderabad, Telangana'),
('Ankit', 'Verma', 'ankit.verma@example.com', '5544332211', '505 Sector 18, Gurgaon, Haryana');

INSERT INTO Products (ProductName, Description, Price)
VALUES 
('Smartphone', 'Latest 5G smartphone with AMOLED display', 25000.00),
('Laptop', 'High-performance laptop with SSD and 16GB RAM', 55000.00),
('Smartwatch', 'Water-resistant smartwatch with health tracking', 4999.00),
('Wireless Earbuds', 'Noise-canceling Bluetooth earbuds with long battery life', 3500.00),
('Gaming Mouse', 'Ergonomic gaming mouse with customizable RGB lighting', 2200.00),
('Bluetooth Speaker', 'Portable speaker with deep bass and clear sound', 4000.00),
('Power Bank', '10,000mAh fast-charging power bank with dual USB ports', 1800.00),
('Wireless Keyboard', 'Slim and compact wireless keyboard with long battery life', 2800.00),
('External Hard Drive', '1TB portable hard drive for secure data storage', 4500.00),
('Smart TV', 'Ultra HD 4K Smart TV with built-in apps and voice control', 48000.00);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES 
(1, '2024-09-10', 100.00),
(2, '2024-09-11', 200.00),
(3, '2024-09-12', 150.00),
(4, '2024-09-13', 75.00),
(5, '2024-09-14', 180.00),
(2, '2024-09-15', 250.00),
(3, '2024-09-16', 90.00),
(4, '2024-09-17', 300.00),
(1, '2024-09-18', 120.00),
(5, '2024-09-19', 210.00);


INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES 
(1, 1, 10),
(1, 3, 2),
(7, 3, 2),
(5, 4, 5),
(5, 2, 2),
(5, 1, 6),
(3, 5, 3),
(4, 2, 4),
(6, 1, 8),
(8, 4, 2),
(9, 3, 7);


INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate)
VALUES 
(1, 600, '2024-08-01'),
(2, 300, '2024-08-05'),
(3, 160, '2024-08-08'),
(4, 350, '2024-08-09'),
(5, 120, '2024-08-10'),
(6, 500, '2024-08-12'),
(7, 450, '2024-08-14'),
(8, 200, '2024-08-15'),
(9, 380, '2024-08-16'),
(10, 250, '2024-08-18');