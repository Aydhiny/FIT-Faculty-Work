CREATE DATABASE Function_
GO
USE Function_

SELECT *
INTO Zaposlenici
FROM pubs.dbo.employee

SELECT * FROM Zaposlenici

ALTER TABLE Zaposlenici
ADD GodinaZaposlenja AS YEAR(hire_date)

GO
CREATE FUNCTION f_ocjena (@brojBodova INT) 
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @poruka VARCHAR(50)
	SET @poruka = 'nedovoljan broj bodova'
	IF @brojBodova BETWEEN 55 AND 64 SET @poruka = 'šest (6)'
	IF @brojBodova BETWEEN 65 AND 74 SET @poruka = 'sedam (7)'
	IF @brojBodova BETWEEN 75 AND 84 SET @poruka = 'osam (8)'
	IF @brojBodova BETWEEN 85 AND 94 SET @poruka = 'devet (9)'
	IF @brojBodova BETWEEN 95 AND 100 SET @poruka = 'deset (10)'
	IF @brojBodova>100 SET @poruka = 'fatal error'
	RETURN @poruka
END
GO

SELECT dbo.f_ocjena(55),dbo.f_ocjena(40),dbo.f_ocjena(80)