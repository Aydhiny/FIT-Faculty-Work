CREATE DATABASE Vjezba2Copy

GO
USE Vjezba2Copy

CREATE SCHEMA Prodaja
GO

CREATE TABLE Prodaja.Autori 
(
	AutorID VARCHAR(11) CONSTRAINT PK_Autori PRIMARY KEY,
	Prezime VARCHAR(40) NOT NULL,
	Ime VARCHAR(20) NOT NULL,
	Telefon CHAR(12) DEFAULT('nepoznata vrijednost'),
	Adresa VARCHAR(40),
	SaveznaDrzava CHAR(2),
	PostanskiBroj CHAR(5),
	Ugovor BIT NOT NULL
)

CREATE TABLE Prodaja.Knjige 
(
	KnjigaID VARCHAR(6) CONSTRAINT PK_Knjiga PRIMARY KEY,
	Naziv VARCHAR(80) NOT NULL,
	Vrsta CHAR(12) NOT NULL,
	IzdavacID CHAR(4),
	Cijena MONEY,
	Biljeska VARCHAR(200),
	Datum DATETIME,
)
CREATE TABLE Prodaja.Izdavaci (
    IzdavacID INT PRIMARY KEY,         -- Publisher ID
    Naziv NVARCHAR(100),               -- Publisher Name
    Grad NVARCHAR(50),                 -- City
    Drzava NVARCHAR(50),               -- State
    PostanskiBroj NVARCHAR(20)         -- Postal Code
);

INSERT INTO Prodaja.Izdavaci(IzdavacID, Naziv, Grad, 
Drzava, PostanskiBroj)
SELECT P.pub_id, p.pub_name, p.city, p.country, p.[state]
FROM pubs.dbo.publishers as P

SELECT * FROM Prodaja.Izdavaci
SELECT * FROM pubs.dbo.publishers

ALTER TABLE Prodaja.Knjige 
ADD CONSTRAINT FK_izdavaci FOREIGN KEY(IzdavacID) 
REFERENCES Prodaja.Izdavaci(IzdavacID)