CREATE DATABASE IB220088_2

GO
USE IB220088_2

CREATE TABLE Uposlenici 
(
	UposlenikID CHAR(9) CONSTRAINT PK_Uposlenik 
	PRIMARY KEY,
	Ime VARCHAR(20) NOT NULL,
	Prezime VARCHAR(20) NOT NULL,
	DatumZaposlenja DATETIME NOT NULL,
	OpisPosla VARCHAR(50) NOT NULL
)
CREATE TABLE Naslovi
(
	NaslovID VARCHAR(6) PRIMARY KEY,
	Naslov VARCHAR(80) NOT NULL,
	Tip CHAR(12) NOT NULL,
	Cijena MONEY,
	NazivIzdavaca VARCHAR(40),
	GradIzdavaca VARCHAR(20),
	DrzavaIzdavaca VARCHAR(30),
)

CREATE TABLE Prodavnice 
(
	ProdavnicaID CHAR(4) CONSTRAINT PK_Prodavnice PRIMARY KEY,
	NazivProdavnice VARCHAR(40),
	Grad VARCHAR(40)
)
CREATE TABLE Prodaja 
(
	ProdavnicaID CHAR(4) CONSTRAINT FK_Prodaja FOREIGN KEY
	REFERENCES Prodavnice(ProdavnicaID),
	BrojNarudzbe VARCHAR(20),
	NaslovID VARCHAR(6) CONSTRAINT FK_Naslovi FOREIGN KEY
	REFERENCES Naslovi(NaslovID),
	DatumNarudzbe DATETIME NOT NULL,
	Kolicina SMALLINT NOT NULL,
	CONSTRAINT PK_Prodaja PRIMARY KEY(ProdavnicaID, BrojNarudzbe, NaslovID)
)

INSERT INTO Uposlenici(UposlenikID, Ime, Prezime, DatumZaposlenja, OpisPosla)
SELECT E.emp_id, E.fname, E.lname, E.hire_date, J.job_desc
FROM pubs.dbo.employee as E
INNER JOIN pubs.dbo.jobs as J
ON E.job_id = J.job_id

SELECT *
FROM Uposlenici


INSERT INTO Naslovi(NaslovID, Naslov, Tip, Cijena, NazivIzdavaca, 
GradIzdavaca, DrzavaIzdavaca)
SELECT T.title_id, T.title, T.[type], T.price, P.pub_name, P.city, P.country
FROM pubs.dbo.titles as T
INNER JOIN pubs.dbo.publishers as P
ON T.pub_id = P.pub_id

INSERT INTO Prodavnice(ProdavnicaID, NazivProdavnice)
SELECT S.stor_id, S.stor_name
FROM pubs.dbo.stores as S

INSERT INTO Prodaja(ProdavnicaID, BrojNarudzbe, NaslovID, DatumNarudzbe, Kolicina)
SELECT S.stor_id, S.ord_num, S.title_id, S.ord_date, S.qty
FROM pubs.dbo.stores as SS
INNER JOIN pubs.dbo.sales as S
ON SS.stor_id = S.stor_id

SELECT *
FROM Prodaja

GO
CREATE PROCEDURE sp_update_naslov 
(
	@NaslovID VARCHAR(6),
	@Naslov VARCHAR(80)=NULL,
	@Tip CHAR(12)=NULL,
	@Cijena MONEY=NULL,
	@NazivIzdavaca VARCHAR(40)=NULL,
	@GradIzdavaca VARCHAR(20)=NULL,
	@DrzavaIzdavaca VARCHAR(30)=NULL
)
AS
BEGIN
UPDATE Naslovi
SET NaslovID=ISNULL(@NaslovID, NaslovID),
	Naslov=ISNULL(@Naslov, Naslov),
	Tip=ISNULL(@Tip, Tip),
	Cijena=ISNULL(@Cijena, Cijena),
	NazivIzdavaca=ISNULL(@NazivIzdavaca, NazivIzdavaca),
	GradIzdavaca=ISNULL(@GradIzdavaca, GradIzdavaca),
	DrzavaIzdavaca=ISNULL(@DrzavaIzdavaca, DrzavaIzdavaca)
	WHERE @NaslovID = NaslovID
END

EXEC sp_update_naslov BU1032, 'new t'

SELECT *
FROM Naslovi

CREATE INDEX IX_Naslovi_Naslov
ON
Naslovi(Naslov)

SELECT Naslov
FROM Naslovi as N