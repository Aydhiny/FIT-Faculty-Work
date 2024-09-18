CREATE DATABASE ISPIT_14_07_2023
GO
USE ISPIT_14_07_2023
CREATE TABLE Prodavaci
(
	ProdavacID INT CONSTRAINT PK_Prodavaci PRIMARY KEY IDENTITY(1,1),
	Ime VARCHAR(50) NOT NULL,
	Prezime VARCHAR(50) NOT NULL,
	OpisPosla VARCHAR(50) NOT NULL,
	EmailAdresa VARCHAR(50)
)
CREATE TABLE Proizvodi 
(
	ProizvodID INT CONSTRAINT PK_Proizvodi PRIMARY KEY IDENTITY(1,1),
	Naziv VARCHAR(50) NOT NULL,
	SifraProizvoda VARCHAR(25) NOT NULL,
	Boja VARCHAR(15) NOT NULL,
	NazivPodKategorije VARCHAR(50) NOT NULL
)
CREATE TABLE ZaglavljeNarudzbe 
(
	NarudzbaID INT CONSTRAINT PK_ZN PRIMARY KEY IDENTITY(1,1),
	DatumNarudzbe DATETIME NOT NULL,
	DatumIsporuke DATETIME,
	KreditnaKarticaID INT,
	ImeKupca VARCHAR(50) NOT NULL,
	PrezimeKupca VARCHAR(50) NOT NULL,
	NazivGradaIsporuke VARCHAR(30) NOT NULL,
	ProdavacID INT FOREIGN KEY REFERENCES Prodavaci(ProdavacID),
	NacinIsporuke VARCHAR(50) NOT NULL
)
CREATE TABLE DetaljiNarudzbe 
(
	DetaljiNarudzbeID INT CONSTRAINT PK_DN PRIMARY KEY IDENTITY(1,1),
	NarudzbaID INT NOT NULL CONSTRAINT FK_N_DETALJI FOREIGN KEY REFERENCES ZaglavljeNarudzbe(NarudzbaID),
	ProizvodID INT NOT NULL CONSTRAINT FK_P_DETALJI FOREIGN KEY REFERENCES Proizvodi(ProizvodID),
	Cijena MONEY NOT NULL,
	Kolicina SMALLINT NOT NULL,
	Popust MONEY NOT NULL,
	OpisSpecijalnePonude NVARCHAR(255) NOT NULL
)

SET IDENTITY_INSERT Prodavaci ON
INSERT INTO Prodavaci(ProdavacID, Ime, Prezime, OpisPosla, EmailAdresa)
SELECT SP.BusinessEntityID, PP.FirstName, PP.LastName, E.JobTitle, EA.EmailAddress
FROM AdventureWorks2017.Sales.SalesPerson AS SP
INNER JOIN AdventureWorks2017.Person.Person as PP
ON SP.BusinessEntityID = PP.BusinessEntityID
INNER JOIN AdventureWorks2017.HumanResources.Employee as E
ON PP.BusinessEntityID = E.BusinessEntityID
INNER JOIN AdventureWorks2017.Person.EmailAddress as EA
ON PP.BusinessEntityID = EA.BusinessEntityID
SET IDENTITY_INSERT Prodavaci OFF

SET IDENTITY_INSERT Proizvodi ON
INSERT INTO Proizvodi(ProizvodID, Naziv, SifraProizvoda, Boja, NazivPodKategorije)
SELECT P.ProductID, P.Name, P.ProductNumber, ISNULL(P.Color, 'Nema boje'), PSC.Name
FROM AdventureWorks2017.Production.Product as P
INNER JOIN AdventureWorks2017.Production.ProductSubcategory as PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
SET IDENTITY_INSERT Proizvodi OFF

SELECT * FROM Proizvodi

SET IDENTITY_INSERT ZaglavljeNarudzbe ON
INSERT INTO ZaglavljeNarudzbe(NarudzbaID, DatumNarudzbe, 
DatumIsporuke, KreditnaKarticaID, ImeKupca, PrezimeKupca, 
NazivGradaIsporuke, ProdavacID, NacinIsporuke)
SELECT SOH.SalesOrderID, SOH.OrderDate, SOH.ShipDate,
SOH.CreditCardID, PP.FirstName, PP.LastName, A.City, SOH.SalesPersonID, SM.Name
FROM AdventureWorks2017.Sales.SalesOrderHeader as SOH
INNER JOIN AdventureWorks2017.Sales.SalesPerson as SP
ON SOH.SalesPersonID = SP.BusinessEntityID
INNER JOIN AdventureWorks2017.Person.Person as PP
ON SP.BusinessEntityID = PP.BusinessEntityID
INNER JOIN AdventureWorks2017.Person.Address as A
ON SOH.ShipToAddressID = A.AddressID
INNER JOIN AdventureWorks2017.Purchasing.ShipMethod AS SM
ON SOH.ShipMethodID= SM.ShipMethodID
SET IDENTITY_INSERT ZaglavljeNarudzbe OFF

SELECT * FROM ZaglavljeNarudzbe

SET IDENTITY_INSERT DetaljiNarudzbe ON 
INSERT INTO DetaljiNarudzbe
SELECT SOD.SalesOrderID, SOD.ProductID, SOD.UnitPrice, SOD.OrderQty, SOD.UnitPriceDiscount, SO.Description
FROM AdventureWorks2017.Sales.SalesOrderDetail as SOD
INNER JOIN AdventureWorks2017.Sales.SpecialOffer as SO
ON SOD.SpecialOfferID = SO.SpecialOfferID
SET IDENTITY_INSERT DetaljiNarudzbe OFF

INSERT INTO DetaljiNarudzbe
SELECT SOD.SalesOrderID,SOD.ProductID,SOD.UnitPrice,SOD.OrderQty,SOD.UnitPriceDiscount,SO.Description
FROM AdventureWorks2017.Sales.SalesOrderDetail AS SOD 
INNER JOIN AdventureWorks2017.Sales.SpecialOfferProduct AS SP
ON SOD.SpecialOfferID=SP.SpecialOfferID AND SOD.ProductID=SP.ProductID
INNER JOIN AdventureWorks2017.Sales.SpecialOffer AS SO
ON SP.SpecialOfferID=SO.SpecialOfferID

INSERT INTO DetaljiNarudzbe(NarudzbaID, ProizvodID, Cijena, Kolicina, Popust, OpisSpecijalnePonude)
SELECT SOD.SalesOrderID, SOD.ProductID, SOD.UnitPrice, SOD.OrderQty, SOD.UnitPriceDiscount, SO.Description
FROM AdventureWorks2017.Sales.SalesOrderDetail AS SOD
INNER JOIN AdventureWorks2017.Sales.SpecialOffer AS SO
ON SOD.SpecialOfferID = SO.SpecialOfferID
-- Ensure SalesOrderID exists in ZaglavljeNarudzbe
INNER JOIN dbo.ZaglavljeNarudzbe AS ZN
ON SOD.SalesOrderID = ZN.NarudzbaID;

GO
CREATE FUNCTION f_detalji(@IDNarudzbe INT)
RETURNS TABLE
AS
RETURN
	SELECT
	FROM ZaglavljeNarudzbe
GO