CREATE DATABASE ZadaciZaVjezbu2
GO
Use ZadaciZaVjezbu2

CREATE SCHEMA Prodaja
GO
/* Proizvodi 
• ProizvodID, cjelobrojna vrijednost, autoinkrement i primarni ključ 
• Naziv, 40 UNICODE karaktera (obavezan unos) 
• Cijena, novčani tip 
• KolicinaNaSkladistu, skraćeni cjelobrojni tip 
• Raspolozivost, bit polje (obavezan unos)  */

CREATE TABLE Prodaja.Proizvodi 
(
	ProizvodID INT CONSTRAINT PK_Proizvodi PRIMARY KEY IDENTITY(1,1),
	Naziv NVARCHAR(40) NOT NULL,
	Cijena MONEY,
	KolicinaNaSkladistu SMALLINT,
	Respolozivost BIT NOT NULL
)

/* Kupci 
• KupacID, 5 UNICODE fiksna karaktera i primarni ključ 
• NazivKompanije, 40 UNICODE karaktera (obavezan unos) 
• Ime, 30 UNICODE karaktera 
• Telefon, 24 UNICODE karaktera 
• Faks, 24 UNICODE karaktera  */

CREATE TABLE Prodaja.Kupci 
(
	KupacID NCHAR(5) CONSTRAINT PK_Kupci PRIMARY KEY,
	NazivKompanije NVARCHAR(40) NOT NULL,
	Ime NVARCHAR(30),
	Telefon NVARCHAR(24),
	Faks NVARCHAR(24)
)

CREATE TABLE Prodaja.Narudzbe
(
	NarudzbaID INT CONSTRAINT PK_Narudzbe PRIMARY KEY IDENTITY(1,1),
	DatumNarudzbe DATE,
	DatumPrijema DATE,
	DatumIsporuke DATE,
	Drzava NVARCHAR(15),
	Regija NVARCHAR(15),
	Grad NVARCHAR(15),
	Adresa NVARCHAR(60)
)

/* Narudzbe 
• NarudzbaID, cjelobrojna vrijednost, autoinkrement i primarni ključ, 
• DatumNarudzbe, polje za unos datuma 
• DatumPrijema, polje za unos datuma 
• DatumIsporuke, polje za unos datuma 
• Drzava, 15 UNICODE karaktera 
• Regija, 15 UNICODE karaktera 
• Grad, 15 UNICODE karaktera 
• Adresa, 60 UNICODE karaktera  */
GO
CREATE TABLE StavkeNarudzbe
(
	NarudzbaID INT CONSTRAINT FK_StavkeNarudzbe_Narudzba FOREIGN KEY REFERENCES Prodaja.Narudzbe(NarudzbaID),
	ProizvodID INT CONSTRAINT FK_StavkeNarudzbe_Proizvod FOREIGN KEY REFERENCES Prodaja.Proizvodi(ProizvodID),
	Cijena MONEY NOT NULL,
	Kolicina SMALLINT NOT NULL DEFAULT(1),
	Popust REAL NOT NULL,
	VrijednostStavki AS (Cijena * Kolicina *(1 - Popust)),
	CONSTRAINT PK_StavkeNarudzbe PRIMARY KEY(NarudzbaID, ProizvodID)
)

/*  StavkeNarudzbe 
• NarudzbaID, cjelobrojna vrijednost, strani ključ 
• ProizvodID, cjelobrojna vrijednost, strani ključ 
• Cijena, novčani tip (obavezan unos), 
• Kolicina, skraćeni cjelobrojni tip (obavezan unos) i defaultna vrijednost (1), 
• Popust, realna vrijednost (obavezan unos) 
• VrijednostStavki narudžbe (uzeti u obzir i popust)- calculated polje 
**Definisati primarni ključ tabele */

SET IDENTITY_INSERT Prodaja.Proizvodi ON
INSERT INTO Prodaja.Proizvodi (ProizvodID, Naziv, Cijena, KolicinaNaSkladistu,Respolozivost)
SELECT ProductID, ProductName, UnitPrice, UnitsInStock, Discontinued
FROM Northwind.dbo.Products;
SET IDENTITY_INSERT Prodaja.Proizvodi OFF

SELECT * FROM Prodaja.Proizvodi
/* . Iz baze podataka Northwind u svoju bazu podataka prebaciti sljedeće podatke: 
a) U tabelu Proizvodi dodati sve proizvode 
• ProductID -> ProizvodID 
• ProductName -> Naziv 
• UnitPrice -> Cijena 
• UnitsInStock -> KolicinaNaSkladistu 
• Discontinued -> Raspolozivost  */

INSERT INTO Prodaja.Kupci(KupacID, NazivKompanije, Ime, Telefon, Faks)
SELECT CustomerID, CompanyName, ContactName, Phone, Fax
FROM Northwind.dbo.Customers

SELECT * FROM Prodaja.Kupci

/* U tabelu Kupci dodati sve kupce 
• CustomerID -> KupciID 
• CompanyName -> NazivKompanije 
• ContactName -> Ime 
• Phone -> Telefon 
• Fax -> Faks*/

SET IDENTITY_INSERT Prodaja.Narudzbe ON
INSERT INTO Prodaja.Narudzbe(NarudzbaID, DatumNarudzbe, DatumPrijema, DatumIsporuke, Drzava, 
			Regija, Grad, Adresa)
SELECT OrderID, OrderDate, RequiredDate, ShippedDate, ShipCountry, 
ISNULL(ShipRegion, 'nije naznaceno'), ShipCity, ShipAddress
FROM Northwind.dbo.Orders
SET IDENTITY_INSERT Prodaja.Narudzbe OFF

SELECT * FROM Prodaja.Narudzbe
/* U tabelu Narudzbe dodati sve narudžbe, na mjestima gdje nema pohranjenih podataka o regiji 
zamijeniti vrijednost sa nije naznaceno
• OrderID -> NarudzbaID 
• OrderDate -> DatumNarudzbe 
• RequiredDate -> DatumPrijema 
• ShippedDate -> DatumIsporuke 
• ShipCountry -> Drzava 
• ShipRegion -> Regija 
• ShipCity -> Grad 
• ShipAddress -> Adresa */


INSERT INTO StavkeNarudzbe(NarudzbaID, ProizvodID, Cijena, Kolicina, Popust)
SELECT OrderID, ProductID, UnitPrice, Quantity, Discount
FROM Northwind.dbo.[Order Details]
WHERE Quantity > 4

SELECT * FROM StavkeNarudzbe
/* U tabelu StavkeNarudzbe dodati sve stavke narudžbe gdje je količina veća od 4 
• OrderID -> NarudzbaID 
• ProductID -> ProizvodID 
• UnitPrice -> Cijena 
• Quantity -> Kolicina 
• Discount -> Popust */

/* Kreirati upit kojim će se prikazati svi proizvodi čija je cijena veća od 100  */

SELECT *
FROM Prodaja.Proizvodi
WHERE Cijena > 100

SET IDENTITY_INSERT Prodaja.Proizvodi ON
INSERT INTO Prodaja.Proizvodi(ProizvodID, Naziv, Cijena, KolicinaNaSkladistu, Respolozivost)
VALUES (87, 'Coca Cola Zero', 543.20, 12, 1)
SET IDENTITY_INSERT Prodaja.Proizvodi OFF


INSERT INTO StavkeNarudzbe(NarudzbaID, ProizvodID, Cijena, Kolicina, Popust)
VALUES (10260, 87, 45.50, 12, 0.5)

DELETE 
FROM StavkeNarudzbe
WHERE NarudzbaID = 10248

/* U tabeli Proizvodi kreirati ograničenje na koloni Cijena kojim će se onemogućiti unos vrijednosti 
manjih od 0,1 */

ALTER TABLE Prodaja.Proizvodi
ADD CONSTRAINT Unos_Cijena CHECK (Cijena >= 0.1)

/* U tabeli proizvodi dodati izračunatu kolonu pod nazivom potrebnoNaruciti za količinu proizvoda na 
skladištu ispod 10 potrebno je pohraniti vrijednost „DA“ a u suptornom „NE“. */

ALTER TABLE Prodaja.Proizvodi
ADD potrebnoNaruciti AS IIF(KolicinaNaSkladistu < 10, 'DA','NE')