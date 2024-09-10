CREATE DATABASE Vjezba2Copy

GO
USE Vjezba2Copy

CREATE SCHEMA Prodaja

CREATE TABLE Prodaja.Autori
(
	AutorID CHAR(11) CONSTRAINT PK_Autori PRIMARY KEY,
	Prezime VARCHAR(40) NOT NULL,
	Ime VARCHAR(20) NOT NULL,
	Telefon CHAR(12) DEFAULT('nepoznato'),
	Adresa VARCHAR(40),
	SaveznaDrzava CHAR(2),
	PostanskiBroj CHAR(5),
	Ugovor BIT NOT NULL
)

CREATE TABLE Prodaja.Knjige
(
	KnjigaID CHAR(6) PRIMARY KEY,
	Naziv VARCHAR(80) NOT NULL,
	Vrsta CHAR(12) NOT NULL,
	IzdavacID CHAR(4),
	Cijena MONEY,
	Biljeska VARCHAR(20),
	Datum DATETIME,
)

ALTER TABLE Prodaja.Knjige
ALTER COLUMN Biljeska VARCHAR(200);

ALTER TABLE Prodaja.Knjige
ADD IDIzdavaca CHAR(4) CONSTRAINT FK_Knjige FOREIGN KEY REFERENCES
Prodaja.Izdavaci(IzdavacID)

CREATE TABLE Prodaja.Izdavaci 
(
	IzdavacID CHAR(4) CONSTRAINT PK_Izdavaci PRIMARY KEY,
	ImeIzdavaca VARCHAR(40) NULL,
	Grad VARCHAR(20) NULL,
	Entitet CHAR(2) NULL,
	Drzava VARCHAR(30) NULL
)

INSERT INTO Prodaja.Izdavaci(IzdavacID, ImeIzdavaca, Grad, Entitet, Drzava)
SELECT P.pub_id, P.pub_name, P.city, p.[state], p.country
FROM pubs.dbo.publishers as P

SELECT *
FROM Prodaja.Izdavaci

CREATE TABLE Prodaja.AutoriKnjige
(
	AutorID CHAR(11),
	KnjigaID CHAR(6),
	AuOrd TINYINT
	CONSTRAINT PK_AutoriKnjige PRIMARY KEY (AutorID, KnjigaID),
	CONSTRAINT FK_AUTORI FOREIGN KEY(AutorID) REFERENCES Prodaja.Autori(AutorID),
	CONSTRAINT FK_Knjiga FOREIGN KEY(KnjigaID) REFERENCES Prodaja.Knjige(KnjigaID)
)

/* KNJIGE
	KnjigaID CHAR(6) PRIMARY KEY,
	Naziv VARCHAR(80) NOT NULL,
	Vrsta CHAR(12) NOT NULL,
	IzdavacID CHAR(4),
	Cijena MONEY,
	Biljeska VARCHAR(20),
	Datum DATETIME,

*/
INSERT INTO Prodaja.Knjige(KnjigaID, Naziv, Vrsta, IzdavacID, Cijena, Biljeska ,Datum)
SELECT T.title_id, T.title, T.[type], T.pub_id, T.price,
ISNULL(T.notes, 'nepoznata vrijednost'), T.pubdate
FROM pubs.dbo.titles as T

/* AUTORI

AutorID CHAR(11) CONSTRAINT PK_Autori PRIMARY KEY,
	Prezime VARCHAR(40) NOT NULL,
	Ime VARCHAR(20) NOT NULL,
	Telefon CHAR(12) DEFAULT('nepoznato'),
	Adresa VARCHAR(40),
	SaveznaDrzava CHAR(2),
	PostanskiBroj CHAR(5),
	Ugovor BIT NOT NULL
*/

INSERT INTO Prodaja.Autori(AutorID, Prezime, Ime, Telefon, Adresa, 
SaveznaDrzava, PostanskiBroj, Ugovor)
SELECT A.au_id, A.au_lname, A.au_fname, A.phone,
A.[address], A.[state], A.zip, A.[contract]
FROM pubs.dbo.authors as A

SELECT * FROM
Prodaja.Autori

SELECT * FROM
Prodaja.Knjige

ALTER TABLE Prodaja.Autori
ALTER COLUMN Adresa NVARCHAR(40)

SELECT *
FROM Prodaja.Autori as P
WHERE P.Ime LIKE 'A%' OR P.ime LIKE 'S%'

SELECT * 
FROM Prodaja.Knjige as K
WHERE K.Cijena IS NULL

ALTER TABLE Prodaja.Izdavaci
ADD CONSTRAINT UQ_Naziv UNIQUE(ImeIzdavaca)

SELECT * FROM
Prodaja.Izdavaci

GO
USE Vjezba2Copy

CREATE SCHEMA NARUDZBE

SELECT *
INTO NARUDZBE.Regije
FROM Northwind.dbo.Region

SELECT * FROM
NARUDZBE.Regije

INSERT INTO NARUDZBE.Regije(RegionID, RegionDescription)
SELECT 5, 'SE'

INSERT INTO NARUDZBE.Regije(RegionID, RegionDescription)
SELECT 6, 'NE'

INSERT INTO NARUDZBE.Regije(RegionID, RegionDescription)
SELECT 7, 'NW'


SELECT *
INTO NARUDZBE.StavkeNarudzbe
FROM Northwind.dbo.[Order Details]

SELECT * 
FROM NARUDZBE.StavkeNarudzbe

ALTER TABLE NARUDZBE.StavkeNarudzbe
ADD Ukupno DECIMAL(8,2)

UPDATE NARUDZBE.StavkeNarudzbe
SET Ukupno=Quantity * UnitPrice

ALTER TABLE NARUDZBE.StavkeNarudzbe
ADD CijeliDio AS FLOOR(UnitPrice)

ALTER TABLE Prodaja.Proizvodi
ADD CONSTRAINT CK_Cijena CHECK(Cijena > 0.1)

ALTER TABLE Narudzbe.StavkeNarudzbe 
ADD CONSTRAINT CK_Discount CHECK(Discount>=0)

INSERT 
INTO NARUDZBE.StavkeNarudzbe(OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (99901, 12, 15.00, 12.00, 1)

CREATE TABLE NARUDZBE.Kategorije 
(
	KategorijaID INT CONSTRAINT PK_Kategorije PRIMARY KEY IDENTITY(1,1),
	NazivKategorije NVARCHAR(15) NOT NULL,
	Opis NTEXT,
)

SET IDENTITY_INSERT NARUDZBE.Kategorije ON
INSERT INTO NARUDZBE.Kategorije(KategorijaID, NazivKategorije, Opis)
SELECT C.CategoryID, C.CategoryName, C.[Description]
FROM Northwind.dbo.Categories as C
SET IDENTITY_INSERT NARUDZBE.Kategorije OFF

SELECT * FROM NARUDZBE.Kategorije

INSERT INTO NARUDZBE.Kategorije(NazivKategorije, Opis)
VALUES ('Ncategory', 'no category')


UPDATE NARUDZBE.Kategorije
SET Opis = 'bez opisa'
WHERE Opis IS NULL

DELETE
FROM NARUDZBE.Kategorije

/* DODATNI ZADACI */

CREATE DATABASE ZadaciZaVjezbu2Copy
GO
USE ZadaciZaVjezbu2Copy

CREATE SCHEMA Prodaja

CREATE TABLE Prodaja.Proizvodi 
(
	ProizvodID INT CONSTRAINT PK_Proizvod PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(40) NOT NULL,
	Cijena MONEY,
	KolicinaNaSkladistu TINYINT,
	Raspolozivost BIT NOT NULL
)
CREATE TABLE Prodaja.Kupci
(
	KupacID NCHAR(5) CONSTRAINT PK_KUPCI PRIMARY KEY,
	NazivKompanije NVARCHAR(40) NOT NULL,
	Ime NVARCHAR(30),
	Telefon NVARCHAR(24),
	Faks NVARCHAR(24),
)
CREATE TABLE Prodaja.Narudzbe 
(
	NarudzbaID INT CONSTRAINT PK_Narudzbe PRIMARY KEY IDENTITY(1,1),
	DatumNarudzbe DATETIME,
	DatumPrijema DATETIME,
	DatumIsporuke DATETIME,
	Drzava NVARCHAR(15),
	Regija NVARCHAR(15),
	Grad NVARCHAR(15),
	Adresa NVARCHAR(60),
)
CREATE TABLE Prodaja.StavkeNarudzbe 
(
	NarudzbaID INT,
	ProizvodID INT,
	Cijena MONEY NOT NULL,
	Kolicina TINYINT NOT NULL DEFAULT 1,
	Popust REAL NOT NULL,
	VrijednostStavki AS (Cijena * Kolicina * (1 - Popust)),
	CONSTRAINT PK_SN PRIMARY KEY(NarudzbaID, ProizvodID),
	CONSTRAINT FK_Narudzba FOREIGN KEY(NarudzbaID) REFERENCES Prodaja.Narudzbe(NarudzbaID),
	CONSTRAINT FK_Proizvod FOREIGN KEY(ProizvodID) REFERENCES Prodaja.Proizvodi(ProizvodID),
)

DROP TABLE StavkeNarudzbe

/* 	ProizvodID INT CONSTRAINT PK_Proizvod PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(40) NOT NULL,
	Cijena MONEY,
	KolicinaNaSkladistu TINYINT,
	Raspolozivost BIT NOT NULL */

SET IDENTITY_INSERT Prodaja.Proizvodi ON
INSERT INTO Prodaja.Proizvodi(ProizvodID, Naziv, Cijena, 
KolicinaNaSkladistu, Raspolozivost)
SELECT P.ProductID, P.ProductName, P.UnitPrice, P.UnitsInStock, P.ReorderLevel
FROM Northwind.dbo.Products as P
SET IDENTITY_INSERT Prodaja.Proizvodi OFF

SELECT * FROM Prodaja.Proizvodi

INSERT INTO Prodaja.Kupci(KupacID, NazivKompanije, Ime, Telefon, Faks)
SELECT C.CustomerID, C.CompanyName, C.ContactName, C.Phone, C.Fax
FROM northwind.dbo.Customers as C

SELECT * FROM Prodaja.Kupci

SET IDENTITY_INSERT Prodaja.Narudzbe ON
INSERT INTO Prodaja.Narudzbe(NarudzbaID, DatumNarudzbe, DatumPrijema, 
DatumIsporuke, Drzava, Regija, Grad, Adresa)
SELECT O.OrderID, O.OrderDate, O.RequiredDate, 
O.ShippedDate, O.ShipCountry, ISNULL(O.ShipRegion, 'nije naznaceno'), O.ShipCity, O.ShipAddress
FROM northwind.dbo.Orders as O
SET IDENTITY_INSERT Prodaja.Narudzbe OFF

SELECT * FROM Prodaja.Narudzbe

INSERT INTO Prodaja.StavkeNarudzbe(NarudzbaID, ProizvodID, Cijena, 
Kolicina, Popust)
SELECT O.OrderID, O.ProductID, O.UnitPrice, O.Quantity, O.Discount
FROM Northwind.dbo.[Order Details] as O
WHERE O.Quantity > 4

SELECT * FROM 
Prodaja.StavkeNarudzbe

SELECT * FROM
Prodaja.Proizvodi as P 
WHERE P.Cijena > 100 

INSERT INTO Prodaja.Proizvodi(Naziv, Cijena, KolicinaNaSkladistu, 
Raspolozivost)
VALUES ('Pilav', 50.00, 12, 1)

INSERT INTO Prodaja.StavkeNarudzbe
VALUES (12345, 12, 50.00, 10, 0.10)

DELETE FROM Prodaja.StavkeNarudzbe
WHERE NarudzbaID = 10248;

SELECT * FROM
Prodaja.Proizvodi

ALTER TABLE Prodaja.Proizvodi
ADD potrebnoNaruciti AS IIF(KolicinaNaSkladistu < 10,'DA','NE')