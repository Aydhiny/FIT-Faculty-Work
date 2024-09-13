/* Zadatak .2 */

USE Northwind
SELECT OD.OrderID, OD.ProductID, OD.UnitPrice, 
ABS(OD.UnitPrice - (SELECT AVG(UnitPrice) FROM Northwind.dbo.[Order Details])) as 
PriceDifference
FROM dbo.[Order Details] as OD
ORDER BY PriceDifference ASC;

USE Northwind
SELECT OD.OrderID, OD.ProductID, OD.UnitPrice, 
(SELECT AVG(OD.UnitPrice) FROM [Order Details] AS OD) 'Prosjecna vrijednost', 
OD.UnitPrice - (SELECT AVG(OD.UnitPrice) FROM [Order Details] AS OD) 'Razlika'
FROM [Order Details] AS OD
ORDER BY 5 

/* Zadatak .3 */
USE Northwind
SELECT P.ProductID, P.ProductName, P.UnitsInStock,
P.UnitsInStock - (SELECT AVG(UnitsInStock) FROM dbo.Products) as RazlikaProizvoda
FROM dbo.Products as P
ORDER BY 4 DESC

/* Zadatak .4 */

USE AdventureWorks2017
SELECT * FROM
(SELECT TOP 5 P.FirstName + ' ' + P.LastName AS ImePrezime ,
E.BirthDate, YEAR(GETDATE()) - YEAR(E.BirthDate) as Starost, 
E.JobTitle, E.Gender
FROM HumanResources.Employee as E
INNER JOIN .Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.Gender = 'M'
ORDER BY Starost DESC) AS PODQ1
UNION
SELECT * FROM
(SELECT TOP 5 P.FirstName + ' ' + P.LastName AS ImePrezime ,
E.BirthDate, YEAR(GETDATE()) - YEAR(E.BirthDate) as Starost, 
E.JobTitle, E.Gender
FROM HumanResources.Employee as E
INNER JOIN .Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.Gender = 'F'
ORDER BY Starost DESC) AS PODQ2
ORDER BY PODQ1.Gender ASC, PODQ1.Starost DESC

/* ------------ */
SELECT *
FROM
(SELECT TOP 5 CONCAT(P.FirstName,' ',P.LastName) 'Ime i prezime', E.BirthDate,
	DATEDIFF(YEAR, E.BirthDate, GETDATE()) 'Starost', E.JobTitle, E.Gender
	FROM HumanResources.Employee AS E
	INNER JOIN Person.Person AS P ON E.BusinessEntityID=P.BusinessEntityID
	WHERE E.Gender='F'
	ORDER BY 3 DESC) AS PODQ1
UNION
SELECT *
FROM
(SELECT TOP 5 CONCAT(P.FirstName,' ',P.LastName) 'Ime i prezime', E.BirthDate,
	DATEDIFF(YEAR, E.BirthDate, GETDATE()) 'Starost', E.JobTitle, E.Gender
	FROM HumanResources.Employee AS E 
	INNER JOIN Person.Person AS P ON E.BusinessEntityID=P.BusinessEntityID
	WHERE E.Gender='M'
	ORDER BY 3 DESC) AS PODQ2
ORDER BY PODQ1.Gender ASC, PODQ1.Starost DESC

/* ZADATAK .5 */

USE AdventureWorks2017
SELECT TOP 3 E.JobTitle, E.HireDate, 
E.MaritalStatus, YEAR(GETDATE()) - 
YEAR(E.HireDate) AS Staz, 'Plaća dodatni porez' AS Porez
FROM HumanResources.Employee as E
WHERE E.JobTitle LIKE '%manager%' AND E.MaritalStatus = 'S'
		UNION
SELECT TOP 3 E.JobTitle, E.HireDate, 
E.MaritalStatus, YEAR(GETDATE()) - 
YEAR(E.HireDate) AS Staz, 'Ne placa porez' AS Porez
FROM HumanResources.Employee as E
WHERE E.JobTitle LIKE '%manager%'  AND E.MaritalStatus = 'M'
ORDER BY E.MaritalStatus ASC, Staz DESC

SELECT TOP 3 E.JobTitle, E.HireDate, E.MaritalStatus, 
DATEDIFF(YEAR, E.HireDate, GETDATE()) 'Godine staza', 'Placa dodatni porez' Porez
FROM HumanResources.Employee AS E
WHERE E.JobTitle LIKE '%manager%' AND E.MaritalStatus ='S'
UNION
SELECT TOP 3 E.JobTitle, E.HireDate, E.MaritalStatus, 
DATEDIFF(YEAR, E.HireDate, GETDATE()) 'Godine staza', 'Ne placa' Porez
FROM HumanResources.Employee AS E
WHERE E.JobTitle LIKE '%manager%' AND E.MaritalStatus ='M'
ORDER BY 3, 4 DESC

/* Zadatak .6 */
USE AdventureWorks2017
SELECT * FROM (SELECT TOP 5 P.FirstName + ' ' + P.LastName AS ImePrezime,
E.OrganizationLevel, DATEDIFF(YEAR, E.BirthDate, GETDATE())
as Starost, 'Ne prima' AS Prima, P.EmailPromotion 
FROM HumanResources.Employee as E
INNER JOIN Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE P.EmailPromotion = 0 AND 
(E.OrganizationLevel = 1 OR E.OrganizationLevel = 4)
ORDER BY 3 DESC) AS Q1
UNION
SELECT * FROM (
SELECT TOP 5 P.FirstName + ' ' + P.LastName AS ImePrezime,
E.OrganizationLevel, DATEDIFF(YEAR, E.BirthDate, GETDATE())
as Starost, 'Prima selektirane' AS Prima, P.EmailPromotion 
FROM HumanResources.Employee as E
INNER JOIN Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE P.EmailPromotion = 1 AND 
(E.OrganizationLevel = 1 OR E.OrganizationLevel = 4)
ORDER BY 3 DESC) AS Q2
UNION
SELECT * FROM (
SELECT TOP 5 P.FirstName + ' ' + P.LastName AS ImePrezime,
E.OrganizationLevel, DATEDIFF(YEAR, E.BirthDate, GETDATE())
as Starost, 'Prima' AS Prima, P.EmailPromotion 
FROM HumanResources.Employee as E
INNER JOIN Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE P.EmailPromotion = 2 AND 
(E.OrganizationLevel = 1 OR E.OrganizationLevel = 4)
ORDER BY 3 DESC) AS Q3
ORDER BY 2, 3
/* ------------ */

SELECT *
FROM
	(SELECT TOP 5 CONCAT(PP.FirstName, ' ', PP.LastName) 'Ime i prezime', E.OrganizationLevel, PP.EmailPromotion, DATEDIFF(YEAR, E.BirthDate, GETDATE()) 'Starost', 'Ne prima' Prima
	FROM HumanResources.Employee AS E
	INNER JOIN Person.Person AS PP ON E.BusinessEntityID=PP.BusinessEntityID
	WHERE (E.OrganizationLevel=1 OR E.OrganizationLevel=4) AND PP.EmailPromotion=0
	ORDER BY 4 DESC) AS A
UNION 
SELECT *
FROM
	(SELECT TOP 5 CONCAT(PP.FirstName, ' ', PP.LastName) 'Ime i prezime', E.OrganizationLevel, PP.EmailPromotion, 
	DATEDIFF(YEAR, E.BirthDate, GETDATE()) 'Starost', 'Prima selektirane' Prima
	FROM HumanResources.Employee AS E
	INNER JOIN Person.Person AS PP ON E.BusinessEntityID=PP.BusinessEntityID
	WHERE (E.OrganizationLevel=1 OR E.OrganizationLevel=4) AND PP.EmailPromotion=1
	ORDER BY 4 DESC) AS B
UNION 
SELECT *
FROM
	(SELECT TOP 5 CONCAT(PP.FirstName, ' ', PP.LastName) 'Ime i prezime', E.OrganizationLevel, PP.EmailPromotion, DATEDIFF(YEAR,	E.BirthDate, GETDATE()) 'Starost','Prima email promocije' Prima
	FROM HumanResources.Employee AS E
	INNER JOIN Person.Person AS PP ON E.BusinessEntityID=PP.BusinessEntityID
	WHERE (E.OrganizationLevel=1 OR E.OrganizationLevel=4) AND PP.EmailPromotion=2
	ORDER BY 4 DESC) AS C
ORDER BY 2 ,4 

/* Zadatak .7 */
USE AdventureWorks2017
SELECT SOH.SalesOrderID, 
FORMAT(SOH.OrderDate, 'dd.MM.yyyy') as OrderDate, 
FORMAT(SOH.ShipDate, 'dd.MM.yyyy') as ShipDate
FROM Sales.SalesOrderHeader as SOH
INNER JOIN .Sales.SalesTerritory as ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE ST.[Name] = 'Canada' AND (MONTH(SOH.ShipDate) = 7 
AND YEAR(SOH.ShipDate) = 2014) AND SOH.CreditCardID IS NULL

SELECT SOH.SalesOrderID, FORMAT(SOH.OrderDate,'dd.MM.yyyy') 'Order date', 
FORMAT(SOH.ShipDate,'dd.MM.yyyy') 'Ship date', SOH.ShipDate
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesTerritory AS ST ON ST.TerritoryID=SOH.TerritoryID
WHERE ST.Name LIKE 'Canada' AND YEAR(SOH.ShipDate)=2014 AND MONTH(SOH.ShipDate)=7 AND SOH.CreditCardID IS NULL

/* ZADATAK .8 */

USE AdventureWorks2017

SELECT 
Q1.MjesecNarudzbe,
MIN(Q1.Ukupna) as MinimalnaVR,
MAX(Q1.Ukupna) as MaxVR,
AVG(Q1.Ukupna) as Prosjecna
FROM (
SELECT SOH.SalesOrderID ,ROUND(SUM(SOD.OrderQty * SOD.UnitPrice), 2) as Ukupna,
MONTH(SOH.OrderDate) as MjesecNarudzbe
FROM Sales.SalesOrderDetail as SOD
INNER JOIN Sales.SalesOrderHeader as SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE YEAR(SOH.OrderDate) = 2013
GROUP BY SOH.SalesOrderID, MONTH(SOH.OrderDate)
)
AS Q1
GROUP BY Q1.MjesecNarudzbe
ORDER BY 1

/* ------------------- */
SELECT PODQ.Mjesec, AVG(PODQ.[Vrijednost narudžbe bez popusta]) 'Prosjek', 
MIN(PODQ.[Vrijednost narudžbe bez popusta]) 'Minimalna',
MAX(PODQ.[Vrijednost narudžbe bez popusta]) 'Maksimalna'
FROM (
	SELECT SOH.SalesOrderID, MONTH(SOH.OrderDate) 'Mjesec', 
	ROUND(SUM(SOD.UnitPrice*SOD.OrderQty),2) 'Vrijednost narudžbe bez popusta'
	FROM Sales.SalesOrderDetail AS SOD
	INNER JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID=SOH.SalesOrderID
	WHERE YEAR(SOH.OrderDate)=2013
	GROUP BY SOH.SalesOrderID, MONTH(SOH.OrderDate)
	) AS PODQ
GROUP BY PODQ.Mjesec
ORDER BY 1

/* ZADATAK .9 */

SELECT TOP 10 P.FirstName, P.LastName, 
SUBSTRING(E.LoginID, 
CHARINDEX('\', E.LoginID, 1) + 1, 
LEN(E.LoginID) - 
CHARINDEX('\', E.LoginID, 1) - 1) AS KorisnickoIme,
LEN(SUBSTRING(E.LoginID, 
CHARINDEX('\', E.LoginID, 1) + 1, 
LEN(E.LoginID) - 
CHARINDEX('\', E.LoginID, 1) - 1)) as DuzinaImena, 
E.JobTitle, FORMAT(E.HireDate, 
'dd.MM.yyyy') 
as DatumZaposlenja,
YEAR(GETDATE()) - YEAR(E.BirthDate) as Starost, 
YEAR(GETDATE()) - 
YEAR(E.HireDate) as Staz
FROM HumanResources.Employee as E
INNER JOIN Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
WHERE E.JobTitle LIKE '%manager%'
ORDER BY Starost DESC

/* ------------ */

SELECT TOP 10 CONCAT(PP.FirstName, ' ',PP.LastName) 'Ime i prezime', 
RIGHT(E.LoginID, CHARINDEX('\',REVERSE(E.LoginID))-1) 'Korisnicko ime', 
LEN(RIGHT(E.LoginID, CHARINDEX('\',REVERSE(E.LoginID))-1)) 'Dužina korisnickog imena', 
E.JobTitle, 
FORMAT(E.HireDate,'dd.MM.yyyy') 'Datum zaposlenja', 
DATEDIFF(YEAR,E.BirthDate,GETDATE()) 'Starost', 
DATEDIFF(YEAR, E.HireDate,GETDATE()) 'Staž'
FROM Person.Person AS PP
INNER JOIN HumanResources.Employee AS E ON E.BusinessEntityID=PP.BusinessEntityID
WHERE E.JobTitle LIKE '%Manager%'
ORDER BY 6 DESC

/* ZADATAK .10 */

USE AdventureWorks2017
SELECT PM.[Name], PD.[Description]
FROM Production.[Product] as P
INNER JOIN Production.ProductDescription as PD
ON P.ProductID = PD.ProductDescriptionID
INNER JOIN Production.ProductModel as PM
ON P.ProductModelID = PM.ProductModelID
WHERE PM.[Name] LIKE '%Mountain%'

SELECT PM.Name,PD.Description
FROM Production.ProductModel AS PM
INNER JOIN Production.ProductModelProductDescriptionCulture AS PMPDC ON PM.ProductModelID=PMPDC.ProductModelID
INNER JOIN Production.ProductDescription AS PD ON PD.ProductDescriptionID=PMPDC.ProductDescriptionID
INNER JOIN Production.Culture AS C ON C.CultureID=PMPDC.CultureID
WHERE C.Name LIKE 'English' AND PM.Name LIKE '%Mountain%'

/* ZADATAK .11 */

SELECT PP.ProductID, PP.Name, PP.ListPrice, PL.Name 'Lokacija', SUM(PI.Quantity) 'Stanje zaliha'
FROM Production.Product AS PP
INNER JOIN Production.ProductInventory AS PI ON PP.ProductID=PI.ProductID
INNER JOIN Production.Location AS PL ON PI.LocationID=PL.LocationID
INNER JOIN Production.ProductSubcategory AS PS ON PP.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC ON PS.ProductCategoryID=PC.ProductCategoryID
WHERE PC.Name LIKE 'Bikes'
GROUP BY PP.ProductID, PP.Name, PP.ListPrice, PL.Name
ORDER BY 5 DESC

/* Zadatak .12 */

SELECT P.FirstName, P.LastName, 
FORMAT(E.HireDate, 'dd.MM.yyyy') as Datum, 
EA.EmailAddress, 
ROUND(SUM(SOD.OrderQty * SOD.UnitPrice), 2) 
as 'Ukupno'
FROM HumanResources.Employee as E
INNER JOIN Person.Person as P
ON E.BusinessEntityID = P.BusinessEntityID
INNER JOIN Person.EmailAddress as EA
ON P.BusinessEntityID = EA.BusinessEntityID
INNER JOIN Sales.SalesPerson 
AS SP ON E.BusinessEntityID=SP.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader 
AS SOH ON SOH.SalesPersonID=SP.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail 
AS SOD ON SOD.SalesOrderID=SOH.SalesOrderID
INNER JOIN Sales.SalesTerritory 
AS ST ON SOH.TerritoryID=ST.TerritoryID
WHERE ST.[Group] LIKE '%Europe%' AND 
YEAR(SOH.ShipDate)=2014 AND MONTH(SOH.ShipDate)=1
GROUP BY P.FirstName, P.LastName, 
FORMAT(E.HireDate, 'dd.MM.yyyy'), 
EA.EmailAddress

SELECT TABLE_NAME, COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE COLUMN_NAME LIKE '%Country%' 
OR COLUMN_NAME LIKE '%Region%' 
OR COLUMN_NAME LIKE '%Territory%';