CREATE DATABASE Procedure2_

GO
USE Procedure2_

SELECT *
INTO Proizvodi
FROM Northwind.dbo.Products

SELECT * FROM Proizvodi

GO
CREATE PROCEDURE sp_Products_Insert 
(
	@ProductName VARCHAR(50),
	@SupplierID INT=NULL,
	@CategoryID INT=NULL,
	@QuantityPerUnit VARCHAR(50)=NULL,
	@UnitPrice MONEY=NULL,
	@UnitsInStock INT=NULL,
	@UnitsOnOrder INT=NULL,
	@ReorderLevel INT=NULL,
	@Discontinued BIT
)
AS BEGIN 
INSERT INTO
Proizvodi
VALUES (@ProductName, @SupplierID, @CategoryID, 
@QuantityPerUnit, @UnitPrice, @UnitsInStock, @UnitsOnOrder, 
@ReorderLevel, @Discontinued)
END 
GO

EXEC sp_Products_Insert 'Kafa', 1, 1, pedeset, 2.5, 5, 2, 1, 1

SELECT * FROM Proizvodi

EXEC sp_Products_Insert @ProductName='Pilav', @Discontinued = 0

GO
CREATE PROCEDURE sp_Products_Update 
(
	@ProductID INT,
	@ProductName VARCHAR(50),
	@SupplierID INT=NULL,
	@CategoryID INT=NULL,
	@QuantityPerUnit VARCHAR(50)=NULL,
	@UnitPrice MONEY=NULL,
	@UnitsInStock INT=NULL,
	@UnitsOnOrder INT=NULL,
	@ReorderLevel INT=NULL,
	@Discontinued BIT=NULL
) AS
BEGIN
UPDATE Proizvodi
SET
	ProductName=ISNULL(@ProductName, ProductName),
	SupplierID=ISNULL(@SupplierID, SupplierID),
	CategoryID=ISNULL(@CategoryID, CategoryID),
	QuantityPerUnit=ISNULL(@QuantityPerUnit, QuantityPerUnit),
	UnitPrice=ISNULL(@UnitPrice, UnitPrice),
	UnitsInStock=ISNULL(@UnitsInStock, UnitsInStock),
	UnitsOnOrder=ISNULL(@UnitsOnOrder, UnitsOnOrder),
	ReorderLevel=ISNULL(@ReorderLevel, ReorderLevel),
	Discontinued=ISNULL(@Discontinued, Discontinued)
	WHERE ProductID = @ProductID
END
GO

EXEC sp_Products_Update 2, 'Laptop'

GO
CREATE PROCEDURE sp_Products_Delete 
(
	@ProductID INT
)
AS
BEGIN
DELETE 
FROM Proizvodi
WHERE ProductID = @ProductID
END
GO

EXEC sp_Products_Delete 2

SELECT *
INTO StavkeNarudzbe
FROM Northwind.dbo.[Order Details]

SELECT * FROM StavkeNarudzbe

GO
CREATE PROCEDURE sp_OrderDetails_Products_InsertUpdate 
(
	@OrderID INT,
	@ProductID INT,
	@UnitPrice MONEY=NULL,
	@Quantity SMALLINT=NULL,
	@Discount SMALLINT=NULL
)
AS
BEGIN
INSERT INTO StavkeNarudzbe
VALUES (@OrderID, @ProductID, @UnitPrice, @Quantity, @Discount)

UPDATE Proizvodi
SET UnitsInStock=UnitsInStock-@Quantity
WHERE ProductID = @ProductID
END
GO

GO
CREATE PROCEDURE sp_Products_SelectByProductNameOrCategoryID 
(
	@ProductName VARCHAR(30)=NULL,
	@CategoryID INT=NULL
)
AS
BEGIN
SELECT *
FROM Proizvodi
WHERE (ProductName LIKE @ProductName OR @ProductName IS NULL) 
AND (CategoryID = @CategoryID OR @CategoryID IS NULL)
END
GO

EXEC sp_Products_SelectByProductNameOrCategoryID 'Chai'

GO
CREATE PROCEDURE sp_Products_SearchByProductName 
(
	@ProductName VARCHAR(40)=NULL
)
AS
BEGIN
SELECT * 
FROM Proizvodi
WHERE ProductName LIKE @ProductName + '%' OR @ProductName IS NULL
END
GO

GO
CREATE PROCEDURE sp_uposlenici_selectAll 
AS
BEGIN
SELECT PP.BusinessEntityID, PP.FirstName, PP.LastName, E.JobTitle
FROM AdventureWorks2017.Person.Person as PP
INNER JOIN AdventureWorks2017.HumanResources.Employee as E
ON PP.BusinessEntityID = E.BusinessEntityID
END
GO

EXEC sp_uposlenici_selectAll 

SELECT *
INTO Vendor
FROM AdventureWorks2017.Purchasing.Vendor

SELECT * FROM Vendor

GO
CREATE PROCEDURE sp_Vendor_deleteColumn 
AS
BEGIN
ALTER TABLE Vendor
DROP COLUMN PurchasingWebServiceURL
END
GO

EXEC sp_Vendor_deleteColumn