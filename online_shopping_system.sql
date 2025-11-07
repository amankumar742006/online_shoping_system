-- Step 1: Create Database
CREATE DATABASE OnlineShoppingDB;
USE OnlineShoppingDB;

-- Step 2: Create Tables

-- Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    RegistrationDate DATE
);

-- Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

-- Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Order Details Table (for multiple products in one order)
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    SubTotal DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Step 3: Insert Sample Data

-- Customers
INSERT INTO Customers (CustomerName, Email, Phone, City, RegistrationDate) VALUES
('Aman Kumar', 'aman@gmail.com', '9876543210', 'Delhi', '2024-03-15'),
('Riya Sharma', 'riya@gmail.com', '9898989898', 'Mumbai', '2024-04-10'),
('Rohit Verma', 'rohit@gmail.com', '9123456789', 'Chennai', '2024-05-22');

-- Products
INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Wireless Mouse', 'Electronics', 599.00, 100),
('Bluetooth Headphones', 'Electronics', 1599.00, 50),
('Running Shoes', 'Footwear', 2499.00, 30),
('Smartwatch', 'Electronics', 3499.00, 40),
('Backpack', 'Accessories', 899.00, 60);

-- Orders
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-06-01', 2198.00),
(2, '2024-06-05', 3499.00),
(3, '2024-06-07', 899.00);

-- Order Details
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, SubTotal) VALUES
(1, 1, 2, 1198.00),
(1, 2, 1, 1599.00),
(2, 4, 1, 3499.00),
(3, 5, 1, 899.00);

-- Step 4: Useful Queries (for Analysis)

-- 1. View all orders with customer names
SELECT o.OrderID, c.CustomerName, o.OrderDate, o.TotalAmount
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID;

-- 2. Find total sales by product category
SELECT p.Category, SUM(od.SubTotal) AS TotalSales
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.Category;

-- 3. List top 3 customers by total spending
SELECT c.CustomerName, SUM(o.TotalAmount) AS TotalSpent
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalSpent DESC
LIMIT 3;

-- 4. Show products with low stock (less than 40)
SELECT ProductName, Stock
FROM Products
WHERE Stock < 40;

-- 5. Count total number of customers from each city
SELECT City, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY City;

-- 6. Total revenue generated
SELECT SUM(TotalAmount) AS TotalRevenue FROM Orders;
