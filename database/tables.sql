CREATE DATABASE SistemaAnalisisDeVentas; 

USE SistemaAnalisisDeVentas; 
GO

CREATE TABLE Country(
    CountryID INT IDENTITY(1,1) PRIMARY KEY,
    CountryName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE City(
    CityID INT IDENTITY(1,1) PRIMARY KEY,
    CityName VARCHAR(100) NOT NULL,
    CountryID INT NOT NULL,

    CONSTRAINT FK_City_Country
    FOREIGN KEY (CountryID)
    REFERENCES Country(CountryID)
);

CREATE TABLE Category(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Product(
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(150) NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    Stock INT NOT NULL CHECK (Stock >= 0),
    CategoryID INT NOT NULL,

    CONSTRAINT FK_Product_Category
    FOREIGN KEY (CategoryID)
    REFERENCES Category(CategoryID)
);

CREATE TABLE Customer(
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(50),
    CityID INT NOT NULL,

    CONSTRAINT FK_Customer_City
    FOREIGN KEY (CityID)
    REFERENCES City(CityID)
);

CREATE TABLE OrderStatus(
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE [Order](
    OrderID INT PRIMARY KEY,
    OrderDate DATE NOT NULL,
    StatusID INT NOT NULL,
    CustomerID INT NOT NULL,

    CONSTRAINT FK_Order_Status
    FOREIGN KEY (StatusID)
    REFERENCES OrderStatus(StatusID),

    CONSTRAINT FK_Order_Customer
    FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
);

CREATE TABLE OrderDetail(
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL CHECK (UnitPrice >= 0),
    TotalPrice DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_OrderDetail
    PRIMARY KEY (OrderID, ProductID),

    CONSTRAINT FK_OrderDetail_Order
    FOREIGN KEY (OrderID)
    REFERENCES [Order](OrderID),

    CONSTRAINT FK_OrderDetail_Product
    FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);
