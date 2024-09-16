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