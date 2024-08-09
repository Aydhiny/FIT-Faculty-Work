USE Vjezba2
GO

GO


CREATE TABLE Prodaja.Autori 
(
	AutorID VARCHAR(11) CONSTRAINT PK_Autor PRIMARY KEY,
	Prezime VARCHAR(40) NOT NULL,
	Ime VARCHAR(20) NOT NULL,
	Telefon CHAR(12) DEFAULT 'nepoznato', 
	Adersa VARCHAR(40),
	SaveznaDrzava CHAR(2),
	PostanskiBroj CHAR(5),
	Ugovor BIT NOT NULL
)

/*Autori 
• AutorID, 11 karaktera i primarni ključ 
• Prezime, 40 karaktera (obavezan unos) 
• Ime, 20 karaktera (obavezan unos) 
• Telefon, 12 karaktera fiksne dužine, zadana vrijednost „nepoznato“ 
• Adresa, 40 karaktera 
• SaveznaDrzava, 2 karaktera fiksne dužine 
• PostanskiBroj, 5 karaktera fiksne dužine 
• Ugovor, bit polje (obavezan unos) 
*/

CREATE TABLE Prodaja.Knjige 
(
	KnjigaID VARCHAR(6) CONSTRAINT PK_Knjige PRIMARY KEY,
	Naziv VARCHAR(80) NOT NULL,
	Vrsta CHAR(12) NOT NULL,
	IzdavacID CHAR(4),
	Cijena MONEY,
	Biljeska VARCHAR(200),
	Datum DATETIME
)

/*Knjige 
• KnjigaID, 6 karaktera i primarni ključ 
• Naziv, 80 karaktera (obavezan unos) 
• Vrsta, 12 karaktera fiksne dužine (obavezan unos) 
• IzdavacID, 4 karaktera fiksne duzine 
• Cijena, novčani tip podatka 
• Biljeska, 200 karaktera 
• Datum, datumsko-vremenski ti
*/

SELECT *
INTO Prodaja.Izdavaci
FROM pubs.dbo.publishers

/* Upotrebom insert naredbe iz tabele Publishers baze Pubs izvršiti kreiranje i insertovanje podataka u 
tabelu Izdavaci šeme Prodaja (Nazivi kolona trebaju biti na bosanskom jeziku) */

ALTER TABLE Prodaja.Izdavaci
ADD CONSTRAINT PK_Izdavaci PRIMARY KEY(pub_id)

/* Povezati tabelu Izdavaci sa tabelom Knjige, po uzoru na istoimene tabele baze Pubs
7. U šemu Prodaja dodati tabelu sa sljedećom strukturo */

ALTER TABLE Prodaja.Knjige
ADD CONSTRAINT FK_Izdavaci FOREIGN KEY(IzdavacID) REFERENCES Prodaja.Izdavaci(pub_id)

USE Vjezba2
GO
GO

CREATE TABLE Prodaja.AutoriKnjige
(
	AutorID VARCHAR(11) CONSTRAINT FK_AutorKnjige_Autori FOREIGN KEY REFERENCES Prodaja.Autori(AutorID),
	KnjigaID VARCHAR(6) CONSTRAINT FK_AutorKnjige_Knjige FOREIGN KEY REFERENCES Prodaja.Knjige(KnjigaID),
	AuOrd TINYINT,
	CONSTRAINT PK_AutoriKnjige PRIMARY KEY (AutorID, KnjigaID)
)

/* AutoriKnjige 
• AutorID 11 karaktera, spoljni ključ 
• KnjigaID 6 karaktera, spoljni ključ 
• AuOrd kratki cjelobrojni tip podatka 
• **Definisati primarni ključ po uzoru na tabelu TitleAuthor baze Pub */
INSERT INTO Prodaja.Autori
SELECT A.au_id, A.au_lname, A.au_fname, A.phone, A.address, A.state, A.zip, A.contract
FROM pubs.dbo.authors AS A

SELECT * FROM Prodaja.Autori

INSERT INTO Prodaja.Knjige
SELECT t.title_id, t.title, t.type, t.pub_id ,t.price, ISNULL(t.notes, 'nepoznata vrijednost'), t.pubdate
FROM pubs.dbo.titles AS T

SELECT * FROM Prodaja.Knjige

INSERT INTO Prodaja.AutoriKnjige
SELECT ta.au_id, ta.title_id, ta.au_ord
FROM pubs.dbo.titleauthor AS TA

DELETE FROM Prodaja.AutoriKnjige

SELECT * FROM Prodaja.AutoriKnjige

/* U tabeli Autori nad kolonom Adresa promijeniti tip podatka na nvarchar (40) */

ALTER TABLE Prodaja.Autori
ALTER COLUMN Adersa NVARCHAR(40);

SELECT *
FROM Prodaja.Autori as A
WHERE A.Ime LIKE 'A%' or A.Ime LIKE 'S%'

SELECT * 
FROM Prodaja.Knjige as K
WHERE K.Cijena IS NULL

ALTER TABLE Prodaja.Izdavaci
ADD CONSTRAINT UQ_Naziv UNIQUE (pub_name)

USE Vjezba2
GO

SELECT * FROM Prodaja.Izdavaci

INSERT INTO Prodaja.Izdavaci
VALUES (0001, 'New Moon Books', 'Kakanj', 'MA', 'BIH')

SELECT * 
FROM sys.schemas 
WHERE name = 'Narudzbe';


SELECT *
INTO Narudzbe.Regije
FROM Northwind.dbo.Region;

SELECT * FROM Narudzbe.Regije

INSERT INTO Narudzbe.Regije
VALUES (7, 'NW')

SELECT *
INTO Narudzbe.StavkeNarudzbe
FROM Northwind.dbo.[Order Details]

SELECT * FROM Narudzbe.StavkeNarudzbe

ALTER TABLE Narudzbe.StavkeNarudzbe
ADD Ukupno DECIMAL(8,2)

UPDATE Narudzbe.StavkeNarudzbe
SET Ukupno=Quantity*UnitPrice

/* U tabeli StavkeNarduzbe dodati izračunatu kolonu CijeliDio(broj ispred decimalnog zareza) u kojoj 
će biti cijeli dio iz kolone UnitPrice */

ALTER TABLE Narudzbe.StavkeNarudzbe
ADD CijeliDioBroj AS FLOOR(UnitPrice) 

/* U tabeli StavkeNarduzbe kreirati ograničenje na koloni Discount kojim će se onemogućiti unos 
vrijednosti manjih od 0.  */

ALTER TABLE Narudzbe.StavkeNarudzbe 
ADD CONSTRAINT CK_Discount CHECK(Discount>=0)

INSERT INTO Narudzbe.StavkeNarudzbe(OrderID, ProductID, UnitPrice, Quantity, Discount)
VALUES (99901, 12, 15.00, 12.00, -2)

/* Kategorije 
• KategorijaID, cjelobrojna vrijednost, primarni ključ i autoinkrement 
• NazivKategorije, 15 UNICODE znakova (obavezan unos) 
• Opis, tekstualan UNICODE tip podatka */

CREATE TABLE Narudzbe.Kategorije 
(
	KategorijaID INT CONSTRAINT PK_Kategorija PRIMARY KEY IDENTITY(1,1),
	NazivKategorije NVARCHAR(15) NOT NULL,
	Opis NTEXT
)

/* 26. U kreiranu tabelu izvršiti insertovanje podataka iz tabele Categories baze Northwind */
SET IDENTITY_INSERT Narudzbe.Kategorije ON
INSERT INTO Narudzbe.Kategorije(KategorijaID, NazivKategorije, Opis)
SELECT C.CategoryID, c.CategoryName, c.Description
FROM Northwind.dbo.Categories as C
SET IDENTITY_INSERT Narudzbe.Kategorije OFF

/* U tabelu Kategorije insertovati novu kategoriju pod nazivom „Ncategory“ */
SELECT * FROM Narudzbe.Kategorije

SET IDENTITY_INSERT Narudzbe.Kategorije ON
INSERT INTO Narudzbe.Kategorije(KategorijaID, NazivKategorije, Opis)
VALUES(9, 'Ncategory', 'No category')
SET IDENTITY_INSERT Narudzbe.Kategorije OFF

UPDATE Narudzbe.Kategorije
SET Opis='bez opisa'
WHERE Opis is NULL

DELETE FROM
Narudzbe.Kategorije