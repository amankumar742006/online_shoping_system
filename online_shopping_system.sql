CREATE DATABASE OnlineShopping;

USE OnlineShopping;

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address VARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerName, Email, Phone, Address)
VALUES
('Aman Kumar', 'aman@example.com', '9876543210', 'Delhi'),
('Riya Sharma', 'riya@example.com', '9988776655', 'Mumbai');

INSERT INTO Products (ProductName, Category, Price, Stock)
VALUES
('Laptop', 'Electronics', 55000.00, 10),
('Headphones', 'Accessories', 1500.00, 25),
('Smartphone', 'Electronics', 32000.00, 15);

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount)
VALUES
(1, '2025-11-06', 56500.00),
(2, '2025-11-06', 33500.00);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity)
VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1);
