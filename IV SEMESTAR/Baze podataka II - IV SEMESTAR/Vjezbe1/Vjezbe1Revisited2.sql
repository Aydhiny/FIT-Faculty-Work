CREATE DATABASE ZadaciZaVjezbu

CREATE TABLE Aplikanti 
(
	Ime VARCHAR(40),
	Prezime VARCHAR(40),
	Mjesto_rodjenja VARCHAR(20)
)
ALTER TABLE Aplikanti
ADD AplikantID INT CONSTRAINT PK_Aplikanti PRIMARY KEY IDENTITY(1,1)

CREATE TABLE Projekti 
(
	NazivProjekta VARCHAR(40),
	AkronimProjekta VARCHAR(20),
	Svrha VARCHAR(20),
	Cilj VARCHAR(30),
)
ALTER TABLE Projekti
ADD SifraProjekta INT CONSTRAINT PK_Projekti PRIMARY KEY IDENTITY(1,1)

ALTER TABLE Aplikanti
ADD ProjekatID INT CONSTRAINT FK_Aplikanti FOREIGN KEY
REFERENCES Projekti(SifraProjekta)

CREATE TABLE TematskeOblasti
(
	TematskaOblastID INT CONSTRAINT PK_TO PRIMARY KEY IDENTITY (1,1),
	Naziv VARCHAR(20),
	Opseg VARCHAR(30),
	ProjekatID INT CONSTRAINT FK_TO FOREIGN KEY REFERENCES Projekti(SifraProjekta)
)

ALTER TABLE Aplikanti 
ADD email VARCHAR(30) NULL

ALTER TABLE Aplikanti
DROP COLUMN Mjesto_rodjenja

ALTER TABLE Aplikanti
ADD telefon VARCHAR(30) NOT NULL,
	JMBG VARCHAR(13) NOT NULL

DROP TABLE Aplikanti,
			Projekti,
			TematskeOblasti


use baza1
DROP DATABASE ZadaciZaVjezbu