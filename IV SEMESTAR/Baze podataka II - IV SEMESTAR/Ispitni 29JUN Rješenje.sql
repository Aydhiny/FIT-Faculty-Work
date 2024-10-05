--29.06.2022.
--BAZE PODATAKA II – ISPIT
--***Prilikom izrade zadataka, OBAVEZNO iznad svakog zadatka napisati redni broj zadatka npr (4c). Zadaci 
--koji ne budu označeni na prethodno definisan način neće biti evaluirani.
--1. Kroz SQL kod kreirati bazu podataka sa imenom vašeg broja indeksa.
CREATE DATABASE IspitTest
GO
USE IspitTest
--2. U kreiranoj bazi podataka kreirati tabele sa sljedećom strukturom:
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
	NarudzbaID INT CONSTRAINT PK_ZaglavljeNarudzbe PRIMARY KEY IDENTITY(1,1),
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
	DetaljiNarudzbe INT CONSTRAINT PK_DetaljiNarudzbe PRIMARY KEY IDENTITY(1,1),
	NarudzbaID INT NOT NULL CONSTRAINT FK_DetaljiNarudzbe_ZaglavljeNarudzbe FOREIGN KEY REFERENCES ZaglavljeNarudzbe(NarudzbaID),
	ProizvodID INT NOT NULL CONSTRAINT FK_DetaljiNarudzbe_Proizvodi FOREIGN KEY REFERENCES Proizvodi(ProizvodID),
	Cijena MONEY NOT NULL,
	Kolicina SMALLINT NOT NULL,
	Popust MONEY NOT NULL
--**Jedan proizvod se može više puta naručiti, dok jedna narudžba može sadržavati više proizvoda. U okviru jedne 
--narudžbe jedan proizvod se može naručiti više puta.
)

--7 bodova
--3. Iz baze podataka AdventureWorks u svoju bazu podataka prebaciti sljedeće podatke:
--a) U tabelu Proizvodi dodati sve proizvode, na mjestima gdje nema pohranjenih podataka o težini
--zamijeniti vrijednost sa 0
--• ProductID -> ProizvodID
--• Name -> Naziv
--• ProductNumber -> SifraProizvoda
--• Color -> Boja 
--• Name (ProductCategory) -> NazivKategorije
--• Weight -> Tezina
SET IDENTITY_INSERT Proizvodi ON
INSERT INTO Proizvodi (ProizvodID, Naziv, SifraProizvoda, Boja, NazivKategorije, Tezina)
SELECT PP.ProductID, PP.Name, PP.ProductNumber, PP.Color, PC.Name, ISNULL(PP.Weight, 0)
FROM AdventureWorks2017.Production.Product AS PP
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS PS
ON PP.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory AS PC
ON PS.ProductCategoryID=PC.ProductCategoryID
SET IDENTITY_INSERT Proizvodi OFF

SET IDENTITY_INSERT ZaglavljeNarudzbe ON
INSERT INTO ZaglavljeNarudzbe (NarudzbaID, DatumNarudzbe, DatumIsporuke, ImeKupca, PrezimeKupca, NazivTeritorije, NazivRegije, NacinIsporuke)
SELECT SOH.SalesOrderID, SOH.OrderDate, SOH.ShipDate, PP.FirstName, PP.LastName, ST.Name, ST.[Group], SM.Name
FROM AdventureWorks2017.Sales.SalesOrderHeader AS SOH
INNER JOIN AdventureWorks2017.Sales.Customer AS C
ON SOH.CustomerID=C.CustomerID
INNER JOIN AdventureWorks2017.Person.Person AS PP
ON C.PersonID=PP.BusinessEntityID
INNER JOIN AdventureWorks2017.Purchasing.ShipMethod AS SM
ON SOH.ShipMethodID=SM.ShipMethodID
INNER JOIN AdventureWorks2017.Sales.SalesTerritory AS ST
ON SOH.TerritoryID=ST.TerritoryID
SET IDENTITY_INSERT ZaglavljeNarudzbe OFF
--• SalesOrderID -> NarudzbaID
--• OrderDate -> DatumNarudzbe
--• ShipDate -> DatumIsporuke
--• FirstName (Person) -> ImeKupca
--• LastName (Person) -> PrezimeKupca
--• Name (SalesTerritory) -> NazivTeritorije
--• Group (SalesTerritory) -> NazivRegije
--• Name (ShipMethod) -> NacinIsporuke

--c) U tabelu DetaljiNarudzbe dodati sve stavke narudžbe
--• SalesOrderID -> NarudzbaID
--• ProductID -> ProizvodID
--• UnitPrice -> Cijena
--• OrderQty -> Kolicina
--• UnitPriceDiscount -> Popust
INSERT INTO DetaljiNarudzbe
SELECT SOD.SalesOrderID, SOD.ProductID, SOD.UnitPrice, SOD.OrderQty, SOD.UnitPriceDiscount
FROM AdventureWorks2017.Sales.SalesOrderDetail AS SOD

--8 bodova
--4.
--a) (6 bodova) Kreirati upit koji će prikazati ukupan broj uposlenika po odjelima. Potrebno je prebrojati 
--samo one uposlenike koji su trenutno aktivni, odnosno rade na datom odjelu. Također, samo uzeti u obzir 
--one uposlenike koji imaju više od 10 godina radnog staža (ne uključujući graničnu vrijednost). Rezultate 
--sortirati preba broju uposlenika u opadajućem redoslijedu. (AdventureWorks2017)
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

--b) (10 bodova) Kreirati upit koji prikazuje po mjesecima ukupnu vrijednost poručene robe za skladište, te 
--ukupnu količinu primljene robe, isključivo u 2012 godini. Uslov je da su troškovi prevoza bili između 
--500 i 2500, a da je dostava izvršena CARGO transportom. Također u rezultatima upita je potrebno 
--prebrojati stavke narudžbe na kojima je odbijena količina veća od 100. (AdventureWorks2017)
--1 NAČIN
SELECT MONTH(POH.OrderDate) 'Mjesec', SUM(POD.LineTotal) 'Ukupno poručene robe', SUM(POD.ReceivedQty) 'Ukupno primljene robe',
SUM(IIF(POD.RejectedQty>100,1,0)) 'Broj stavki sa odbijenom količinom većom od 100'
FROM Purchasing.PurchaseOrderHeader AS POH
INNER JOIN Purchasing.PurchaseOrderDetail AS POD
ON POH.PurchaseOrderID=POD.PurchaseOrderID
INNER JOIN Purchasing.ShipMethod AS SM
ON POH.ShipMethodID=SM.ShipMethodID
WHERE YEAR(POH.OrderDate) = 2012 AND POH.Freight BETWEEN 500 AND 2500 AND SM.Name LIKE 'CARGO%'
GROUP BY MONTH(POH.OrderDate)

--2 NAČIN
  SELECT MONTH(POH.OrderDate) 'Mjesec', SUM(POD.LineTotal), SUM(POD.ReceivedQty),
  (SELECT COUNT(*)
   FROM Purchasing.PurchaseOrderHeader AS POH1
   INNER JOIN Purchasing.PurchaseOrderDetail AS POD1
   ON POH1.PurchaseOrderID=POD1.PurchaseOrderID
   INNER JOIN Purchasing.ShipMethod AS SM1
   ON POH1.ShipMethodID=SM1.ShipMethodID
   WHERE MONTH(POH.OrderDate)=MONTH(POH1.OrderDate) AND POD1.RejectedQty>100 AND 
   YEAR(POH1.OrderDate)=2012 AND POH1.Freight BETWEEN 500 AND 2500 AND SM1.Name LIKE '%CARGO%'
  ) 'Broj stavki sa odbijenom količinom većom od 100'
  FROM Purchasing.PurchaseOrderHeader AS POH
  INNER JOIN Purchasing.PurchaseOrderDetail AS POD
  ON POH.PurchaseOrderID=POD.PurchaseOrderID
  INNER JOIN Purchasing.ShipMethod AS SM
  ON POH.ShipMethodID=SM.ShipMethodID
  WHERE YEAR(POH.OrderDate)=2012 AND POH.Freight BETWEEN 500 AND 2500 AND SM.Name LIKE '%CARGO%'
  GROUP BY MONTH(POH.OrderDate)

--PROVJERA ZA JANUAR
SELECT POD.PurchaseOrderDetailID, MONTH(POH.OrderDate) 'Mjesec', POD.RejectedQty, POD.ReceivedQty, POD.LineTotal
FROM Purchasing.PurchaseOrderHeader AS POH
INNER JOIN Purchasing.PurchaseOrderDetail AS POD
ON POH.PurchaseOrderID=POD.PurchaseOrderID
INNER JOIN Purchasing.ShipMethod AS SM
ON POH.ShipMethodID=SM.ShipMethodID
WHERE YEAR(POH.OrderDate) = 2012 AND POH.Freight BETWEEN 500 AND 2500 AND SM.Name LIKE 'CARGO%' AND MONTH(POH.OrderDate)=1


--c) (10 bodova) Prikazati ukupan broj narudžbi koje su obradili uposlenici, za svakog uposlenika 
--pojedinačno. Uslov je da su narudžbe kreirane u 2011 ili 2012 godini, te da je u okviru jedne narudžbe 
--odobren popust na dvije ili više stavki. Također uzeti u obzir samo one narudžbe koje su isporučene u 
--Veliku Britaniju, Kanadu ili Francusku. (AdventureWorks2017)
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

--PROVJERA
SELECT PP.FirstName, PP.LastName, SOH.SalesOrderID
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesPerson AS SP
ON SOH.SalesPersonID=SP.BusinessEntityID
INNER JOIN Person.Person AS PP
ON SP.BusinessEntityID=PP.BusinessEntityID
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID=ST.TerritoryID
WHERE YEAR(SOH.OrderDate) IN (2011, 2012) AND ST.Name IN ('United Kingdom', 'Canada', 'France') 
AND
(
	SELECT COUNT(*)
	FROM Sales.SalesOrderDetail AS SOD
	WHERE SOD.SalesOrderID=SOH.SalesOrderID AND SOD.UnitPriceDiscount>0
) >=2 
AND PP.LastName LIKE 'Saraiva'
--DRUGI DIO PROVJERE
SELECT SOH.SalesOrderID, SOD.UnitPriceDiscount
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID=SOD.SalesOrderID
WHERE SOH.SalesOrderID=46330

--46330
--46332
--46669
--47006
--47451
--47721

--d) (11 bodova) Napisati upit koji će prikazati sljedeće podatke o proizvodima: naziv proizvoda, naziv 
--kompanije dobavljača, količinu na skladištu, te kreiranu šifru proizvoda. Šifra se sastoji od sljedećih 
--vrijednosti: (Northwind)
--1) Prva dva slova naziva proizvoda
--2) Karakter /
--3) Prva dva slova druge riječi naziva kompanije dobavljača, uzeti u obzir one kompanije koje u 
--nazivu imaju 2 ili 3 riječi
--4) ID proizvoda, po pravilu ukoliko se radi o jednocifrenom broju na njega dodati slovo 'a', u 
--suprotnom uzeti obrnutu vrijednost broja
--Npr. Za proizvod sa nazivom Chai i sa dobavljačem naziva Exotic Liquids, šifra će btiti Ch/Li1a.
USE Northwind
SELECT P.ProductName, S.CompanyName, P.UnitsInStock,
LEFT(P.ProductName,2) + '/' + SUBSTRING(S.CompanyName,CHARINDEX(' ', S.CompanyName)+1,2) + 
IIF(LEN(P.ProductID)=1, CAST(P.ProductID AS NVARCHAR) +'a', P.ProductID ) 'Šifra'
FROM Products AS P
INNER JOIN Suppliers AS S
ON P.SupplierID=S.SupplierID
WHERE LEN(S.CompanyName)-LEN(REPLACE(S.CompanyName, ' ','')) IN(1,2)

--37 bodova
--5.
--a) (3 boda) U kreiranoj bazi kreirati index kojim će se ubrzati pretraga prema šifri i nazivu proizvoda.
--Napisati upit za potpuno iskorištenje indexa.
CREATE INDEX IX_Proizvodi_Sifra_Naziv
ON Proizvodi(SifraProizvoda, Naziv)
--b) (7 bodova) U kreiranoj bazi kreirati proceduru sp_search_products kojom će se vratiti podaci o 
--proizvodima na osnovu kategorije kojoj pripadaju ili težini. Korisnici ne moraju unijeti niti jedan od 
--parametara ali u tom slučaju procedura ne vraća niti jedan od zapisa. Korisnicima unosom već prvog 
--slova kategorije se trebaju osvježiti zapisi, a vrijednost unesenog parametra težina će vratiti one 
--proizvode čija težina je veća od unesene vrijednosti.
GO
CREATE PROCEDURE sp_search_products
(
	@Kategorija NVARCHAR(50)=NULL,
	@Tezina DECIMAL(18,2)=NULL
)
AS
BEGIN
	SELECT *
	FROM Proizvodi AS P
	WHERE P.NazivKategorije LIKE @Kategorija+'%' OR P.Tezina>@Tezina
END

EXEC sp_search_products @Kategorija='B'
EXEC sp_search_products 
GO
--c) (18 bodova) Zbog proglašenja dobitnika nagradne igre održane u prva dva mjeseca drugog kvartala 2013 
--godine potrebno je kreirati upit. Upitom će se prikazati treća najveća narudžba (vrijednost bez popusta)
--za svaki mjesec pojedinačno. Obzirom da je u pravilima nagradne igre potrebno nagraditi 2 osobe 
--(muškarca i ženu) za svaki mjesec, potrebno je u rezultatima upita prikazati pored navedenih stavki i o 
--kojem se kupcu radi odnosno ime i prezime, te koju je nagradu osvojio. Nagrade se dodjeljuju po 
--sljedećem pravilu:
--• za žene u prvom mjesecu drugog kvartala je stoni mikser, dok je za muškarce usisivač
--• za žene u drugom mjesecu drugog kvartala je pegla, dok je za muškarc multicooker
--Obzirom da za kupce nije eksplicitno naveden spol, određivat će se po pravilu: Ako je zadnje slovo imena 
--a, smatra se da je osoba ženskog spola u suprotnom radi se o osobi muškog spola. Rezultate u formiranoj 
--tabeli dobitnika sortirati prema vrijednosti narudžbe u opadajućem redoslijedu. (AdventureWorks2017)
USE AdventureWorks2017
SELECT PODQ.Mjesec, PODQ.FirstName, PODQ.LastName, PODQ.[Ukupna vrijednost], PODQ.Nagrada
FROM(SELECT MONTH(SOH.OrderDate) 'Mjesec', PP.FirstName, PP.LastName, 
	 SUM(SOD.OrderQty*SOD.UnitPrice) 'Ukupna vrijednost', 
	 ROW_NUMBER() OVER(ORDER BY SUM(SOD.OrderQty*SOD.UnitPrice) DESC) 'RedniBr', 'Stoni mikser' Nagrada
	 FROM  Person.Person AS PP
	 INNER JOIN Sales.Customer AS C
	 ON PP.BusinessEntityID=C.PersonID
	 INNER JOIN Sales.SalesOrderHeader AS SOH
	 ON C.CustomerID=SOH.CustomerID
	 INNER JOIN Sales.SalesOrderDetail AS SOD
	 ON SOH.SalesOrderID=SOD.SalesOrderID
	 WHERE YEAR(SOH.OrderDate)=2013 AND MONTH(SOH.OrderDate) = 4 AND RIGHT(PP.FirstName,1) = 'a'
	 GROUP BY MONTH(SOH.OrderDate), PP.FirstName, PP.LastName) AS PODQ
WHERE RedniBr=3
UNION
SELECT PODQ.Mjesec, PODQ.FirstName, PODQ.LastName, PODQ.[Ukupna vrijednost], PODQ.Nagrada
FROM(SELECT MONTH(SOH.OrderDate) 'Mjesec', PP.FirstName, PP.LastName, 
	 SUM(SOD.OrderQty*SOD.UnitPrice) 'Ukupna vrijednost', 
	 ROW_NUMBER() OVER(ORDER BY SUM(SOD.OrderQty*SOD.UnitPrice) DESC) 'RedniBr', 'Pegla' Nagrada
	 FROM  Person.Person AS PP
	 INNER JOIN Sales.Customer AS C
	 ON PP.BusinessEntityID=C.PersonID
	 INNER JOIN Sales.SalesOrderHeader AS SOH
	 ON C.CustomerID=SOH.CustomerID
	 INNER JOIN Sales.SalesOrderDetail AS SOD
	 ON SOH.SalesOrderID=SOD.SalesOrderID
	 WHERE YEAR(SOH.OrderDate)=2013 AND MONTH(SOH.OrderDate) = 5 AND RIGHT(PP.FirstName,1) = 'a'
	 GROUP BY MONTH(SOH.OrderDate), PP.FirstName, PP.LastName) AS PODQ
WHERE RedniBr=3
UNION
SELECT PODQ.Mjesec, PODQ.FirstName, PODQ.LastName, PODQ.[Ukupna vrijednost], PODQ.Nagrada
FROM(SELECT MONTH(SOH.OrderDate) 'Mjesec', PP.FirstName, PP.LastName, 
	 SUM(SOD.OrderQty*SOD.UnitPrice) 'Ukupna vrijednost', 
	 ROW_NUMBER() OVER(ORDER BY SUM (SOD.OrderQty*SOD.UnitPrice) DESC) 'RedniBr', 'Usisivač' Nagrada
	 FROM  Person.Person AS PP
	 INNER JOIN Sales.Customer AS C
	 ON PP.BusinessEntityID=C.PersonID
	 INNER JOIN Sales.SalesOrderHeader AS SOH
	 ON C.CustomerID=SOH.CustomerID
	 INNER JOIN Sales.SalesOrderDetail AS SOD
	 ON SOH.SalesOrderID=SOD.SalesOrderID
	 WHERE YEAR(SOH.OrderDate)=2013 AND MONTH(SOH.OrderDate) = 4 AND RIGHT(PP.FirstName,1) != 'a'
	 GROUP BY MONTH(SOH.OrderDate), PP.FirstName, PP.LastName) AS PODQ
WHERE RedniBr=3
UNION
SELECT PODQ.Mjesec, PODQ.FirstName, PODQ.LastName, PODQ.[Ukupna vrijednost], PODQ.Nagrada
FROM(SELECT MONTH(SOH.OrderDate) 'Mjesec', PP.FirstName, PP.LastName,
	 SUM(SOD.OrderQty*SOD.UnitPrice) 'Ukupna vrijednost', 
	 ROW_NUMBER() OVER(ORDER BY SUM(SOD.OrderQty*SOD.UnitPrice) DESC) 'RedniBr', 'Multicooker' Nagrada
	 FROM  Person.Person AS PP
	 INNER JOIN Sales.Customer AS C
	 ON PP.BusinessEntityID=C.PersonID
	 INNER JOIN Sales.SalesOrderHeader AS SOH
	 ON C.CustomerID=SOH.CustomerID
	 INNER JOIN Sales.SalesOrderDetail AS SOD
	 ON SOH.SalesOrderID=SOD.SalesOrderID
	 WHERE YEAR(SOH.OrderDate)=2013 AND MONTH(SOH.OrderDate) = 5 AND RIGHT(PP.FirstName,1) != 'a'
	 GROUP BY MONTH(SOH.OrderDate), PP.FirstName, PP.LastName) AS PODQ
WHERE RedniBr=3
ORDER BY 4 DESC
--28 bodova
--6. Dokument teorijski_ispit 29JUN22, preimenovati vašim brojem indeksa, te u tom dokumentu izraditi 
--pitanja.
--20 bodova
--SQL skriptu (bila prazna ili ne) imenovati Vašim brojem indeksa npr IB200001.sql, teorijski dokument imenovan 
--Vašim brojem indexa npr IB200001.docx upload-ovati ODVOJEDNO na ftp u folder Upload.
--Maksimalan broj bodova:100 
--Prag prolaznosti: 55