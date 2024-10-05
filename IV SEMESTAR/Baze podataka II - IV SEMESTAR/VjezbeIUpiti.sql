USE AdventureWorks2017
SELECT TOP 1 SOH.SalesOrderID, 
P.FirstName + ' '  + P.LastName as ImePrezime, A.City
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.Customer as C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID = ST.TerritoryID
INNER JOIN Person.Address AS A
ON SOH.ShipToAddressID = A.AddressID
WHERE ST.[Group] = 'Europe' AND SOH.CreditCardID IS NOT NULL
ORDER BY SOH.TotalDue ASC

SELECT TOP 1
	sod.SalesOrderID,
	CONCAT(p.FirstName, ' ', p.LastName) ImePrezime,
	a.City
FROM AdventureWorks2017.Person.Person AS p
INNER JOIN AdventureWorks2017.Sales.Customer AS c
ON p.BusinessEntityID=c.PersonID
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS sod
ON sod.CustomerID=c.CustomerID
INNER JOIN AdventureWorks2017.Sales.SalesTerritory AS st
ON sod.TerritoryID=st.TerritoryID
INNER JOIN AdventureWorks2017.Person.Address AS a
ON sod.ShipToAddressID=a.AddressID
WHERE sod.CreditCardID IS NOT NULL AND st.[Group] = 'Europe'
ORDER BY sod.TotalDue

USE AdventureWorks2017
SELECT COUNT(*) as BrojProizvoda, SOP.SpecialOfferID
FROM Production.Product as PP
INNER JOIN Production.ProductSubcategory as PSC
ON PP.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory as PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
INNER JOIN Sales.SpecialOfferProduct as SOP
ON PP.ProductID = SOP.ProductID
WHERE PC.Name = 'Clothing' AND PP.ProductModelID IS NOT NULL
GROUP BY SOP.SpecialOfferID

SELECT 
	sop.SpecialOfferID,
	COUNT(p.ProductID) BrojProizvoda
FROM AdventureWorks2017.Production.Product AS p
INNER JOIN AdventureWorks2017.Sales.SpecialOfferProduct AS sop
ON p.ProductID=sop.ProductID
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID=psc.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory AS pc
ON psc.ProductCategoryID=pc.ProductCategoryID
WHERE pc.Name='Clothing' AND p.ProductModelID IS NOT NULL
GROUP BY sop.SpecialOfferID

use AdventureWorks2017
SELECT TOP 5 Q1.CustomerID, Q1.OrderCount
FROM 
(
	SELECT SOH.CustomerID, COUNT(*) as OrderCount
	FROM Sales.SalesOrderHeader as SOH
	WHERE YEAR(SOH.OrderDate) IN (2011, 2012)
	GROUP BY SOH.CustomerID
	HAVING SOH.CustomerID IN 
	(
		SELECT TOP 30 PERCENT SOH2.CustomerID
		FROM Sales.SalesOrderHeader AS SOH2
		WHERE YEAR(SOH2.OrderDate) IN (2011, 2012)
		ORDER BY SOH2.OrderDate DESC
	)
) AS Q1
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT SOH.CustomerID
FROM Sales.SalesOrderHeader AS SOH
WHERE YEAR(SOH.OrderDate) = 2012
GROUP BY SOH.CustomerID
HAVING COUNT(DISTINCT MONTH(SOH.OrderDate)) >= 5

USE AdventureWorks2017
SELECT TOP 5 SOH.SalesOrderID, COUNT(DISTINCT SOD.ProductID) 
AS NaruceniProizvodi
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT TOP 1 SOD.ProductID, SUM(SOD.OrderQty) as ProdanaKolicina
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE YEAR(SOH.OrderDate) = 2011
GROUP BY SOD.ProductID
ORDER BY 2 DESC

SELECT TOP 1 
	sod.ProductID, 
	SUM(sod.OrderQty) ProdanaKolicina
FROM AdventureWorks2017.Sales.SalesOrderDetail AS sod
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS soh
ON sod.SalesOrderID=soh.SalesOrderID
WHERE YEAR(soh.OrderDate)=2011
GROUP BY sod.ProductID
ORDER BY SUM(sod.OrderQty) DESC

USE AdventureWorks2017
SELECT SO.SpecialOfferID, COUNT(SOP.ProductID) 
AS UkupnoProizvoda
FROM Sales.SpecialOfferProduct AS SOP
INNER JOIN Sales.SpecialOffer AS SO
ON SOP.SpecialOfferID = SO.SpecialOfferID
GROUP BY SO.SpecialOfferID

SELECT 
	sp.SpecialOfferID, 
	COUNT(p.ProductID) BrojProizvoda
FROM AdventureWorks2017.Sales.SpecialOfferProduct AS sp
INNER JOIN AdventureWorks2017.Production.Product AS p
ON sp.ProductID=p.ProductID
INNER JOIN AdventureWorks2017.Production.ProductSubcategory AS psc
ON p.ProductSubcategoryID=psc.ProductSubcategoryID
INNER JOIN AdventureWorks2017.Production.ProductCategory AS pc
ON psc.ProductCategoryID=pc.ProductCategoryID
WHERE pc.Name LIKE 'Clothing'
GROUP BY sp.SpecialOfferID

use AdventureWorks2017
SELECT PP.FirstName, PP.LastName, SOH.SalesOrderID, 
ROUND(SUM(SOH.TotalDue),2) as Ukupno
FROM Person.Person AS PP
INNER JOIN Sales.Customer AS C
ON PP.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
GROUP BY PP.FirstName, PP.LastName, SOH.SalesOrderID