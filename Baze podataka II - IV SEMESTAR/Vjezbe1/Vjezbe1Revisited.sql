CREATE DATABASE ZadaciZaVjezbu

USE ZadaciZaVjezbu

CREATE TABLE Aplikanti 
(
	Ime VARCHAR(50),
	Prezime VARCHAR(50),
	Mjesto_rodjenja VARCHAR(40)
)

ALTER TABLE Aplikanti 
ADD AplikantiID INT CONSTRAINT PK_Aplikanti 
PRIMARY KEY IDENTITY(1,1)

GO
USE ZadaciZaVjezbu

CREATE TABLE Projekti
(
	NazivProjekta VARCHAR(50),
	AkronimProjekta VARCHAR(20),
	SvrhaProjekta VARCHAR(40),
	CiljProjekta VARCHAR(20),
)

ALTER TABLE Projekti ADD SifraProjekta 
INT CONSTRAINT PK_Projekti PRIMARY KEY IDENTITY(1,1)

ALTER TABLE Aplikanti ADD ProjekatID INT CONSTRAINT FK_Projekti FOREIGN
KEY REFERENCES Projekti(SifraProjekta) 

GO 
USE ZadaciZaVjezbu

CREATE TABLE TematskeOblasti
(
	TematskaOblastID INT CONSTRAINT PK_TO 
	PRIMARY KEY IDENTITY(1,1),
	Naziv VARCHAR(50) NOT NULL,
	Opseg VARCHAR(20) NOT NULL,
)

ALTER TABLE Aplikanti ADD email VARCHAR(20)

ALTER TABLE Aplikanti
DROP COLUMN Mjesto_rodjenja

ALTER TABLE Aplikanti 
ADD JMBG VARCHAR(13) NOT NULL

DROP TABLE Aplikanti
DROP TABLE TematskeOblasti
DROP TABLE Projekti

use baza1
DROP DATABASE ZadaciZaVjezbu