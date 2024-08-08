CREATE DATABASE ZadaciZaVjezbu

CREATE TABLE Aplikanti
(
	Ime NVARCHAR(50),
	Prezime NVARCHAR(50),
	Mjesto_rodjenja NVARCHAR(50)
)

ALTER TABLE Aplikanti 
ADD AplikantID INT CONSTRAINT PK_Aplikanti PRIMARY KEY IDENTITY(1,1)

GO
USE ZadaciZaVjezbu

CREATE TABLE Projekti 
(
	Naziv_projekta NVARCHAR(20) NOT NULL,
	Akronim_projekta NVARCHAR(20) NOT NULL,
	Svrha_projekta NVARCHAR(15) NOT NULL,
	Cilj_projekta NVARCHAR(20)
)

ALTER TABLE Projekti
ADD Sifra_projekta INT CONSTRAINT PK_Projekat PRIMARY KEY IDENTITY(1,1)

ALTER TABLE Aplikanti
ADD Sifra_projekta INT CONSTRAINT PK_Projekat_Aplikant FOREIGN KEY REFERENCES Projekti(Sifra_projekta)


CREATE TABLE TematskaOblasti 
(
	tematskaOblastID INT CONSTRAINT PK_TematskaOblast PRIMARY KEY IDENTITY(1,1),
	naziv NVARCHAR(50) NOT NULL,
	opseg NVARCHAR(20) NOT NULL
)
ALTER TABLE Projekti
ADD tematskaOblastID INT CONSTRAINT FK_Projekti_TematskaOblast FOREIGN KEY REFERENCES TematskaOblasti(TematskaOblastID)

ALTER TABLE Aplikanti
ADD email NVARCHAR(20) NULL

ALTER TABLE Aplikanti
DROP COLUMN Mjesto_rodjenja

ALTER TABLE Aplikanti
ADD maticni_broj NVARCHAR(25) NOT NULL

DROP TABLE Aplikanti;
DROP TABLE Projekti;
DROP TABLE TematskaOblasti;

DROP DATABASE ZadaciZaVjezbu

GO 
USE baza1
