CREATE DATABASE AnalisisVentas;
GO

USE AnalisisVentas;
GO

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);
GO


CREATE TABLE OrderStatus (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName NVARCHAR(50) NOT NULL
);
GO


CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL,
    Phone NVARCHAR(50),
    City NVARCHAR(100),
    Country NVARCHAR(100)
);
GO


CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    Price DECIMAL(12,2) NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT NOT NULL,
    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
GO


CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerID INT NOT NULL,
    StatusID INT NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID),
    CONSTRAINT FK_Orders_OrderStatus
        FOREIGN KEY (StatusID)
        REFERENCES OrderStatus(StatusID)
);
GO


CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    TotalPrice DECIMAL(14,2) NOT NULL,
    CONSTRAINT FK_OrderDetails_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON DELETE CASCADE,
    CONSTRAINT FK_OrderDetails_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO
