CREATE DATABASE IB220088

GO 
USE IB220088

CREATE TABLE Proizvodi 
(
	ProizvodID INT CONSTRAINT PK_Proizvodi PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL,
	SifraProizvoda NVARCHAR(25) NOT NULL,
	Boja NVARCHAR(15),
	NazivKategorije NVARCHAR(50) NOT NULL,
	Tezina DECIMAL(18,2)
)

CREATE TABLE ZaglavljeNarudzbe 
(
	NarudzbaID INT CONSTRAINT PK_ZN PRIMARY KEY IDENTITY(1,1),
	DatumNarudzbe DATETIME NOT NULL,
	DatumIsporuke DATETIME,
	ImeKupca NVARCHAR(50) NOT NULL,
	PrezimeKupca NVARCHAR(50) NOT NULL,
	NazivTeritorije NVARCHAR(50) NOT NULL,
	NazivRegije NVARCHAR(50) NOT NULL,
	NacinIsporuke NVARCHAR(50) NOT NULL
)
CREATE TABLE DetaljiNarudzbe 
(
	DetaljiNarudzbeID INT CONSTRAINT PK_DNarudzbe PRIMARY KEY IDENTITY(1,1),
	NarudzbaID INT NOT NULL CONSTRAINT FK_Narudzba FOREIGN KEY REFERENCES ZaglavljeNarudzbe(NarudzbaID),
	ProizvodID INT NOT NULL CONSTRAINT FK_Proizvodi FOREIGN KEY REFERENCES Proizvodi(ProizvodID),
	Cijena MONEY NOT NULL,
	Kolicina SMALLINT NOT NULL,
	Popust MONEY NOT NULL
)
 

SET IDENTITY_INSERT Proizvodi ON
INSERT INTO 
Proizvodi(ProizvodID, Naziv, SifraProizvoda, Boja, 
NazivKategorije, Tezina)
SELECT P.ProductID, P.[Name], P.ProductNumber, P.Color, PC.[Name],
P.[Weight]
FROM AdventureWorks2017.Production.[Product] as P
INNER JOIN AdventureWorks2017.Production.ProductSubcategory as PCS
ON P.ProductSubcategoryID = PCS.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory as PC
ON PCS.ProductCategoryID = PC.ProductCategoryID
SET IDENTITY_INSERT Proizvodi OFF

SELECT * FROM Proizvodi 

UPDATE Proizvodi
SET Tezina = 0
WHERE Tezina IS NULL;


SET IDENTITY_INSERT ZaglavljeNarudzbe ON
INSERT INTO ZaglavljeNarudzbe(NarudzbaID, 
DatumNarudzbe, DatumIsporuke, ImeKupca, 
PrezimeKupca, NazivTeritorije, NazivRegije, NacinIsporuke)
SELECT SOH.SalesOrderID, SOH.OrderDate, SOH.ShipDate,
PP.FirstName, PP.LastName, ST.[Name], ST.[Group], SM.[Name]
FROM AdventureWorks2017.Sales.SalesOrderHeader as SOH
INNER JOIN AdventureWorks2017.Sales.Customer as C
ON SOH.CustomerID = C.CustomerID
INNER JOIN AdventureWorks2017.Person.Person as PP
ON C.PersonID = PP.BusinessEntityID
INNER JOIN AdventureWorks2017.Sales.SalesTerritory as ST
ON SOH.TerritoryID = ST.TerritoryID
INNER JOIN AdventureWorks2017.Purchasing.ShipMethod as SM
ON SOH.ShipMethodID = SM.ShipMethodID
SET IDENTITY_INSERT ZaglavljeNarudzbe OFF

SELECT * FROM ZaglavljeNarudzbe

SET IDENTITY_INSERT DetaljiNarudzbe ON

INSERT INTO DetaljiNarudzbe(NarudzbaID, ProizvodID, Cijena, 
Kolicina, Popust)
SELECT SOD.SalesOrderID, SOD.ProductID, SOD.UnitPrice, SOD.OrderQty, SOD.UnitPriceDiscount
FROM AdventureWorks2017.Sales.SalesOrderDetail as SOD
SET IDENTITY_INSERT DetaljiNarudzbe ON

SELECT * FROM DetaljiNarudzbe

SELECT D.[Name],COUNT(*) AS BrojUposlenika
FROM AdventureWorks2017.HumanResources.Employee as E
INNER JOIN AdventureWorks2017.HumanResources.EmployeeDepartmentHistory as EDH
ON E.BusinessEntityID = EDH.BusinessEntityID
INNER JOIN AdventureWorks2017.HumanResources.Department as D
ON EDH.DepartmentID = D.DepartmentID
WHERE EDH.EndDate IS NULL AND (YEAR(GETDATE()) - YEAR(E.HireDate)) > 10
GROUP BY D.[Name]
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT D.Name, COUNT(*) 'Broj uposlenika'
FROM HumanResources.Employee AS E
INNER JOIN HumanResources.EmployeeDepartmentHistory AS EDH
ON E.BusinessEntityID=EDH.BusinessEntityID
INNER JOIN HumanResources.Department AS D
ON EDH.DepartmentID=D.DepartmentID
WHERE EDH.EndDate IS NULL AND DATEDIFF(YEAR, E.BirthDate, GETDATE())>10
GROUP BY D.Name
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT MONTH(POH.OrderDate) as Mjesec, 
SUM(POD.LineTotal) as UkupnaVrijednost, SUM(POD.ReceivedQty) as 
DobivenaKolicina, SUM(IIF(POD.RejectedQty>100,1,0)) as OdbijeneNarudzbe
FROM Purchasing.PurchaseOrderHeader as POH
INNER JOIN Purchasing.PurchaseOrderDetail as POD
ON POH.PurchaseOrderID = POD.PurchaseOrderID
INNER JOIN Purchasing.ShipMethod as SM
ON POH.ShipMethodID = SM.ShipMethodID
WHERE YEAR(POH.OrderDate) = 2012 AND (POH.Freight BETWEEN 500 AND 2500)
AND SM.[Name] LIKE 'Cargo%'
GROUP BY MONTH(POH.OrderDate)

SELECT MONTH(POH.OrderDate) 'Mjesec', SUM(POD.LineTotal) 'Ukupno poručene robe', SUM(POD.ReceivedQty) 'Ukupno primljene robe',
SUM(IIF(POD.RejectedQty>100,1,0)) 'Broj stavki sa odbijenom količinom većom od 100'
FROM Purchasing.PurchaseOrderHeader AS POH
INNER JOIN Purchasing.PurchaseOrderDetail AS POD
ON POH.PurchaseOrderID=POD.PurchaseOrderID
INNER JOIN Purchasing.ShipMethod AS SM
ON POH.ShipMethodID=SM.ShipMethodID
WHERE YEAR(POH.OrderDate) = 2012 AND POH.Freight 
BETWEEN 500 AND 2500 AND SM.Name LIKE 'CARGO%'
GROUP BY MONTH(POH.OrderDate)

USE AdventureWorks2017
SELECT PP.FirstName, PP.LastName, COUNT(*) as BrojNarudzbi
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.SalesPerson AS SP
ON SOH.SalesPersonID = SP.BusinessEntityID
INNER JOIN Person.Person AS PP 
ON SP.BusinessEntityID = PP.BusinessEntityID
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE YEAR(SOH.OrderDate) IN (2011, 2012) AND 
(
	SELECT COUNT(*)
	FROM Sales.SalesOrderDetail as SOD
	WHERE SOD.SalesOrderID = SOH.SalesOrderID AND SOD.UnitPriceDiscount > 0
) >= 2
AND ST.[Name] IN('United Kingdom', 'France', 'Canada')
GROUP BY PP.FirstName, PP.LastName

SELECT PP.FirstName, PP.LastName, COUNT(*) 'Ukupan broj narudžbi'
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesPerson AS SP
ON SOH.SalesPersonID=SP.BusinessEntityID
INNER JOIN Person.Person AS PP
ON SP.BusinessEntityID=PP.BusinessEntityID
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID=ST.TerritoryID
WHERE YEAR(SOH.OrderDate) IN (2011, 2012) AND ST.Name IN ('United Kingdom', 'Canada', 'France') AND
(
	SELECT COUNT(*)
	FROM Sales.SalesOrderDetail AS SOD
	WHERE SOD.SalesOrderID=SOH.SalesOrderID AND SOD.UnitPriceDiscount>0
) >=2
GROUP BY PP.FirstName, PP.LastName


SELECT P.ProductName, S.CompanyName, P.UnitsInStock, 
LEFT(P.ProductName, 2) + '/' + LEFT(SUBSTRING(S.CompanyName, 
CHARINDEX(' ', S.CompanyName) + 1, 
LEN(S.CompanyName)),2) + IIF(P.ProductID >9,REVERSE(P.ProductID),'a') as Lozinka
FROM Northwind.dbo.Products as P
INNER JOIN Northwind.dbo.Suppliers as S
ON P.SupplierID = S.SupplierID

USE Northwind
SELECT P.ProductName, S.CompanyName, P.UnitsInStock,
LEFT(P.ProductName,2) + '/' + SUBSTRING(S.CompanyName,CHARINDEX(' ', S.CompanyName)+1,2) + 
IIF(LEN(P.ProductID)=1, CAST(P.ProductID AS NVARCHAR) +'a', P.ProductID ) 'Šifra'
FROM Products AS P
INNER JOIN Suppliers AS S
ON P.SupplierID=S.SupplierID
WHERE LEN(S.CompanyName)-LEN(REPLACE(S.CompanyName, ' ','')) IN(1,2)


CREATE INDEX IX_Proizvodi_Sifra_Naziv
ON Proizvodi(SifraProizvoda, Naziv)

USE IB220088

GO
CREATE PROCEDURE sp_search_products 
(
	@Kategorija VARCHAR(60)=NULL,
	@Tezina DECIMAL(18,2)=NULL
)
AS 
BEGIN
SELECT *
FROM Proizvodi as P
WHERE P.NazivKategorije = @Kategorija + '%' OR P.Tezina > @Tezina
END
GO

