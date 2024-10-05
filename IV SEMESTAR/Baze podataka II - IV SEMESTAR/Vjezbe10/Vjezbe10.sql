CREATE DATABASE Procedure_
GO 
USE Procedure_

SELECT *
INTO Proizvodi
FROM Northwind.dbo.Products

SELECT * FROM Proizvodi

GO
CREATE PROCEDURE sp_Proizvodi_Insert 
(
	@ProductName NVARCHAR(40),
	@SupplierID INT=NULL,
	@CategoryID INT=NULL,
	@QuantityPerUnit NVARCHAR(20) = NULL,
	@UnitPrice MONEY=NULL,
	@UnitsInStock SMALLINT= NULL,
	@UnitsOnOrder SMALLINT= NULL,
	@ReorderLevel SMALLINT= NULL,
	@Discontinued BIT
) AS 
BEGIN
INSERT INTO Proizvodi
	VALUES(@ProductName,@SupplierID,@CategoryID,@QuantityPerUnit,@UnitPrice,@UnitsInStock,@UnitsOnOrder,@ReorderLevel,@Discontinued)
END
GO

EXEC sp_Proizvodi_Insert 'Mlijeko', 1, 1, 2, 1.4, 30, 0, 1, 1

EXEC sp_Proizvodi_Insert
  @ProductName='Brašno',
  @Discontinued=1

GO
CREATE PROCEDURE sp_Products_Update 
(
	@ProductID INT,
	@ProductName NVARCHAR(40),
	@SupplierID INT=NULL,
	@CategoryID INT=NULL,
	@QuantityPerUnit NVARCHAR(20) = NULL,
	@UnitPrice MONEY=NULL,
	@UnitsInStock SMALLINT= NULL,
	@UnitsOnOrder SMALLINT= NULL,
	@ReorderLevel SMALLINT= NULL,
	@Discontinued BIT=NULL
)
AS
BEGIN
UPDATE Proizvodi
SET
	ProductName=ISNULL(@ProductName, ProductName),
	SupplierID=ISNULL(@SupplierID, SupplierID),
	CategoryID=ISNULL(@CategoryID, CategoryID),
	QuantityPerUnit=ISNULL(@QuantityPerUnit, QuantityPerUnit),
	UnitPrice=ISNULL(@UnitPrice, UnitPrice),
	UnitsInStock=ISNULL(@UnitsInStock,UnitsInStock),
	UnitsOnOrder=ISNULL(@UnitsOnOrder,UnitsOnOrder),
	ReorderLevel=ISNULL(@ReorderLevel,ReorderLevel),
	Discontinued=ISNULL(@Discontinued,Discontinued) 
WHERE ProductID = @ProductID
END

EXEC sp_Products_Update @ProductID=80, @ProductName='Sok', @SupplierID=1

SELECT * FROM Proizvodi

/* Zadatak .7 */

GO
CREATE PROCEDURE sp_Products_Delete 
(
	@ProductID int
)
AS BEGIN
DELETE 
FROM Proizvodi
WHERE ProductID = @ProductID
END

EXEC sp_Products_Delete @ProductID=79

SELECT * FROM Proizvodi

/* --------------------- */

SELECT *
INTO StavkeNarudzbe
FROM Northwind.dbo.[Order Details]

SELECT * FROM StavkeNarudzbe

GO
CREATE PROCEDURE sp_OrderDetails_Products_InsertUpdate 
(
	@OrderID INT,
	@ProductID INT,
	@UnitPrice FLOAT,
	@Quantity INT,
	@Discount FLOAT
)
AS 
BEGIN
INSERT INTO StavkeNarudzbe 
VALUES(@OrderID, @ProductID, @UnitPrice, @Quantity,@Discount)
UPDATE Proizvodi
SET UnitsInStock=UnitsInStock-@Quantity
WHERE ProductID=@ProductID
END

EXEC sp_OrderDetails_Products_InsertUpdate 10248, 1, 5, 4 ,0.1