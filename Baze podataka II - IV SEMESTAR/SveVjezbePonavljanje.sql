USE AdventureWorks2017
SELECT E.LoginID, SUBSTRING(E.LoginID, 
CHARINDEX('\', E.LoginID) + 1, LEN(E.loginID) - 
CHARINDEX('\', E.LoginID) - 1) as Ime, 
STUFF(SUBSTRING(REVERSE(E.rowguid), 6, 7), 2, 2, 'X#') as Lozinka
FROM HumanResources.Employee AS E


USE AdventureWorks2017
SELECT C.AccountNumber, REPLACE(C.AccountNumber, '0', '') as BezNula
FROM Sales.Customer AS C

USE Northwind
SELECT O.ShipCountry, SUM(O.Freight) as UkupniTrosak
FROM dbo.orders as O
WHERE O.ShipCountry IN 
('France', 'Germany', 'Switzerland') 
GROUP BY O.ShipCountry
HAVING SUM(O.Freight) > 4000

USE Northwind
SELECT TOP 10 OD.ProductID, SUM(OD.Quantity) as Ukupno
FROM dbo.[Order Details] as OD
GROUP BY OD.ProductID
ORDER BY 2 DESC

use AdventureWorks2017
SELECT SOD.ProductID,
ROUND(SUM(SOD.LineTotal), 2) as UkupnaSPopustom,
ROUND(SUM(SOD.OrderQty * SOD.UnitPrice), 2) as UkupnaBezPopusta
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.UnitPriceDiscount > 0
GROUP BY SOD.ProductID
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT SOD.ProductID, 
ROUND(SUM(SOD.OrderQty*SOD.UnitPrice), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL(18, 2))'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.UnitPriceDiscount>0
GROUP BY SOD.ProductID
ORDER BY 3 DESC

USE PUBS
SELECT D.discounttype, s.stor_name, s.stor_id
FROM dbo.discounts as D
INNER JOIN dbo.stores as s
on D.stor_id = s.stor_id

USE pubs
SELECT D.discounttype, S.stor_name, S.stor_id
FROM discounts AS D
INNER JOIN stores AS S
ON D.stor_id=S.stor_id

use AdventureWorks2017
SELECT ST.[Name], COUNT(*) as UkupnoNarudzbi
FROM Sales.SalesTerritory as ST
INNER JOIN Sales.SalesOrderHeader AS SOH
ON ST.TerritoryID = SOH.TerritoryID
GROUP BY ST.[Name]
HAVING COUNT(*) > 1000

SELECT ST.Name, COUNT(*) 'Ukupan broj narudžbi'
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
HAVING COUNT(*) >1000

USE AdventureWorks2017
SELECT P.[Name], SUM(SOD.LineTotal) 
AS 'Ukupno s popustom', 
SUM(SOD.OrderQty * SOD.UnitPrice) as 'Ukupno bez'
FROM Production.Product as P
INNER JOIN Sales.SalesOrderDetail AS SOD
ON P.ProductID = SOD.ProductID
WHERE SOD.UnitPriceDiscount > 0
GROUP BY P.[Name]
order by 2 desc

SELECT PP.Name,
ROUND(SUM(SOD.UnitPrice*SOD.OrderQty), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL (18,2)) 'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Production.Product AS PP
ON PP.ProductID=SOD.ProductID
WHERE SOD.UnitPriceDiscount>0
GROUP BY PP.Name
ORDER BY 3 DESC 

USE Northwind
SELECT OD.OrderID, OD.ProductID, OD.UnitPrice, 
OD.UnitPrice - 
(
	SELECT AVG(OD2.UnitPrice)
	FROM dbo.[Order Details] as OD2
) as RazlikaCijene
FROM dbo.[Order Details] as OD
ORDER BY 4 

USE Northwind
SELECT OD.OrderID, OD.ProductID, OD.UnitPrice, 
(SELECT AVG(OD.UnitPrice) FROM [Order Details] AS OD) 'Prosjecna vrijednost', 
OD.UnitPrice - (SELECT AVG(OD.UnitPrice) FROM [Order Details] AS OD) 'Razlika'
FROM [Order Details] AS OD
ORDER BY 5 

USE AdventureWorks2017
SELECT TOP 5 PP.FirstName + ' ' + PP.LastName 
as ImePrezime, E.BirthDate, YEAR(GETDATE()) - YEAR(E.BirthDate) 
as GodineStarosti, E.JobTitle, E.Gender
FROM Person.Person AS PP
INNER JOIN HumanResources.Employee as E
on PP.BusinessEntityID = E.BusinessEntityID
ORDER BY 3 DESC

use AdventureWorks2017
SELECT TOP 3 E.JobTitle, E.HireDate, E.MaritalStatus,
YEAR(GETDATE()) - YEAR(E.HireDate) AS Staz, 'ne placa' as Porez
FROM HumanResources.Employee as E
WHERE E.JobTitle LIKE '%Manager%' 
AND E.MaritalStatus = 'M'
UNION
SELECT TOP 3 E.JobTitle, E.HireDate, E.MaritalStatus,
YEAR(GETDATE()) - YEAR(E.HireDate) AS Staz, 'Placa porez' as Porez
FROM HumanResources.Employee as E
WHERE E.JobTitle LIKE '%Manager%' 
AND E.MaritalStatus = 'S'
ORDER BY 3, 4 DESC

USE AdventureWorks2017
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

USE AdventureWorks2017
SELECT TOP 5 YEAR(GETDATE()) - YEAR(E.BirthDate) as Godine, PP.FirstName + ' ' +  PP.LastName 
AS ImePrezime, E.OrganizationLevel, 
PP.EmailPromotion, IIF(PP.EmailPromotion = 1,'Prima','Ne prima') as Poruka
FROM Person.Person AS PP
INNER JOIN HumanResources.Employee AS E
ON PP.BusinessEntityID = E.BusinessEntityID
WHERE E.OrganizationLevel IN (2, 4) AND PP.EmailPromotion = 0
UNION
SELECT TOP 5 YEAR(GETDATE()) - YEAR(E.BirthDate) as Godine, PP.FirstName + ' ' +  PP.LastName 
AS ImePrezime, E.OrganizationLevel, 
PP.EmailPromotion, IIF(PP.EmailPromotion = 1,'Prima','Ne prima') as Poruka
FROM Person.Person AS PP
INNER JOIN HumanResources.Employee AS E
ON PP.BusinessEntityID = E.BusinessEntityID
WHERE E.OrganizationLevel IN (2, 4) AND PP.EmailPromotion = 1
UNION
SELECT TOP 5 YEAR(GETDATE()) - YEAR(E.BirthDate) as Godine, PP.FirstName + ' ' +  PP.LastName 
AS ImePrezime, E.OrganizationLevel, 
PP.EmailPromotion, IIF(PP.EmailPromotion = 1,'Prima','Ne prima') as Poruka
FROM Person.Person AS PP
INNER JOIN HumanResources.Employee AS E
ON PP.BusinessEntityID = E.BusinessEntityID
WHERE E.OrganizationLevel IN (2, 4) AND PP.EmailPromotion = 2
ORDER BY 3, 5 DESC

USE AdventureWorks2017
SELECT P.ProductID, P.Name, P.ListPrice, 
SUM(PI.Quantity) AS UkupnaKolicina, L.Name
FROM Production.Product as P
INNER JOIN Production.ProductInventory AS PI
ON P.ProductID = PI.ProductID
INNER JOIN Production.Location AS L
ON PI.LocationID = L.LocationID
INNER JOIN Production.ProductSubcategory as PSC
ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC
ON PSC.ProductCategoryID = PC.ProductCategoryID
WHERE PC.Name = 'Bikes'
GROUP BY P.ProductID, P.Name, P.ListPrice, L.Name
ORDER BY 4 DESC

SELECT PP.ProductID, PP.Name, PP.ListPrice, PL.Name 'Lokacija', SUM(PI.Quantity) 'Stanje zaliha'
FROM Production.Product AS PP
INNER JOIN Production.ProductInventory AS PI ON PP.ProductID=PI.ProductID
INNER JOIN Production.Location AS PL ON PI.LocationID=PL.LocationID
INNER JOIN Production.ProductSubcategory AS PS ON PP.ProductSubcategoryID=PS.ProductSubcategoryID
INNER JOIN Production.ProductCategory AS PC ON PS.ProductCategoryID=PC.ProductCategoryID
WHERE PC.Name LIKE 'Bikes'
GROUP BY PP.ProductID, PP.Name, PP.ListPrice, PL.Name
ORDER BY 5 DESC

USE AdventureWorks2017
SELECT p.FirstName + ' ' + 
p.LastName as ImePrezime, 
FORMAT(E.HireDate, 'dd.MM.yyyy') as Datum, EA.EmailAddress,
ROUND(SUM(SOD.OrderQty * SOD.UnitPrice), 2) as UkupnoBezPopusta
FROM Person.Person as p
INNER JOIN HumanResources.Employee AS E
ON p.BusinessEntityID = E.BusinessEntityID
INNER JOIN Person.EmailAddress AS EA
ON p.BusinessEntityID = EA.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON E.BusinessEntityID = SOH.SalesPersonID
inner join Sales.SalesTerritory as ST
ON SOH.TerritoryID = ST.TerritoryID	
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
WHERE (MONTH(SOH.OrderDate) = 1 AND YEAR(SOH.OrderDate) = 2014)
AND ST.[Group] = 'Europe'
GROUP BY p.FirstName, p.LastName, 
FORMAT(E.HireDate, 'dd.MM.yyyy'), EA.EmailAddress
ORDER BY 4 DESC

SELECT CONCAT(PP.FirstName, ' ', PP.LastName) 'Ime i prezime zaposlenika', FORMAT(E.HireDate,'dd.MM.yyyy') 'Datum zaposlenja',E.HireDate,EA.EmailAddress,SUM(SOD.UnitPrice*SOD.OrderQty)'Ukupna zarada'
FROM HumanResources.Employee AS E
INNER JOIN Person.Person AS PP ON E.BusinessEntityID=PP.BusinessEntityID
INNER JOIN Person.EmailAddress AS EA ON PP.BusinessEntityID=EA.BusinessEntityID
INNER JOIN Sales.SalesPerson AS SP ON E.BusinessEntityID=SP.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader AS SOH ON SOH.SalesPersonID=SP.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail AS SOD ON SOD.SalesOrderID=SOH.SalesOrderID
INNER JOIN Person.Address AS A ON SOH.ShipToAddressID=A.AddressID
INNER JOIN Person.StateProvince AS SPP ON A.StateProvinceID=SPP.StateProvinceID
INNER JOIN Sales.SalesTerritory AS ST ON SPP.TerritoryID=ST.TerritoryID
WHERE ST.[Group]='Europe' AND YEAR(SOH.ShipDate)=2014 AND MONTH(SOH.ShipDate)=1
GROUP BY CONCAT(PP.FirstName, ' ', PP.LastName),
FORMAT(E.HireDate,'dd.MM.yyyy'), E.HireDate, EA.EmailAddress
ORDER BY [Ukupna zarada] DESC














---------------- VJEŽBA 7 ----------------


USE AdventureWorks2017
SELECT p.FirstName, p.LastName, CC.CardType, 
CC.CardNumber, SUM(SOH.TotalDue) as UkupanIznos
FROM Person.Person as p
INNER JOIN Sales.PersonCreditCard AS PCC
ON p.BusinessEntityID = PCC.BusinessEntityID
INNER JOIN Sales.CreditCard AS CC
ON PCC.CreditCardID = CC.CreditCardID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON CC.CreditCardID = SOH.CreditCardID
GROUP BY p.FirstName, p.LastName, CC.CardType, 
CC.CardNumber
HAVING COUNT(SOH.SalesOrderID) > 20
ORDER BY 5 DESC

SELECT PP.FirstName+' '+PP.LastName 'Ime i prezime', CC.CardType 'Tip kartice', CC.CardNumber 'Broj kartice',
ROUND( SUM(SOH.TotalDue),2) 'Ukupan iznos'
FROM Person.Person AS PP
	INNER JOIN Sales.PersonCreditCard AS PCC ON PP.BusinessEntityID=PCC.BusinessEntityID
	INNER JOIN Sales.CreditCard AS CC ON PCC.CreditCardID=CC.CreditCardID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON CC.CreditCardID=SOH.CreditCardID
GROUP BY PP.FirstName,PP.LastName , CC.CardType , CC.CardNumber 
HAVING COUNT(*)>20
ORDER BY 4 DESC

---------------- VJEŽBA 8 ----------------

USE pubs
SELECT E.fname, E.lname, YEAR(GETDATE()) - 
YEAR(E.hire_date) as GodStaza, J.job_desc, 
COUNT(*) as BrojKnjiga
FROM dbo.employee as E
INNER JOIN dbo.jobs AS J
ON E.job_id = J.job_id
INNER JOIN dbo.publishers AS P
ON E.pub_id = P.pub_id
INNER JOIN dbo.titles as T
ON P.pub_id = T.pub_id
WHERE YEAR(GETDATE()) - 
YEAR(E.hire_date) > 31
GROUP BY E.fname, E.lname, YEAR(GETDATE()) - 
YEAR(E.hire_date), J.job_desc
HAVING COUNT(*) > 
(
	SELECT COUNT(*)
	FROM dbo.titles as T1
	WHERE T1.pub_id = 0736
)
ORDER BY 3, 5 DESC

SELECT CONCAT(E.fname, ' ', E.lname) 'Ime i prezime', DATEDIFF(YEAR, E.hire_date, GETDATE()) 'Staž', J.job_desc 'Opis posla', COUNT(*) 'Broj naslova'
FROM employee AS E
	INNER JOIN jobs AS J ON E.job_id=J.job_id
	INNER JOIN publishers AS P ON E.pub_id=P.pub_id
	INNER JOIN titles AS T ON P.pub_id=T.pub_id
WHERE DATEDIFF(YEAR, E.hire_date, GETDATE())>31 
GROUP BY CONCAT(E.fname, ' ', E.lname), DATEDIFF(YEAR, E.hire_date, GETDATE()), J.job_desc
HAVING COUNT(*)>
				(SELECT COUNT(*)
				 FROM titles AS T
				 WHERE T.pub_id=0736)
ORDER BY 2, 4 DESC
GO

USE pubs
SELECT e.fname, e.lname, AVG(s.qty) as Prosjek
FROM dbo.employee AS e
INNER JOIN dbo.jobs as J
ON e.job_id = J.job_id
INNER JOIN dbo.publishers as P
ON e.pub_id = P.pub_id
INNER JOIN dbo.titles as T
on P.pub_id = T.pub_id
inner join dbo.sales as s
on T.title_id = s.title_id
WHERE J.job_desc = 'Designer'
GROUP BY e.fname, e.lname
HAVING AVG(s.qty) > 
(
	SELECT AVG(S1.qty)
	FROM dbo.sales as S1
	INNER JOIN dbo.titles AS T1
	ON S1.title_id = T1.title_id
	WHERE T1.pub_id = 0877
)

USE pubs 

SELECT CONCAT(E.fname, ' ', E.lname) 'Ime i prezime ', AVG(S.qty) 'Prosjecna prodana vrijednost'
FROM employee AS E
	INNER JOIN jobs AS J ON E.job_id=J.job_id
	INNER JOIN publishers AS P ON E.pub_id=P.pub_id
	INNER JOIN titles AS T ON P.pub_id=T.pub_id
	INNER JOIN sales AS S ON T.title_id=S.title_id
WHERE J.job_desc LIKE '%Designer%' 
GROUP BY CONCAT(E.fname, ' ', E.lname)
HAVING AVG(S.qty)>
				  (SELECT AVG(S.qty)
				   FROM sales AS S
				   INNER JOIN titles AS T
				   ON T.title_id=S.title_id
				   WHERE T.pub_id =0877)
--
USE AdventureWorks2017
SELECT Q1.GodinaTransakcije, SUM(Q1.SumiranIznos) as SumiranIznos
FROM 
(
	SELECT YEAR(TA.TransactionDate) AS GodinaTransakcije, 
	SUM(TA.Quantity * TA.ActualCost) as SumiranIznos
	FROM Production.TransactionHistory AS TA
	GROUP BY YEAR(TA.TransactionDate)
	UNION ALL
	SELECT YEAR(TH.TransactionDate) AS GodinaTransakcije, 
	SUM(TH.Quantity * TH.ActualCost) as SumiranIznos
	FROM Production.TransactionHistoryArchive as TH
	GROUP BY YEAR(TH.TransactionDate)
) as Q1
GROUP BY Q1.GodinaTransakcije
order by 1

USE AdventureWorks2017
SELECT T1.Godina,ROUND(SUM(T1.Ukupno),2) 'Ukupan iznos transakcija'
FROM (SELECT YEAR(TH.TransactionDate) Godina, SUM(TH.Quantity*TH.ActualCost) Ukupno
	  FROM Production.TransactionHistory AS TH
	  GROUP BY YEAR(TH.TransactionDate)
	  UNION ALL
	  SELECT YEAR(TH.TransactionDate) Godina, SUM(TH.Quantity*TH.ActualCost) Ukupno
	  FROM Production.TransactionHistoryArchive AS TH
	  GROUP BY YEAR(TH.TransactionDate)) AS T1
GROUP BY T1.Godina
ORDER BY 1 

USE AdventureWorks2017
SELECT SOD.ProductID, 
ROUND(SUM(SOD.OrderQty * SOD.UnitPrice),2) as UkupnoBezPopusta,
ROUND(SUM(SOD.LineTotal), 2) as UkupnoPopust
FROM Sales.SalesOrderDetail as SOD
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
WHERE YEAR(SOH.OrderDate) = 2013 AND MONTH(SOH.OrderDate) = 5
GROUP BY SOD.ProductID

SELECT PP.Name 'Naziv proizvoda',SUM(SOD.LineTotal) 'Zarada sa popustom', SUM(SOD.UnitPrice*SOD.OrderQty) 'Zarada bez popusta'
FROM Production.Product AS PP
INNER JOIN Sales.SalesOrderDetail AS SOD
ON PP.ProductID=SOD.ProductID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID=SOH.SalesOrderID
WHERE YEAR(SOH.OrderDate)=2013 AND MONTH(SOH.OrderDate)=5
GROUP BY PP.Name


use AdventureWorks2017
SELECT YEAR(SOH2.OrderDate) AS Godina, 
(
	SELECT SUM(SOD.LineTotal) as Ukupno
	FROM Sales.SalesOrderHeader as SOH
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Production.Product AS p
	ON SOD.ProductID = p.ProductID
	INNER JOIN Production.ProductSubcategory AS PSC
	ON p.ProductSubcategoryID = PSC.ProductSubcategoryID
	WHERE PSC.Name = 'Mountain Bikes' AND 
	YEAR(SOH.OrderDate) =  YEAR(SOH2.OrderDate)
) as 'Ukupno: Mountain Bikes',
(
	SELECT SUM(SOD.LineTotal) as Ukupno
	FROM Sales.SalesOrderHeader as SOH
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Production.Product AS p
	ON SOD.ProductID = p.ProductID
	INNER JOIN Production.ProductSubcategory AS PSC
	ON p.ProductSubcategoryID = PSC.ProductSubcategoryID
	WHERE PSC.Name = 'Road Bikes' and
	YEAR(SOH.OrderDate) =  YEAR(SOH2.OrderDate)
) as 'Ukupno: Road Bikes', 
 ISNULL((
	SELECT SUM(SOD.LineTotal) as Ukupno
	FROM Sales.SalesOrderHeader as SOH
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID
	INNER JOIN Production.Product AS p
	ON SOD.ProductID = p.ProductID
	INNER JOIN Production.ProductSubcategory AS PSC
	ON p.ProductSubcategoryID = PSC.ProductSubcategoryID
	WHERE PSC.Name = 'Touring Bikes' and
	YEAR(SOH.OrderDate) =  YEAR(SOH2.OrderDate)
), 0) as 'Ukupno: Touring Bikes'
FROM Sales.SalesOrderHeader AS SOH2
GROUP BY YEAR(SOH2.OrderDate)
ORDER BY 1

USE AdventureWorks2017
SELECT TOP 1 * FROM 
(
	SELECT TOP 4 P.FirstName + ' ' + P.LastName 
	as ImePrezime, EP.Rate
	FROM Person.Person AS P
	INNER JOIN HumanResources.Employee as e
	on P.BusinessEntityID = e.BusinessEntityID
	INNER JOIN HumanResources.EmployeePayHistory as EP
	ON e.BusinessEntityID = EP.BusinessEntityID
	ORDER BY 2 DESC
) AS Q1
ORDER BY 2 DESC

USE AdventureWorks2017
SELECT TOP 1 *
FROM(SELECT TOP 4 PP.FirstName, PP.LastName, EPH.Rate
	 FROM HumanResources.EmployeePayHistory AS EPH
	 INNER JOIN HumanResources.Employee AS E ON EPH.BusinessEntityID=E.BusinessEntityID
	 INNER JOIN Person.Person AS PP ON EPH.BusinessEntityID=PP.BusinessEntityID
	 ORDER BY 3 DESC) AS PODQ
ORDER BY 3

USE Northwind
SELECT TOP 50 PERCENT O.OrderID, O.OrderDate,
C.ContactName, 
round(SUM(OD.Quantity * OD.UnitPrice * (1- OD.Discount)),2) AS Ukupno
FROM dbo.Orders as O
INNER JOIN dbo.Customers AS C
ON O.CustomerID = C.CustomerID
INNER JOIN dbo.[Order Details] as OD
ON O.OrderID = OD.OrderID
GROUP BY O.OrderID, O.OrderDate,
C.ContactName
ORDER BY O.OrderDate DESC

USE Northwind
SELECT TOP 50  PERCENT O.OrderID, O.OrderDate, C.ContactName, 
ROUND(SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)), 2)'Ukupna vrijednost narudžbe sa popustom'
FROM Customers AS C
	INNER JOIN Orders AS O ON C.CustomerID=O.CustomerID
	INNER JOIN [Order Details] AS OD ON O.OrderID=OD.OrderID
GROUP BY O.OrderID, O.OrderDate, C.ContactName
ORDER BY O.OrderDate DESC

/* Sedmi zadatak */

USE AdventureWorks2017
SELECT PQ1.Name, PQ1.Ukupno,PQ1.Ukupno - PQ3.Prosjek as NajmanjivsProsjek,
PQ2.Name, PQ2.Ukupno, PQ2.Ukupno - PQ3.Prosjek as NajveciVSProsjek FROM 
(
	SELECT TOP 1 P.[Name], 
	CAST(SUM(SOD.LineTotal) as decimal(18,2)) 
	as Ukupno
	FROM Production.Product as P
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOD.ProductID = P.ProductID
	GROUP BY P.[Name]
	ORDER BY 2 ASC
) AS PQ1,
(
	SELECT TOP 1 P.[Name], CAST(SUM(SOD.LineTotal) as decimal(18,2)) as Ukupno
	FROM Production.Product as P
	INNER JOIN Sales.SalesOrderDetail AS SOD
	ON SOD.ProductID = P.ProductID
	GROUP BY P.[Name]
	ORDER BY 2 DESC
) as PQ2,
(
	SELECT AVG(SOD.LineTotal) as Prosjek
	FROM Sales.SalesOrderDetail AS SOD
) as PQ3


USE AdventureWorks2017
SELECT PODQ1.Name Proizvod, PODQ1.[Najmanji promet], PODQ2.Name Proizvod, PODQ2.[Najveći promet],
PODQ1.[Najmanji promet]-PODQ3.[Prosjecan promet] 'Razlika min-avg',
PODQ2.[Najveći promet]-PODQ3.[Prosjecan promet] 'Razlika max-avg'
FROM
	(SELECT TOP 1 P.Name, CAST(SUM(SOD.LineTotal) AS decimal(18,2)) 'Najmanji promet'
	 FROM Sales.SalesOrderDetail AS SOD
	 INNER JOIN Production.Product AS P ON SOD.ProductID=P.ProductID
	 GROUP BY P.Name
	 ORDER BY 2) AS PODQ1, --CROSS JOIN
	(SELECT TOP 1 P.Name, CAST(SUM(SOD.LineTotal) AS decimal(18,2)) 'Najveći promet'
	 FROM Sales.SalesOrderDetail AS SOD
	 INNER JOIN Production.Product AS P ON SOD.ProductID=P.ProductID
	 GROUP BY P.Name
	 ORDER BY 2 DESC) AS PODQ2, --CROSS JOIN
	(SELECT CAST(AVG(PODQ.[Ukupan promet]) AS decimal(18,2)) 'Prosjecan promet'
	 FROM(SELECT P.Name, SUM(SOD.LineTotal) 'Ukupan promet'
		  FROM Sales.SalesOrderDetail AS SOD
		  INNER JOIN Production.Product AS P ON SOD.ProductID=P.ProductID
		  GROUP BY P.Name) AS PODQ) AS PODQ3