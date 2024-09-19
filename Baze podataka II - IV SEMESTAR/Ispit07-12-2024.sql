CREATE DATABASE Ispit_07_12_2024

GO 
USE Ispit_07_12_2024

CREATE TABLE Uposlenici 
(
	UposlenikID INT PRIMARY KEY IDENTITY(1,1),
	Ime NVARCHAR(10) NOT NULL,
	Prezime NVARCHAR(20) NOT NULL,
	DatumRodjenja DATETIME NOT NULL,
	UkupanBrojTeritorija INT
)

CREATE TABLE Narudzbe
(
	NarudzbaID INT CONSTRAINT PK_Narudzbe PRIMARY KEY IDENTITY(1,1),
	UposlenikID INT CONSTRAINT FK_Uposlenik 
	FOREIGN KEY REFERENCES Uposlenici(UposlenikID),
	DatumNarudzbe DATETIME,
	ImeKompanijeKupca NVARCHAR(40),
	AdresaKupca NVARCHAR(60),
	UkupanBrojStavkiNarudzbe INT
)
CREATE TABLE Proizvodi 
(
	ProizvodID INT CONSTRAINT PK_Proizvodi PRIMARY KEY IDENTITY(1,1),
	NazivProizvoda NVARCHAR(40) NOT NULL,
	NazivKompanijeDobavljaca NVARCHAR(40),
	NazivKategorije NVARCHAR(15)
)
CREATE TABLE StavkeNarudzbe 
(
	NarudzbaID INT CONSTRAINT FK_StavkeNarudzbe FOREIGN KEY REFERENCES Narudzbe(NarudzbaID),
	ProizvodID INT CONSTRAINT FK_StavkeNarudzbe2 FOREIGN KEY REFERENCES Proizvodi(ProizvodID),
	Cijena MONEY NOT NULL,
	Kolicina SMALLINT NOT NULL,
	Popust REAL NOT NULL
	CONSTRAINT PK_SN PRIMARY KEY(NarudzbaID, ProizvodID)
)

SELECT * FROM
Northwind.dbo.Employees

SELECT * FROM Uposlenici

SET IDENTITY_INSERT Uposlenici ON
INSERT INTO Uposlenici(UposlenikID, Ime, Prezime, DatumRodjenja, UkupanBrojTeritorija)
SELECT E.EmployeeID, E.FirstName, E.LastName, 
E.BirthDate, COUNT(ET.TerritoryID)
FROM Northwind.dbo.Employees as E
INNER JOIN Northwind.dbo.EmployeeTerritories as ET
ON E.EmployeeID = ET.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName, 
E.BirthDate
SET IDENTITY_INSERT Uposlenici OFF

INSERT INTO Narudzbe(NarudzbaID, UposlenikID, DatumNarudzbe, UkupanBrojStavkiNarudzbe)
SELECT O.OrderID, O.OrderDate, COUNT(OD.OrderID)
FROM Northwind.dbo.Orders as O
INNER JOIN Northwind.dbo.[Order Details] as OD
ON O.OrderID = OD.OrderID

SET IDENTITY_INSERT Proizvodi ON
INSERT INTO Proizvodi(ProizvodID, NazivProizvoda, NazivKompanijeDobavljaca, NazivKategorije)
SELECT
	p.ProductID,
	p.ProductName,
	s.CompanyName,
	c.CategoryName
FROM Northwind.dbo.Products AS p
INNER JOIN Northwind.dbo.Suppliers AS s
ON p.SupplierID=s.SupplierID
INNER JOIN Northwind.dbo.Categories AS c
ON p.CategoryID=c.CategoryID
SET IDENTITY_INSERT Proizvodi OFF

SELECT * 
FROM
(
	SELECT TOP 5
		CONCAT(p.FirstName, ' ', p.LastName) ImePrezime,
		sod.SalesOrderID,
		COUNT(DISTINCT sod.ProductID) BrojRazlicitihProizvoda,
		SUM(sod.UnitPrice*(1-sod.UnitPriceDiscount)) CijenaSaPopustom
	FROM AdventureWorks2017.Sales.SalesOrderDetail AS sod
	INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS soh
	ON sod.SalesOrderID=soh.SalesOrderID
	INNER JOIN AdventureWorks2017.Sales.Customer AS c
	ON soh.CustomerID=c.CustomerID
	INNER JOIN AdventureWorks2017.Person.Person AS p
	ON c.PersonID=p.BusinessEntityID
	GROUP BY sod.SalesOrderID, CONCAT(p.FirstName, ' ', p.LastName)
	ORDER BY COUNT(DISTINCT sod.ProductID) DESC
) AS sq1
UNION
SELECT *
FROM
(
	SELECT TOP 5
		CONCAT(pp.FirstName, ' ', pp.LastName) ImePrezime,
		sod.SalesOrderID,
		COUNT(DISTINCT p.ProductSubcategoryID) BrojProizvodaSaRazlicitimPodkategorijama,
		SUM(sod.UnitPrice*(1-sod.UnitPriceDiscount)) CijenaSaPopustom
	FROM AdventureWorks2017.Sales.SalesOrderHeader AS soh
	INNER JOIN AdventureWorks2017.Sales.SalesOrderDetail AS sod
	ON soh.SalesOrderID=sod.SalesOrderID
	INNER JOIN AdventureWorks2017.Production.Product AS p
	ON sod.ProductID=p.ProductID
	INNER JOIN AdventureWorks2017.Sales.Customer AS c
	ON soh.CustomerID=c.CustomerID
	INNER JOIN AdventureWorks2017.Person.Person AS pp
	ON c.PersonID=pp.BusinessEntityID
	GROUP BY sod.SalesOrderID, CONCAT(pp.FirstName, ' ', pp.LastName)
	ORDER BY COUNT(DISTINCT sod.ProductID) DESC
) AS sq2


CREATE INDEX IX_Prizvod ON Proizvodi(NazivProizvoda)

SELECT NazivProizvoda
FROM Proizvodi
WHERE NazivProizvoda LIKE 'C%'

USE AdventureWorks2017
SELECT TOP 1 SOH.SalesOrderID, P.FirstName + ' ' + P.LastName 
as ImePrezime, A.City
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.Customer AS C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person as P
ON C.PersonID = P.BusinessEntityID
INNER JOIN Sales.SalesTerritory as ST
ON SOH.TerritoryID = ST.TerritoryID
INNER JOIN Person.Address as A
ON SOH.ShipToAddressID = A.AddressID
WHERE ST.[Group] = 'Europe' AND SOH.CreditCardID IS NOT NULL
ORDER BY SOH.TotalDue

SELECT TOP 1
	sod.SalesOrderID,
	CONCAT(p.FirstName, ' ', p.LastName) ImePrezime,
	a.City
FROM AdventureWorks2017.Person.Person AS p
INNER JOIN AdventureWorks2017.Sales.Customer AS c
ON p.BusinessEntityID=c.PersonID
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS sod
ON sod.CustomerID=c.CustomerID
INNER JOIN AdventureWorks2017.Sales.SalesTerritory AS st
ON sod.TerritoryID=st.TerritoryID
INNER JOIN AdventureWorks2017.Person.Address AS a
ON sod.ShipToAddressID=a.AddressID
WHERE sod.CreditCardID IS NOT NULL AND st.[Group] = 'Europe'
ORDER BY sod.TotalDue

-- 4 e
USE AdventureWorks2017
SELECT COUNT(*) AS UkupanBrojProizvoda, SOP.SpecialOfferID
FROM Production.Product AS P
INNER JOIN Sales.SpecialOfferProduct AS SOP
ON P.ProductID = SOP.ProductID
GROUP BY SOP.SpecialOffer