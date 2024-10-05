/* VJEŽBA 5 */

SELECT O.ShipCountry, SUM(O.Freight) as TotalFreight
FROM Northwind.dbo.Orders as O
WHERE O.ShipCountry IN ('France', 'Germany','Switzerland')
GROUP BY O.ShipCountry
HAVING SUM(Freight) > 4000

SELECT TOP 10 P.ProductID, SUM(P.UnitPrice * P.UnitsInStock)
FROM Northwind.dbo.Products as P
GROUP BY SUM(P.UnitPrice * P.UnitsInStock)

/* 
Kreirati upit koji prikazuje zaradu od prodaje proizvoda. Lista treba da sadrži 
identifikacijski broj proizvoda, ukupnu vrijednost bez popusta, ukupnu vrijednost sa 
popustom. Vrijednost zarade zaokružiti na dvije decimale. Uslov je da se prikaže zarada 
samo za stavke gdje je bilo popusta. Listu sortirati prema ukupnoj zaradi sa popustom 
u opadajućem redoslijedu. (AdventureWorks2017)
*/

SELECT TOP 10 O.ProductID, Sum(O.Quantity)
FROM Northwind.dbo.[Order Details] as O
GROUP BY O.ProductID
ORDER BY 2 DESC

USE Northwind
SELECT TOP 10 OD.ProductID, SUM(OD.Quantity) 'Ukupan broj prodanih proizvoda'
FROM [Order Details] AS OD
GROUP BY OD.ProductID
ORDER BY 2 DESC

/* Zadatak .3 */

USE Northwind
SELECT OD.ProductID, 
ROUND(SUM(OD.Quantity * OD.UnitPrice), 2)
as UkupnoBezPopusta, 
ROUND(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)), 2) 
as UkupnoSPopustom
FROM [Order Details] as OD
GROUP BY OD.ProductID
ORDER BY UkupnoSPopustom DESC

USE AdventureWorks2017
SELECT SOD.ProductID, 
ROUND(SUM(SOD.OrderQty*SOD.UnitPrice), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL(18, 2))'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.UnitPriceDiscount>0
GROUP BY SOD.ProductID
ORDER BY 3 DESC

SELECT OD.ProductID,
ROUND(SUM(OD.OrderQty * OD.UnitPrice) , 2)
as 'Ukupno bez popusta', 
ROUND(SUM(OD.OrderQty * OD.UnitPrice * 
(1 - OD.UnitPriceDiscount)),2) as 
'Ukupno s popustom'
FROM AdventureWorks2017.Sales.
SalesOrderDetail as OD
WHERE OD.UnitPriceDiscount > 0
GROUP BY OD.ProductID
ORDER BY 3 DESC

/* Zadatak .4 */

SELECT D.discounttype, S.stor_name, D.stor_id
FROM pubs.dbo.discounts as D
INNER JOIN pubs.dbo.stores as S
ON D.stor_id = S.stor_id

USE pubs
SELECT D.discounttype, S.stor_name, S.stor_id
FROM discounts AS D
INNER JOIN stores AS S
ON D.stor_id=S.stor_id

/* Zadatak .5 */

USE PUBS
SELECT E.emp_id, E.fname, E.lname, J.job_desc
FROM dbo.employee as E
INNER JOIN dbo.jobs as J
ON E.job_id = J.job_id

SELECT E.emp_id, E.fname, E.lname, J.job_desc
FROM employee AS E
INNER JOIN jobs AS J
ON E.job_id=J.job_id

/* Zadatak .6 */

USE Northwind
SELECT E.FirstName + ' ' + E.LastName 
AS 'Ime i Prezime', T.TerritoryDescription, R.RegionDescription
FROM dbo.Employees AS E
INNER JOIN dbo.EmployeeTerritories AS ET
ON E.EmployeeID = ET.EmployeeID
INNER JOIN dbo.Territories as T
ON ET.TerritoryID = T.TerritoryID
INNER JOIN dbo.Region as R
ON T.RegionID = R.RegionID
WHERE 2024 - YEAR(E.BirthDate) < 65

USE Northwind
SELECT CONCAT(E.FirstName, ' ', E.LastName) 'Ime i prezime', T.TerritoryDescription, R.RegionDescription
FROM Employees AS E
INNER JOIN EmployeeTerritories AS ET
ON E.EmployeeID=ET.EmployeeID
INNER JOIN Territories AS T
ON ET.TerritoryID=T.TerritoryID
INNER JOIN Region AS R
ON R.RegionID=T.RegionID
WHERE DATEDIFF(YEAR, E.BirthDate, GETDATE())<65

/* ZADATAK 7 */

USE Northwind
SELECT E.FirstName, E.LastName, SUM(OD.Quantity * OD.UnitPrice * 
(1 - OD.Discount)) as 'Ukupno s popustom'
FROM dbo.[Order Details] as OD
INNER JOIN dbo.Orders as O
ON OD.OrderID = O.OrderID
INNER JOIN dbo.Employees as E
ON O.EmployeeID = E.EmployeeID
WHERE YEAR(O.OrderDate) = 1996 
GROUP BY E.FirstName, E.LastName
HAVING SUM(OD.Quantity * OD.UnitPrice * 
(1 - OD.Discount)) > 20000
ORDER BY 3 ASC

SELECT E.FirstName, E.LastName, ROUND(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)),2) 'Ukupna vrijednost narudžbe sa popustom'
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID=O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID=OD.OrderID
WHERE YEAR(O.OrderDate)=1996
GROUP BY E.FirstName, E.LastName
HAVING SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))>20000
ORDER BY 3 ASC

/* ZADATAK 8 */

USE Northwind
SELECT S.ContactName, S.[Address], S.Country, P.ProductName
FROM dbo.Suppliers as S
INNER JOIN dbo.Products as P
ON S.SupplierID = P.SupplierID
INNER JOIN dbo.Categories as C
ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages' AND P.UnitsInStock > 30
ORDER BY 3 ASC

USE Northwind
SELECT S.ContactName, S.Address, S.Country, P.ProductName
FROM Suppliers AS S
INNER JOIN Products AS P
ON S.SupplierID=P.SupplierID
INNER JOIN Categories AS C
ON C.CategoryID=P.CategoryID
WHERE P.UnitsInStock>30 AND C.Description LIKE '%drinks%'
ORDER BY 3

/* ZADATAK 9 */

USE Northwind
SELECT C.ContactName, C.CustomerID, 
O.OrderID, 
O.OrderDate, 
SUM(OD.Quantity * OD.UnitPrice) 
as 'Ukupno bez popusta', SUM(OD.Quantity * OD.UnitPrice *
1- OD.Discount) 
as 'Ukupno sa popustom'
FROM dbo.Customers as C
INNER JOIN dbo.Orders as O
ON C.CustomerID = O.CustomerID
INNER JOIN dbo.[Order Details] as OD
ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY C.ContactName, 
C.CustomerID, O.OrderID, O.OrderDate
ORDER BY 6 DESC

USE Northwind
SELECT C.ContactName, C.CustomerID, O.OrderID, 
FORMAT(O.OrderDate,'dd.MM.yyyy') AS 'Datum kreiranja narudžbe', 
SUM(OD.UnitPrice*OD.Quantity) 'Ukupno bez popusta',
ROUND(SUM(OD.UnitPrice*OD.Quantity*(1-OD.Discount)), 2) 'Ukupno sa popustom'
FROM Customers AS C
INNER JOIN Orders AS O
ON C.CustomerID=O.CustomerID
INNER JOIN [Order Details] AS OD
ON OD.OrderID=O.OrderID
WHERE YEAR(O.OrderDate)=1997
GROUP BY C.ContactName, C.CustomerID, O.OrderID, FORMAT(O.OrderDate,'dd.MM.yyyy')
ORDER BY 6 DESC

USE Northwind