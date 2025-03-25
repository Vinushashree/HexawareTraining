
CREATE DATABASE CarRentalSystemDB;
USE CarRentalSystemDB;

CREATE TABLE Vehicle (
    vehicleID INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    dailyRate DECIMAL(10,2),
    status VARCHAR(20) CHECK (status IN ('available', 'notAvailable')), 
    passengerCapacity INT,
    engineCapacity INT
);

CREATE TABLE Customer (
    customerID INT PRIMARY KEY,
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phoneNumber VARCHAR(15) UNIQUE
);

CREATE TABLE Lease (
    leaseID INT PRIMARY KEY,
    vehicleID INT,
    customerID INT,
    startDate DATE,
    endDate DATE,
    leaseType VARCHAR(20) CHECK (leaseType IN ('Daily', 'Monthly')), 
    FOREIGN KEY (vehicleID) REFERENCES Vehicle(vehicleID),
    FOREIGN KEY (customerID) REFERENCES Customer(customerID)
);

CREATE TABLE Payment (
    paymentID INT PRIMARY KEY,
    leaseID INT,
    paymentDate DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (leaseID) REFERENCES Lease(leaseID) 
);

INSERT INTO Vehicle VALUES
(1, 'Toyota', 'Camry', 2022, 50.00, 'available', 4, 1450),
(2, 'Honda', 'Civic', 2023, 45.00, 'available', 7, 1500),
(3, 'Ford', 'Focus', 2022, 48.00, 'notAvailable', 4, 1400),
(4, 'Nissan', 'Altima', 2023, 52.00, 'available', 7, 1200),
(5, 'Chevrolet', 'Malibu', 2022, 47.00, 'available', 4, 1800),
(6, 'Hyundai', 'Sonata', 2023, 49.00, 'notAvailable', 7, 1400),
(7, 'BMW', '3 Series', 2023, 60.00, 'available', 7, 2499),
(8, 'Mercedes', 'C-Class', 2022, 58.00, 'available', 8, 2599),
(9, 'Audi', 'A4', 2022, 55.00, 'notAvailable', 4, 2500),
(10, 'Lexus', 'ES', 2023, 54.00, 'available', 4, 2500);

INSERT INTO Customer VALUES
(1, 'John', 'Doe', 'johndoe@example.com', '555-555-5555'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '555-123-4567'),
(3, 'Robert', 'Johnson', 'robert@example.com', '555-789-1234'),
(4, 'Sarah', 'Brown', 'sarah@example.com', '555-456-7890'),
(5, 'David', 'Lee', 'david@example.com', '555-987-6543'),
(6, 'Laura', 'Hall', 'laura@example.com', '555-234-5678'),
(7, 'Michael', 'Davis', 'michael@example.com', '555-876-5432'),
(8, 'Emma', 'Wilson', 'emma@example.com', '555-432-1098'),
(9, 'William', 'Taylor', 'william@example.com', '555-321-6547'),
(10, 'Olivia', 'Adams', 'olivia@example.com', '555-765-4321');

INSERT INTO Lease VALUES
(1, 1, 1, '2023-01-01', '2023-01-05', 'Daily'),
(2, 2, 2, '2023-02-15', '2023-02-28', 'Monthly'),
(3, 3, 3, '2023-03-10', '2023-03-15', 'Daily'),
(4, 4, 4, '2023-04-20', '2023-04-30', 'Monthly'),
(5, 5, 5, '2023-05-05', '2023-05-10', 'Daily'),
(6, 4, 3, '2023-06-15', '2023-06-30', 'Monthly'),
(7, 7, 7, '2023-07-01', '2023-07-10', 'Daily'),
(8, 8, 8, '2023-08-12', '2023-08-15', 'Monthly'),
(9, 3, 3, '2023-09-07', '2023-09-10', 'Daily'),
(10, 10, 10, '2023-10-10', '2023-10-31', 'Monthly');

INSERT INTO Payment VALUES
(1, 1, '2023-01-03', 200.00),
(2, 2, '2023-02-20', 1000.00),
(3, 3, '2023-03-12', 75.00),
(4, 4, '2023-04-25', 900.00),
(5, 5, '2023-05-07', 60.00),
(6, 6, '2023-06-18', 1200.00),
(7, 7, '2023-07-03', 40.00),
(8, 8, '2023-08-14', 1100.00),
(9, 9, '2023-09-09', 80.00),
(10, 10, '2023-10-25', 1500.00);

select * from Customer
select * from Vehicle
select * from Payment
select * from Lease

 --Update the daily rate for a Mercedes car to 68.
UPDATE Vehicle
SET dailyRate = 68
WHERE make = 'Mercedes';
select * from vehicle

--Delete a specific customer and all associated leases and payments.

DELETE FROM Payment WHERE leaseID IN (SELECT leaseID FROM Lease WHERE customerID =2);
DELETE FROM Lease WHERE customerID = 2;
DELETE FROM Customer WHERE customerID =2;
select * from Customer
select * from Vehicle
select * from Payment
select * from Lease

--Rename the "paymentDate" column in the Payment table to "transactionDate"
EXEC sp_rename 'Payment.paymentDate', 'transactionDate', 'COLUMN';

 --specific customer by email
SELECT * FROM Customer WHERE email = 'emma@example.com';

 --Get active leases for a specific customer
SELECT * FROM Lease WHERE customerID = 6 AND endDate >= GETDATE();

--  all payments made by a customer with a specific phone number.
SELECT p.* FROM Payment p
JOIN Lease l ON p.leaseID = l.leaseID
JOIN Customer c ON l.customerID = c.customerID
WHERE c.phoneNumber = '555-765-4321';

-- average daily rate of all available cars.
SELECT AVG(dailyRate) AS avgDailyRate FROM Vehicle WHERE status = 'available';

--  car with the highest daily rate.
SELECT * FROM Vehicle WHERE dailyRate = (SELECT MAX(dailyRate) FROM Vehicle);

-- all cars leased by a specific customer.
SELECT v.* FROM Vehicle v
JOIN Lease l ON v.vehicleID = l.vehicleID
WHERE l.customerID = 4;

-- details of the most recent lease.
SELECT TOP 1 * FROM Lease ORDER BY startDate DESC;


--  all payments made in the year 2023.
SELECT * FROM Payment WHERE YEAR(transactionDate) = 2023;


-- customers who have not made any payments.
SELECT * FROM Customer
WHERE customerID NOT IN (SELECT DISTINCT customerID FROM Lease WHERE leaseID IN (SELECT DISTINCT leaseID FROM Payment));

--  Car Details and Their Total Payments.
SELECT V.vehicleID, V.make, V.model, SUM(P.amount) AS TotalPayments
FROM Vehicle V
JOIN Lease L ON V.vehicleID = L.vehicleID
JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY V.vehicleID, V.make, V.model;


--  Total Payments for Each Customer.
SELECT C.customerID, C.firstName, C.lastName, SUM(P.amount) AS TotalPaid
FROM Customer C
JOIN Lease L ON C.customerID = L.customerID
JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName;

-- Car Details for Each Lease.
SELECT l.*, v.make, v.model, v.year FROM Lease l
JOIN Vehicle v ON l.vehicleID = v.vehicleID;

-- Details of Active Leases with Customer and Car Information.
SELECT l.*, c.firstName, c.lastName, v.make, v.model, v.year
FROM Lease l
JOIN Customer c ON l.customerID = c.customerID
JOIN Vehicle v ON l.vehicleID = v.vehicleID
WHERE l.endDate >= GETDATE();

-- Customer Who Has Spent the Most on Leases.
SELECT TOP 1 C.customerID, C.firstName, C.lastName, SUM(P.amount) AS totalSpent
FROM Customer C
JOIN Lease L ON C.customerID = L.customerID
JOIN Payment P ON L.leaseID = P.leaseID
GROUP BY C.customerID, C.firstName, C.lastName
ORDER BY totalSpent DESC;

 --All Cars with Their Current Lease Information.
SELECT v.*, l.leaseID, l.customerID, l.startDate, l.endDate
FROM Vehicle v
LEFT JOIN Lease l ON v.vehicleID = l.vehicleID
AND l.endDate >= GETDATE();
