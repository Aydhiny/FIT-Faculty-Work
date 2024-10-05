--14.07.2023.

--BAZE PODATAKA II – ISPIT

--***Prilikom izrade zadataka, OBAVEZNO iznad svakog zadatka napisati redni broj zadatka i tekst. Zadaci koji ne budu oznaèeni na prethodno definisan naèin neæe biti evaluirani.

--1.	Kroz SQL kod kreirati bazu podataka sa imenom vašeg broja indeksa.
CREATE DATABASE ispit1407
GO
USE ispit1407
--2.	U kreiranoj bazi podataka kreirati tabele sa sljedeæom strukturom:
--a)	Zaposlenici
--•	ZaposlenikID, cjelobrojna vrijednost i primarni kljuè, autoinkrement
--•	Ime, 50 UNICODE (obavezan unos)
--•	Prezime, 50 UNICODE (obavezan unos)
--•	OpisPosla, 50 UNICODE karaktera (obavezan unos)
--•	EmailAdresa, 50 UNICODE karaktera 

CREATE TABLE Prodavaci
(
	ProdavacID INT CONSTRAINT PK_Zaposlenik PRIMARY KEY IDENTITY(1,1),
	Ime NVARCHAR(50) NOT NULL,
	Prezime NVARCHAR(50) NOT NULL,
	OpisPosla NVARCHAR(50) NOT NULL,
	EmailAdresa NVARCHAR(50)
)
--b)	Proizvodi
--•	ProizvodID, cjelobrojna vrijednost i primarni kljuè, autoinkrement
--•	Naziv, 50 UNICODE karaktera (obavezan unos)
--•	SifraProizvoda, 25 UNICODE karaktera (obavezan unos)
--•	Boja, 15 UNICODE karaktera 
--•	NazivPodkategorije, 50 UNICODE (obavezan unos)

CREATE TABLE Proizvodi
(
	ProizvodID INT CONSTRAINT PK_Proizvodi PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(50) NOT NULL,
	SifraProizvoda NVARCHAR(25) NOT NULL,
	Boja NVARCHAR(15),
	NazivPodkategorije NVARCHAR(50) NOT NULL
)
--c)	ZaglavljeNarudzbe 
--•	NarudzbaID, cjelobrojna vrijednost i primarni kljuè, autoinkrement
--•	DatumNarudzbe, polje za unos datuma i vremena (obavezan unos)
--•	DatumIsporuke, polje za unos datuma i vremena
--•	ImeKupca, 50 UNICODE (obavezan unos)
--•	PrezimeKupca, 50 UNICODE (obavezan unos)
--•	NazivTeritorije, 50 UNICODE (obavezan unos)
--•	ZaposlenikID, cjelobrojna vrijednost, strani kljuè

CREATE TABLE ZaglavljeNarudzbe
(
	NarudzbaID INT CONSTRAINT PK_Zaglavlje PRIMARY KEY IDENTITY(1,1),
	DatumNarudzbe DATETIME NOT NULL,
	DatumIsporuke DATETIME,
	KreditnaKarticaID INT,
	ImeKupca NVARCHAR(50) NOT NULL,
	PrezimeKupca NVARCHAR(50) NOT NULL,
	NazivGradaIsporuke NVARCHAR(50) NOT NULL,
	NacinIsporuke NVARCHAR(50) NOT NULL,
	ZaposlenikID INT CONSTRAINT FK_Zaglavlje_Zaposlenik FOREIGN KEY REFERENCES Prodavaci(ProdavacID)
)
--d)	DetaljiNarudzbe
--•	NarudzbaID, cjelobrojna vrijednost, obavezan unos i strani kljuè
--•	ProizvodID, cjelobrojna vrijednost, obavezan unos i strani kljuè
--•	Cijena, novèani tip (obavezan unos),
--•	Kolicina, skraæeni cjelobrojni tip (obavezan unos),
--•	Popust, novèani tip (obavezan unos)
--•	OpisSpecijalnePonude, 255 UNICODE (obavezan unos)
CREATE TABLE DetaljiNarudzbe
(
	DetaljiNarudzbeID INT CONSTRAINT PK_DetaljiNarudzbe PRIMARY KEY IDENTITY(1,1),
	NarudzbaID INT NOT NULL CONSTRAINT FK_Detalji_Zaglavlje FOREIGN KEY REFERENCES ZaglavljeNarudzbe(NarudzbaID),
	ProizvodID INT NOT NULL CONSTRAINT FK_Detalji_Proizvod FOREIGN KEY REFERENCES Proizvodi(ProizvodID),
	Cijena MONEY NOT NULL,
	Kolicina SMALLINT NOT NULL,
	Popust MONEY NOT NULL,
	OpisSpecijalnePonude NVARCHAR(255)NOT NULL
)

--**Jedan proizvod se može više puta naruèiti, dok jedna narudžba može sadržavati više proizvoda. U okviru jedne narudžbe jedan proizvod se ne može naruèiti više od jedanput.
--9 bodova
--3.	Iz baze podataka AdventureWorks u svoju bazu podataka prebaciti sljedeæe podatke:
--a)	U tabelu Prodavaci dodati sve narudžbe
--•	BusinessEntityID (SalesPerson) -> ProdavacID
--•	FirstName (Person) -> Ime
--•	LastName (Person) -> Prezime
--•	JobTitle (Employee) -> OpisPosla
--•	EmailAddress (EmailAddress) -> EmailAdresa
SET IDENTITY_INSERT Prodavaci ON
INSERT INTO Prodavaci(ProdavacID, Ime, Prezime, OpisPosla, EmailAdresa)
SELECT SP.BusinessEntityID,PP.FirstName,PP.LastName,E.JobTitle,EA.EmailAddress
FROM AdventureWorks2017.Sales.SalesPerson AS SP
INNER JOIN AdventureWorks2017.HumanResources.Employee AS E
ON SP.BusinessEntityID=E.BusinessEntityID
INNER JOIN AdventureWorks2017.Person.Person AS PP
ON E.BusinessEntityID=PP.BusinessEntityID
INNER JOIN AdventureWorks2017.Person.EmailAddress AS EA
ON EA.BusinessEntityID=PP.BusinessEntityID
SET IDENTITY_INSERT Prodavaci OFF

--b)	U tabelu Proizvodi dodati sve proizvode, na mjestima gdje nema pohranjenih podataka o boji zamijeniti vrijednost sa nije naznaceno
--•	ProductID -> ProizvodID
--•	Name  -> Naziv 	
--•	ProductNumber -> SifraProizvoda
--•	Color -> Boja 
--•	Name (ProductSubategory) -> NazivPodkategorije
SET IDENTITY_INSERT Proizvodi ON
INSERT INTO Proizvodi(ProizvodID,Naziv,SifraProizvoda,Boja,NazivPodkategorije)
SELECT PP.ProductID,PP.Name,PP.ProductNumber,PP.Color,PS.Name
FROM AdventureWorks2017.Production.Product AS PP
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS PS
ON PP.ProductSubcategoryID=PS.ProductSubcategoryID
SET IDENTITY_INSERT Proizvodi OFF

--c)	U tabelu ZaglavljeNarudzbe dodati sve narudžbe
--•	SalesOrderID -> NarudzbaID
--•	OrderDate -> DatumNarudzbe
--•	ShipDate -> DatumIsporuke
--•	FirstName (Person) -> ImeKupca
--•	LastName (Person) -> PrezimeKupca
--•	Name (SalesTerritory) -> NazivTeritorije
--•	SalesPersonID -> ZaposlenikID
SET IDENTITY_INSERT ZaglavljeNarudzbe ON
INSERT INTO ZaglavljeNarudzbe(NarudzbaID,DatumNarudzbe,DatumIsporuke, KreditnaKarticaID ,ImeKupca,PrezimeKupca, NazivGradaIsporuke, ZaposlenikID, NacinIsporuke)
SELECT SOH.SalesOrderID, SOH.OrderDate, SOH.ShipDate, SOH.CreditCardID, PP.FirstName, PP.LastName, A.City, SOH.SalesPersonID, SM.Name
FROM AdventureWorks2017.Sales.SalesOrderHeader AS SOH
INNER JOIN AdventureWorks2017.Sales.Customer AS C
ON SOH.CustomerID=C.CustomerID
INNER JOIN AdventureWorks2017.Person.Person AS PP
ON C.PersonID=PP.BusinessEntityID
INNER JOIN AdventureWorks2017.Person.Address AS A
ON SOH.ShipToAddressID=A.AddressID
INNER JOIN AdventureWorks2017.Purchasing.ShipMethod AS SM
ON SOH.ShipMethodID=SM.ShipMethodID
SET IDENTITY_INSERT ZaglavljeNarudzbe OFF

--d)	U tabelu DetaljiNarudzbe dodati sve stavke narudžbe
--•	SalesOrderID -> NarudzbaID
--•	ProductID -> ProizvodID
--•	UnitPrice -> Cijena
--•	OrderQty -> Kolicina
--•	UnitPriceDiscount -> Popust
--•	Description (SpecialOffer) -> OpisSpecijalnePonude
INSERT INTO DetaljiNarudzbe
SELECT SOD.SalesOrderID,SOD.ProductID,SOD.UnitPrice,SOD.OrderQty,SOD.UnitPriceDiscount,SO.Description
FROM AdventureWorks2017.Sales.SalesOrderDetail AS SOD 
INNER JOIN AdventureWorks2017.Sales.SpecialOfferProduct AS SP
ON SOD.SpecialOfferID=SP.SpecialOfferID AND SOD.ProductID=SP.ProductID
INNER JOIN AdventureWorks2017.Sales.SpecialOffer AS SO
ON SP.SpecialOfferID=SO.SpecialOfferID
--10 bodova

--4.
--a)	(7 bodova) Kreirati funkciju f_nacinPlacanja u formi tabele gdje korisniku slanjem parametra identifikacijski broj narudžbe će biti ispisano spojeno ime i prezime kupca, grad isporuke, ukupna vrijednost narudžbe sa popustom, te poruka da li je narudžba plaćena karticom ili ne. Korisnik može dobiti 2 poruke „Plaćeno karticom“ ili „Nije plaćeno karticom“. OBAVEZNO kreirati testni slučaj. (Novokreirana baza)
GO
CREATE OR ALTER FUNCTION f_detalji
(
		@NarudzbaID INT
)
RETURNS TABLE
AS
RETURN
	SELECT CONCAT(ZN.ImeKupca, ' ',ZN.PrezimeKupca) 'Ime i prezime kupca', ZN.NazivGradaIsporuke, SUM(DN.Kolicina*DN.Cijena*(1-DN.Popust)) 'Ukupna vrijednost narudžbe sa popustom',IIF(ZN.KreditnaKarticaID IS NOT NULL, 'Placeno karticom', 'Nije placeno karticom') 'Poruka'
	FROM ZaglavljeNarudzbe AS ZN
	INNER JOIN DetaljiNarudzbe AS DN
	ON ZN.NarudzbaID=DN.NarudzbaID
	WHERE @NarudzbaID=ZN.NarudzbaID
	GROUP BY CONCAT(ZN.ImeKupca, ' ',ZN.PrezimeKupca), ZN.NazivGradaIsporuke, IIF(ZN.KreditnaKarticaID IS NOT NULL, 'Placeno karticom', 'Nije placeno karticom')
GO

SELECT *
FROM f_detalji(43660)

SELECT *
FROM ZaglavljeNarudzbe
--b)	(5 bodova) U kreiranoj bazi kreirati proceduru sp_insert_DetaljiNarudzbe kojom će se omogućiti insert nove stavke narudžbe. OBAVEZNO kreirati testni slučaj. (Novokreirana baza)
GO
CREATE PROCEDURE sp_insert_DetaljiNarudzbe
(
	@NarudzbaID INT,
	@ProizvodID INT,
	@Cijena MONEY,
	@Kolicina SMALLINT,
	@Popust MONEY,
	@OpisSpecijalnePonude NVARCHAR(255)
)
AS
BEGIN
	INSERT INTO DetaljiNarudzbe
	VALUES(@NarudzbaID, @ProizvodID, @Cijena, @Kolicina, @Popust, @OpisSpecijalnePonude)
END
GO


SELECT *
FROM DetaljiNarudzbe

EXEC sp_insert_DetaljiNarudzbe 	@NarudzbaID=45165, @ProizvodID=778, @Cijena=10, @Kolicina=5, @Popust=0.1, @OpisSpecijalnePonude='Neki opis'

--c)	(6 bodova) Kreirati upit kojim će se prikazati ukupan broj proizvoda po kategorijama. Korisnicima se treba ispisati o kojoj kategoriji se radi. Uslov je da se prikažu samo one kategorije kojima pripada više od 30 proizvoda, te da nazivi proizvoda se sastoje od 3 riječi, sadrže broj u bilo kojoj od riječi i još uvijek se nalaze u prodaji. Rezultate sortirati prema ukupnom broju proizvoda u opadajućem redoslijedu. (AdventureWorks2017)
USE AdventureWorks2017
SELECT PC.Name, COUNT(*) 'Ukupan broj po kategorijama'
FROM Production.Product AS P
INNER JOIN Production.ProductSubcategory AS PS
ON P.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PS.ProductCategoryID=PC.ProductCategoryID
WHERE LEN(P.Name)-LEN(REPLACE(P.Name,' ',''))=2 AND P.Name LIKE '%[0-9]%' AND P.SellEndDate IS NULL
GROUP BY PC.Name
HAVING COUNT(*)>30

--d)	(7 bodova) Za potrebe menadžmenta kompanije potrebno je kreirati upit kojim će se prikazati proizvodi koji nisu u prodaji i ne pripada kategoriji bicikala, kako bi ih ponovno vratili u prodaju. Proizvodu se početkom i po prestanku prodaje zabilježi datum. Također, osnovni uslov za ponovno povlačenje u prodaju je to da je ukupna prodana količina za svaki proizvod pojedinačno bila veća od 200 komada. Kao rezultat upita očekuju se podaci u formatu npr. Laptop 300kom itd.  (AdventureWorks2017)
USE AdventureWorks2017
SELECT PP.Name, SUM(SOD.OrderQty) 'Ukupna prodana količina'
FROM Production.Product AS PP
INNER JOIN Production.ProductSubcategory AS PS
ON PP.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PS.ProductCategoryID=PC.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON PP.ProductID=SOD.ProductID
WHERE PC.Name NOT LIKE 'Bikes' AND PP.SellEndDate IS NOT NULL
GROUP BY PP.Name
HAVING SUM(SOD.OrderQty)>200


--e)	(8 bodova) Kreirati upit kojim će se prikazati identifikacijski broj narudžbe, spojeno ime i prezime kupca, te ukupna vrijednost narudžbe koju je kupac platio. Uslov je da je od datuma narudžbe do datuma isporuke proteklo manje dana od prosječnog broja dana koji je bio potreban za isporuku svih narudžbi. (AdventureWorks2017)
USE AdventureWorks2017
SELECT SOH.SalesOrderID, CONCAT(PP.FirstName, ' ',PP.LastName) 'Ime i prezime', SOH.TotalDue
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.Customer AS C
ON SOH.CustomerID=C.CustomerID
INNER JOIN Person.Person AS PP
ON C.PersonID=PP.BusinessEntityID
WHERE DATEDIFF(DAY, SOH.OrderDate, SOH.ShipDate)<
(SELECT AVG(DATEDIFF(DAY, SOH.OrderDate, SOH.ShipDate))
 FROM Sales.SalesOrderHeader AS SOH)
--		37 bodova
--5.	
--a)	(9 bodova) Kreirati upit koji će prikazati one naslove kojih je ukupno prodano više od 30 komada a napisani su od strane autora koji su napisali 2 ili više djela/romana. U rezultatima upita prikazati naslov i ukupnu prodanu količinu. (Pubs) 
USE pubs
SELECT T.title_id, T.title, SUM(S.qty) AS ProdanaKolicina
FROM titles T
INNER JOIN sales S ON S.title_id = T.title_id
WHERE T.title_id IN (SELECT TA.title_id
						FROM titleauthor AS TA
						WHERE TA.au_id IN
						    (SELECT TA.au_id
								FROM titleauthor TA
								GROUP BY TA.au_id
								HAVING COUNT(*) >= 2) )
GROUP BY T.title_id, T.title
HAVING SUM(S.qty) > 30

--b)	(10 bodova) Kreirati upit koji će u % prikazati koliko je narudžbi (od ukupnog broja kreiranih) isporučeno na svaku od teritorija pojedinačno. Npr Australia 20.2%, Canada 12.01% itd. Vrijednosti dobijenih postotaka zaokružiti na dvije decimale i dodati znak %. (AdventureWorks2017)
USE AdventureWorks2017
SELECT PODQ.Name, PODQ.[Ukupno isporučen broj narudžbi],
(PODQ.[Ukupno isporučen broj narudžbi]*1.0/(SELECT COUNT(*)FROM Sales.SalesOrderHeader))*100 'Ukupan broj %'
FROM(SELECT T.Name, COUNT(*) 'Ukupno isporučen broj narudžbi'
	 FROM Sales.SalesOrderHeader AS SOH
	 INNER JOIN Sales.SalesTerritory AS T
	 ON SOH.TerritoryID=T.TerritoryID
	 GROUP BY T.Name) AS PODQ

select*
from Production.Product
--c)	(12 bodova) Kreirati upit koji će prikazati osobe koje imaju redovne prihode a nemaju vanredne, i one koje imaju vanredne a nemaju redovne. Lista treba da sadrži spojeno ime i prezime osobe, grad i adresu stanovanja i ukupnu vrijednost ostvarenih prihoda (za redovne koristiti neto). Pored navedenih podataka potrebno je razgraničiti kategorije u novom polju pod nazivom Opis na način "ISKLJUČIVO VANREDNI" za one koji imaju samo vanredne prihode, ili "ISKLJUČIVO REDOVNI" za one koji imaju samo redovne prihode. Konačne rezultate sortirati prema opisu abecedno i po ukupnoj vrijednosti ostvarenih prihoda u opadajućem redoslijedu.
use prihodi
SELECT O.OsobaID, CONCAT(O.Ime, ' ',O.PrezIme) 'Ime i prezime', G.Grad, O.Adresa, SUM(RP.Neto) 'Ukupna vrijednost', 'ISKLJUČIVO REDOVNI' Opis
FROM Osoba AS O
INNER JOIN RedovniPrihodi AS RP
ON O.OsobaID=RP.OsobaID
INNER JOIN Grad AS G
ON O.GradID=G.GradID
WHERE O.OsobaID NOT IN (SELECT VP.OsobaID FROM VanredniPrihodi AS VP WHERE VP.OsobaID IS NOT NULL)
GROUP BY O.OsobaID, CONCAT(O.Ime, ' ',O.PrezIme), G.Grad, O.Adresa
UNION
SELECT O.OsobaID, CONCAT(O.Ime, ' ',O.PrezIme) 'Ime i prezime', G.Grad, O.Adresa, SUM(VP.IznosVanrednogPrihoda) 'Ukupna vrijednost', 'ISKLJUČIVO VANREDNI' Opis
FROM Osoba AS O
INNER JOIN VanredniPrihodi AS VP
ON O.OsobaID=VP.OsobaID
INNER JOIN Grad AS G
ON O.GradID=G.GradID
WHERE O.OsobaID NOT IN (SELECT RP.OsobaID FROM RedovniPrihodi AS RP WHERE RP.OsobaID IS NOT NULL)
GROUP BY O.OsobaID, CONCAT(O.Ime, ' ',O.PrezIme), G.Grad, O.Adresa
ORDER BY 6, 5 DESC
--28 bodova


--7.	Dokument teorijski_ispit 20JUL22, preimenovati vašim brojem indeksa, te u tom dokumentu izraditi pitanja.
--20 bodova
--SQL skriptu (bila prazna ili ne) imenovati Vašim brojem indeksa npr IB200001.sql, teorijski dokument imenovan Vašim brojem indexa npr IB200001.docx upload-ovati ODVOJEDNO na ftp u folder Upload.
--Maksimalan broj bodova:100  
--Prag prolaznosti: 55
