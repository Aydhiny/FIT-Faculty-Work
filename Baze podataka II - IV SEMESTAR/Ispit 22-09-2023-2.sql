USE IB220088

CREATE TABLE Uposlenici 
(
	UposlenikID CHAR(9) CONSTRAINT PK_Uposlenik PRIMARY KEY,
	Ime VARCHAR(20) NOT NULL,
	Prezime VARCHAR(20) NOT NULL,
	DatumZaposlenja DATETIME NOT NULL,
	OpisPosla VARCHAR(50) NOT NULL
)

CREATE TABLE Naslovi 
(
	NaslovID VARCHAR(6) CONSTRAINT PK_Naslovi PRIMARY KEY,
	Naslov VARCHAR(70) NOT NULL,
	Tip CHAR(12) NOT NULL,
	Cijena MONEY,
	NazivIzdavaac VARCHAR(40),
	GradIzdavaca VARCHAR(20),
	DrzavaIzdavaca VARCHAR(30),
)
CREATE TABLE Prodavnice 
(
	ProdavnicaID CHAR(4)CONSTRAINT PK_Prodavnice PRIMARY KEY,
	NazivProdavnice VARCHAR(40),
	Grad VARCHAR(40)
)

CREATE TABLE Prodaja 
(
	ProdavnicaID CHAR(4) CONSTRAINT FK_Prodavnica 
	FOREIGN KEY REFERENCES Prodavnice(ProdavnicaID),
	BrojNarudzbe VARCHAR(20),
	NaslovID VARCHAR(6) CONSTRAINT FK_Naslov FOREIGN KEY REFERENCES
	Naslovi(NaslovID),
	DatumNarudzbe DATETIME NOT NULL,
	Kolicina SMALLINT NOT NULL
	CONSTRAINT PK_Prodaja PRIMARY KEY(ProdavnicaID, BrojNarudzbe, NaslovID)
)

INSERT INTO Uposlenici(UposlenikID, Ime, Prezime, DatumZaposlenja, OpisPosla)
SELECT E.emp_id, E.fname, E.lname, E.hire_date, J.job_desc
FROM pubs.dbo.employee as E
INNER JOIN pubs.dbo.jobs as J
ON E.job_id = J.job_id

INSERT INTO Naslovi(NaslovID, Naslov, Tip, Cijena,
NazivIzdavaac, GradIzdavaca, DrzavaIzdavaca)
SELECT T.title_id, T.title, T.type, T.price, P.pub_name, P.city, P.country
FROM pubs.dbo.titles as T
INNER JOIN pubs.dbo.publishers as P
ON T.pub_id = P.pub_id

INSERT INTO Prodaja
SELECT S.stor_id,S.ord_num,S.title_id,S.ord_date,S.qty
FROM pubs.dbo.sales AS S

INSERT INTO Prodavnice
SELECT S.stor_id,S.stor_name,S.city
FROM pubs.dbo.stores AS S

SELECT ProdavnicaID FROM Prodavnice;

GO
CREATE PROCEDURE sp_update_naslov 
(
	@NaslovID VARCHAR(6),
	@Naslov VARCHAR(70)=NULL,
	@Tip CHAR(12)=NULL,
	@Cijena MONEY=NULL,
	@NazivIzdavaac VARCHAR(40)=NULL,
	@GradIzdavaca VARCHAR(20)=NULL,
	@DrzavaIzdavaca VARCHAR(30)=NULL
)	
AS
BEGIN
UPDATE Naslovi 
SET Naslov=ISNULL(@Naslov, Naslov),
	Tip=ISNULL(@Tip, Tip),
	Cijena=ISNULL(@Cijena, Cijena),
	NazivIzdavaac=ISNULL(@NazivIzdavaac, NazivIzdavaac),
	GradIzdavaca=ISNULL(@GradIzdavaca, GradIzdavaca),
	DrzavaIzdavaca=ISNULL(@DrzavaIzdavaca, DrzavaIzdavaca)
WHERE NaslovID = @NaslovID
END
GO

SELECT * FROM
AdventureWorks2017.Production.ProductCategory

USE AdventureWorks2017
SELECT PC.Name ,SUM(SOD.OrderQty) as UkupnaProdana, 
SUM(SOD.OrderQty * SOD.UnitPrice) as UkupnaZaradaBezPopusta
FROM Sales.SalesOrderDetail as SOD
INNER JOIN Production.Product AS P
ON SOD.ProductID = P.ProductID
INNER JOIN Production.ProductSubcategory AS PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name NOT LIKE 'Bikes' AND P.Color IN ('Black', 'White')
GROUP BY PC.Name
HAVING SUM(SOD.OrderQty) < 20000
ORDER BY 3 DESC

USE AdventureWorks2017
SELECT PC.Name, SUM(SOD.OrderQty) 'Ukupna količina', SUM(SOD.UnitPrice*SOD.OrderQty) 'Ukupna zarada'
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Production.Product AS PP
ON SOD.ProductID=PP.ProductID
INNER JOIN Production.ProductSubcategory AS PS
ON PP.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PS.ProductCategoryID=PC.ProductCategoryID
WHERE PC.Name NOT LIKE 'Bikes' AND PP.Color IN ('Black', 'White')
GROUP BY PC.Name
HAVING SUM(SOD.OrderQty)<20000

USE AdventureWorks2017
SELECT P.FirstName + ' ' + 
P.LastName as ImePrezime, EA.EmailAddress, SOD.OrderQty, 
FORMAT(SOH.OrderDate, 'dd.MM.yy') as DatumNarudzbe
FROM Person.Person as P
INNER JOIN Person.EmailAddress as EA
ON P.BusinessEntityID = EA.BusinessEntityID
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN Production.Product as PP
ON SOD.ProductID = PP.ProductID
WHERE (MONTH(SOH.OrderDate) = 5 AND YEAR(SOH.OrderDate) IN (2014, 2013))
AND PP.Name = 'Front Brakes' AND SOD.OrderQty > 5

USE AdventureWorks2017
SELECT CONCAT(PP.FirstName,' ',PP.LastName) 'Ime i prezime', EA.EmailAddress, SOD.OrderQty 'Narucena kolicina', 
CONVERT(NVARCHAR,SOH.OrderDate,104) 'Datum narudzbe'
FROM Person.Person AS PP
INNER JOIN Sales.Customer AS C
ON PP.BusinessEntityID=C.PersonID --VAŽNO
INNER JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID=SOH.CustomerID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID=SOD.SalesOrderID
INNER JOIN Production.Product AS P
ON SOD.ProductID=P.ProductID
INNER JOIN Person.EmailAddress AS EA
ON PP.BusinessEntityID=EA.BusinessEntityID
WHERE MONTH(SOH.OrderDate)=5 AND P.Name='Front Brakes' AND SOD.OrderQty>5 AND  YEAR(SOH.OrderDate) IN(2014, 2013)

USE Northwind
SELECT TOP 1 S.CompanyName, SUM(OD.Quantity) as ProdatoProizvoda
FROM dbo.Suppliers as S
INNER JOIN dbo.Products as P
ON S.SupplierID = P.SupplierID
INNER JOIN dbo.Categories AS C
on P.CategoryID = C.CategoryID
INNER JOIN dbo.[Order Details] as OD
ON P.ProductID = OD.ProductID
INNER JOIN dbo.Orders as O
ON OD.OrderID = O.OrderID
WHERE C.CategoryName LIKE 'Sea%' AND O.ShippedDate IS NOT NULL AND OD.Discount > 0
GROUP BY S.CompanyName
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT SOH.SalesOrderID, 
P.FirstName + ' ' + P.LastName, CAST(SUM(SOD.LineTotal) AS decimal(18,2)) StvarnaUkupna
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.Customer as C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID, 
P.FirstName, P.LastName
HAVING SUM(SOD.OrderQty*SOD.UnitPrice*SOD.UnitPriceDiscount)>=2000
ORDER BY 3 DESC

USE IB220088
CREATE INDEX IX_Naslovi_Naslov
ON Naslovi(Naslov)

SELECT Naslov
FROM Naslovi AS N