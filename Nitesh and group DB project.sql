CREATE DATABASE HyperwebHosting;
USE HyperwebHosting;

CREATE TABLE HostingPackages (
    PackageID INT PRIMARY KEY AUTO_INCREMENT,
    PackageName VARCHAR(50) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    StorageCapacity INT NOT NULL, -- Storage capacity in MB
    Bandwidth INT NOT NULL, -- Bandwidth in GB per month
    EmailAccounts INT,
    Subdomains INT,
    SSLCertificate BOOLEAN,
    SupportLevel VARCHAR(20) -- Basic, Standard, Premium
);

-- Create table for customer information
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15),
    Address TEXT
);

-- Create table for customer orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    PackageID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (PackageID) REFERENCES HostingPackages(PackageID)
);

-- Create table for payments
CREATE TABLE IF NOT EXISTS Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert sample data into HostingPackages table
INSERT INTO HostingPackages (PackageName, Description, Price, StorageCapacity, Bandwidth, EmailAccounts, Subdomains, SSLCertificate, SupportLevel)
VALUES 
('Basic', 'Ideal for personal websites', 5.99, 1000, 10, 5, 2, FALSE, 'Basic'),
('Standard', 'Suitable for small businesses', 9.99, 5000, 50, 20, 5, TRUE, 'Standard'),
('Premium', 'Advanced features for large enterprises', 19.99, 10000, 100, 50, 10, TRUE, 'Premium');

-- Insert sample data into Customers table
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address)
VALUES 
('Nitesh', 'Kumar', 'kotharinitesh657@gmail.com', '03368951449', 'Naz plaza mobile market saddar karachi'),
('Naveed', 'Ahmed', 'naveedjokhio243@gmail.com', '+92 304 6618347', 'fatieh sweets delhi colony karachi');

-- Insert sample data into Orders table
INSERT INTO Orders (CustomerID, PackageID, OrderDate)
VALUES 
(1, 1, '2024-06-07'), -- Nitesh ordered Basic package
(2, 2, '2024-06-08'); -- Naveed ordered Standard package

-- Insert sample data into Payments table
INSERT INTO Payments (OrderID, Amount, PaymentDate)
VALUES 
(1, 5.99, '2024-06-07'), -- Nitesh paid for Basic package
(2, 9.99, '2024-06-08'); -- Naveed paid for Standard package

-- 50 quries start from here
-- Muzzafar section
-- Query 1: Retrieve all hosting packages
SELECT * FROM HostingPackages;

-- Query 2: Retrieve all customers
SELECT * FROM Customers;

-- Query 3: Retrieve all orders
SELECT * FROM Orders;

-- Query 4: Retrieve all payments
SELECT * FROM Payments;

-- Query 5: Retrieve package details for the Basic package
SELECT * FROM HostingPackages WHERE PackageName = 'Basic';

-- Query 6: Retrieve customer details for Nitesh Kumar
SELECT * FROM Customers WHERE FirstName = 'Nitesh' AND LastName = 'Kumar';

-- Query 7: Retrieve orders made by Naveed Ahmed
SELECT * FROM Orders WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE FirstName = 'Naveed' AND LastName = 'Ahmed');

-- Query 8: Retrieve payments made by Nitesh Kumar
SELECT * FROM Payments WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = (SELECT CustomerID FROM Customers WHERE FirstName = 'Nitesh' AND LastName = 'Kumar'));

-- Query 9: Retrieve the total number of hosting packages
SELECT COUNT(*) AS TotalPackages FROM HostingPackages;

-- Query 10: Retrieve the total number of customers
SELECT COUNT(*) AS TotalCustomers FROM Customers;
-- Muzzafar Section End
-- Waseem Akram Section
-- Query 11: Retrieve the total number of orders
SELECT COUNT(*) AS TotalOrders FROM Orders;

-- Query 12: Retrieve the total number of payments
SELECT COUNT(*) AS TotalPayments FROM Payments;

-- Query 13: Retrieve the package with the highest price
SELECT * FROM HostingPackages ORDER BY Price DESC LIMIT 1;

-- Query 14: Retrieve the customer who made the most recent order
SELECT c.* 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate DESC
LIMIT 1;

-- Query 15: Retrieve orders made in June 2024
SELECT * FROM Orders WHERE YEAR(OrderDate) = 2024 AND MONTH(OrderDate) = 6;

-- Query 16: Retrieve payments made in June 2024
SELECT * FROM Payments WHERE YEAR(PaymentDate) = 2024 AND MONTH(PaymentDate) = 6;

-- Query 17: Retrieve orders with a total amount greater than $10
SELECT * FROM Orders WHERE OrderID IN (SELECT OrderID FROM Payments WHERE Amount < 10);

-- Query 18: Retrieve customers who have ordered the Premium package
SELECT c.* 
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.PackageID = 2;

-- Query 19: Retrieve customers who have not made any orders
SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

-- Query 20: Retrieve orders with payment dates in descending order
SELECT * FROM Orders ORDER BY PaymentDate DESC;
-- Waseem Akram Section End
-- Nitesh Section
-- Query 21: Retrieve the average price of hosting packages
SELECT AVG(Price) AS AveragePrice FROM HostingPackages;

-- Query 22: Retrieve the total revenue from orders
SELECT SUM(Amount) AS TotalRevenue FROM Payments;

-- Query 23: Update the package price for the Premium package
UPDATE HostingPackages SET Price = 24.99 WHERE PackageName = 'Premium';

-- Query 24: Update the email address for customer with ID 1
UPDATE Customers SET Email = 'niteshkumar@gmail.com' WHERE CustomerID = 1;

-- Query 25: Delete the payment with ID 1
DELETE FROM Payments WHERE PaymentID = 1;

-- Query 26: Delete the customer with ID 2
DELETE FROM Customers WHERE CustomerID = 2;

-- Query 27: Calculate the total number of customers who have ordered the Basic package
SELECT COUNT(*) AS BasicCustomers
FROM (
    SELECT DISTINCT c.CustomerID
    FROM Customers c
    JOIN Orders o ON c.CustomerID = o.CustomerID
    WHERE o.PackageID = 1
) AS BasicCustomers;

-- Query 28: Retrieve the order details for the most recent order
SELECT * FROM Orders ORDER BY OrderDate DESC LIMIT 1;

-- Query 29: Retrieve the oldest payment made
SELECT * FROM Payments ORDER BY PaymentDate LIMIT 1;

-- Query 30: Retrieve orders made by customers with email addresses containing 'example.com'
SELECT * 
FROM Orders 
WHERE CustomerID IN (SELECT CustomerID FROM Customers WHERE Email LIKE 'kotharinitesh657@gmail.com');

-- Query 31: Retrieve customers who have ordered the Basic or Standard package
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID FROM Orders WHERE PackageID IN (1, 2)
);

-- Query 32: Retrieve orders made in 2024 with amounts greater than $15
SELECT * 
FROM Orders 
WHERE YEAR(OrderDate) = 2024 AND OrderID IN (
    SELECT OrderID FROM Payments WHERE Amount > 15
);

-- Query 33: Retrieve orders made in January 2024
SELECT * 
FROM Orders 
WHERE YEAR(OrderDate) = 2024 AND MONTH(OrderDate) = 1;

-- Query 34: Retrieve orders made by customers with the last name 'Doe'
SELECT * 
FROM Orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers WHERE LastName = 'Kumar'
);

-- Query 35: Retrieve customers who have not made any payments
SELECT * FROM Customers WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);
-- Nitesh Section End
-- NAveed Section
-- Query 36: Retrieve payments made on June 06, 2024
SELECT * FROM Payments WHERE PaymentDate = '2024-06-06';

-- Query 37: Retrieve customers who have ordered the Premium package with a payment amount greater than $10
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT o.CustomerID 
    FROM Orders o 
    JOIN Payments p ON o.OrderID = p.OrderID 
    WHERE o.PackageID = 2 AND p.Amount < 10
);

-- Query 38: Retrieve orders made by customers with phone numbers starting with '123'
SELECT * 
FROM Orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers WHERE Phone LIKE '03368951449%'
);

-- Query 39: Retrieve customers who have ordered the same package more than once
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    GROUP BY CustomerID, PackageID 
    HAVING COUNT(*) = 1
);

-- Query 40: Retrieve payments made on or after June 1, 2024
SELECT * FROM Payments WHERE PaymentDate >= '2024-06-01';

-- Query 41: Retrieve customers who have ordered packages with a storage capacity greater than 5000 MB
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT o.CustomerID 
    FROM Orders o 
    JOIN HostingPackages h ON o.PackageID = h.PackageID 
    WHERE h.StorageCapacity > 5000
);

-- Query 42: Retrieve orders made by customers with addresses containing 'fatieh sweets delhi colony karachi'
SELECT * 
FROM Orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers WHERE Address LIKE '%fatieh sweets delhi colony karachi%'
);

-- Query 43: Retrieve customers who have ordered the Basic package and paid less than $10
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT o.CustomerID 
    FROM Orders o 
    JOIN Payments p ON o.OrderID = p.OrderID 
    WHERE o.PackageID =2
    AND p.Amount < 10
);

-- Query 44: Retrieve payments made between June 1, 2024, and June 15, 2024
SELECT * FROM Payments WHERE PaymentDate BETWEEN '2024-06-01' AND '2024-06-07';

-- Query 45: Retrieve customers who have ordered the Premium package and have an SSL certificate
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT o.CustomerID 
    FROM Orders o 
    JOIN HostingPackages h ON o.PackageID = h.PackageID 
    WHERE h.PackageName = 'Premium' AND h.SSLCertificate = TRUE
);

-- Query 46: Retrieve orders made by customers with addresses in 'City'
SELECT * 
FROM Orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers WHERE Address LIKE '%City%'
);

-- Query 47: Retrieve customers who have ordered more than one package
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT CustomerID 
    FROM Orders 
    GROUP BY CustomerID 
    HAVING COUNT(DISTINCT PackageID) > 1
);

-- Query 48: Retrieve orders made by customers with email addresses not ending with 'example.com'
SELECT * 
FROM Orders 
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers WHERE Email NOT LIKE '%example.com'
);

-- Query 49: Retrieve customers who have ordered the Premium package and paid more than $15
SELECT * 
FROM Customers 
WHERE CustomerID IN (
    SELECT o.CustomerID 
    FROM Orders o 
    JOIN Payments p ON o.OrderID = p.OrderID 
    WHERE o.PackageID = 3 AND p.Amount > 15
);

-- Query 50: Retrieve payments made on or before June 30, 2024, with amounts less than $20
SELECT * FROM Payments WHERE PaymentDate <= '2024-06-30' AND Amount < 20;
-- Naveed Section End