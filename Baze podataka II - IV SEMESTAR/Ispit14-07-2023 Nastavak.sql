GO
USE ISPIT_14_07_2023

SELECT * 
FROM ZaglavljeNarudzbe

GO
CREATE OR ALTER FUNCTION f_detalji(@NarudzbaID INT)
RETURNS TABLE
AS
RETURN
	SELECT ZN.ImeKupca + ' ' + ZN.PrezimeKupca 
	as ImePrezime, ZN.NazivGradaIsporuke, 
	SUM(DN.Cijena * DN.Kolicina * (1- DN.Popust)) 
	as UkupnaVrijednost, IIF(ZN.KreditnaKarticaID IS NULL, 
	'Nije placeno karticom', 'Placeno') as Poruka
	FROM ZaglavljeNarudzbe as ZN
	INNER JOIN DetaljiNarudzbe as DN
	ON ZN.NarudzbaID = DN.NarudzbaID
	WHERE ZN.NarudzbaID = @NarudzbaID
	GROUP BY ZN.ImeKupca, ZN.PrezimeKupca, 
	ZN.NazivGradaIsporuke, ZN.KreditnaKarticaID
GO

SELECT *
FROM f_detalji(43660)

SELECT *
FROM DetaljiNarudzbe

GO
CREATE PROCEDURE sp_insert_DetaljiNarudzbe 
(
	@NarudzbaID INT,
	@ProizvodID INT,
	@Cijena MONEY,
	@Kolicina SMALLINT,
	@Popust REAL,
	@OpisSpecijalnePonude NVARCHAR(255)
)
AS
BEGIN
	INSERT INTO DetaljiNarudzbe
	VALUES(@NarudzbaID, @ProizvodID, @Cijena, @Kolicina, @Popust, 
	@OpisSpecijalnePonude)
END
GO

SELECT * FROM DetaljiNarudzbe

EXEC sp_insert_DetaljiNarudzbe 45165, 778, 10, 5, 0.1, 'Opis'
EXEC sp_insert_DetaljiNarudzbe 	
@NarudzbaID=43659, @ProizvodID=778, @Cijena=10, 
@Kolicina=5, @Popust=0.1, @OpisSpecijalnePonude='Neki opis'

USE AdventureWorks2017
SELECT PC.[Name], COUNT(*) as UkupanBrojProizvoda
FROM Production.ProductCategory as PC
INNER JOIN Production.ProductSubcategory as PCS
ON PC.ProductCategoryID = PCS.ProductCategoryID
INNER JOIN  Production.Product as P
ON PCS.ProductSubcategoryID = P.ProductSubcategoryID
WHERE LEN(REPLACE(P.[Name], ' ', '**')) - LEN(P.[Name]) = 2 AND 
P.[Name] LIKE '%[0-9]%' AND P.DiscontinuedDate IS NULL
GROUP BY PC.[Name]
HAVING COUNT(*) > 50

/* 4d */
USE AdventureWorks2017
SELECT P.[Name], SUM(SOD.OrderQty) as BrojKomada
FROM Production.Product as P
INNER JOIN Production.ProductSubcategory as PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory as PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
INNER JOIN Sales.SalesOrderDetail as SOD
ON P.ProductID = SOD.ProductID
WHERE P.SellEndDate IS NOT NULL AND PC.Name NOT LIKE 'Bikes'
GROUP BY P.[Name]
HAVING SUM(SOD.OrderQty) > 200

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

/* 4e */

USE AdventureWorks2017
SELECT SOH.SalesOrderID, PP.FirstName + ' ' + 
PP.LastName as ImePrezime, SUM(SOH.TotalDue) as UkupnaNarudzbe
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.Customer as C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person as PP
ON C.PersonID = PP.BusinessEntityID
WHERE DATEDIFF(DAY, SOH.OrderDate, SOH.ShipDate) < 
(
	SELECT AVG(DATEDIFF(DAY, SOH.OrderDate, SOH.ShipDate))
	FROM Sales.SalesOrderHeader as SOH
)
GROUP BY SOH.SalesOrderID, PP.FirstName,
PP.LastName

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


-- 5a

USE pubs
SELECT T.title, SUM(S.qty) as ProdanaKolicina
FROM dbo.titles as T
INNER JOIN dbo.sales as S
ON T.title_id = S.title_id
WHERE T.title_id IN 
(
	SELECT TA.title_id
	FROM titleauthor as TA
	WHERE TA.au_id IN 
	(
		SELECT TA.au_id
		FROM titleauthor as TA
		GROUP BY TA.au_id
		HAVING COUNT(*) >= 2
	)
)
GROUP BY T.title
HAVING SUM(S.qty) > 30

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

-- 5 b

USE AdventureWorks2017
SELECT PQ1.Name, PQ1.UkupnoNarudzbi, PQ1.UkupnoNarudzbi * 1.0 / 
(SELECT COUNT(*) FROM Sales.SalesOrderHeader) * 100 as 'Ukupno u %'
FROM (
SELECT ST.[Name], COUNT(*) AS UkupnoNarudzbi
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID = ST.TerritoryID
GROUP BY  ST.[Name]
) AS PQ1

USE AdventureWorks2017
SELECT PODQ.Name, PODQ.[Ukupno isporučen broj narudžbi],
(PODQ.[Ukupno isporučen broj narudžbi]*1.0/(SELECT COUNT(*)FROM Sales.SalesOrderHeader))*100 'Ukupan broj %'
FROM(SELECT T.Name, COUNT(*) 'Ukupno isporučen broj narudžbi'
	 FROM Sales.SalesOrderHeader AS SOH
	 INNER JOIN Sales.SalesTerritory AS T
	 ON SOH.TerritoryID=T.TerritoryID
	 GROUP BY T.Name) AS PODQ