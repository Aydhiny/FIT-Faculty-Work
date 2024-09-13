/* ZADATAK .1 */

SELECT SUM(O.Freight) as 'Ukupan prevoz', O.ShipCountry
FROM Northwind.dbo.Orders as O
WHERE O.ShipCountry 
IN ('France', 'Germany', 'Switzerland')
GROUP BY O.ShipCountry, O.Freight
HAVING SUM(O.Freight) > 4000

/* ZADATAK .2 */

USE Northwind
SELECT TOP 10 
OD.ProductID, SUM(OD.Quantity) as 'Ukupno prodatih'
FROM dbo.[Order Details] as OD
GROUP BY OD.ProductID
ORDER BY 2 DESC

USE Northwind
SELECT TOP 10 OD.ProductID, SUM(OD.Quantity) 'Ukupan broj prodanih proizvoda'
FROM [Order Details] AS OD
GROUP BY OD.ProductID
ORDER BY 2 DESC

/* ZADATAK .3 */

USE AdventureWorks2017
SELECT SOD.ProductID, ROUND(SUM
(SOD.UnitPrice * SOD.OrderQty), 2) as 'Ukupno bez popusta',
ROUND(SUM(SOD.UnitPrice * SOD.OrderQty * 
(1- SOD.UnitPriceDiscount)), 2) as 
'Ukupno s popustom'
FROM Sales.SalesOrderDetail as SOD
WHERE SOD.UnitPriceDiscount > 0
GROUP BY SOD.ProductID
ORDER BY 3 DESC

USE AdventureWorks2017
SELECT SOD.ProductID, 
ROUND(SUM(SOD.OrderQty*SOD.UnitPrice), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL(18, 2))'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.UnitPriceDiscount>0
GROUP BY SOD.ProductID
ORDER BY 3 DESC

/* ZADATAK .4 */

USE Pubs
SELECT D.discounttype, S.stor_name, S.stor_id
FROM dbo.discounts as D
INNER JOIN dbo.stores as S
ON D.stor_id = S.stor_id

USE pubs
SELECT D.discounttype, S.stor_name, S.stor_id
FROM discounts AS D
INNER JOIN stores AS S
ON D.stor_id=S.stor_id

/* Zadatak .5 */

USE Pubs
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
as 'Ime i prezime', T.TerritoryDescription, R.RegionDescription
FROM dbo.Employees as E
INNER JOIN dbo.EmployeeTerritories as ET
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

/* Zadatak .7 */

USE Northwind
SELECT ROUND(SUM(OD.UnitPrice * OD.Quantity * 
(1- OD.Discount)),2) as 'Ukupno s popustom', E.EmployeeID
FROM dbo.[Order Details] as OD
INNER JOIN dbo.Orders as O
ON OD.OrderID = O.OrderID
INNER JOIN dbo.Employees as E
ON O.EmployeeID = E.EmployeeID
WHERE YEAR(O.OrderDate) = 1996
GROUP BY E.EmployeeID
HAVING SUM(OD.UnitPrice * OD.Quantity * 
(1- OD.Discount)) > 20000
ORDER BY 1 ASC

SELECT E.FirstName, E.LastName, ROUND(SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount)),2) 'Ukupna vrijednost narudžbe sa popustom'
FROM Employees AS E
INNER JOIN Orders AS O
ON E.EmployeeID=O.EmployeeID
INNER JOIN [Order Details] AS OD
ON O.OrderID=OD.OrderID
WHERE YEAR(O.OrderDate)=1996
GROUP BY E.FirstName, E.LastName
HAVING SUM(OD.Quantity*OD.UnitPrice*(1-OD.Discount))>20000
ORDER BY 3

/* Zadatak .8 */

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

/* Zadatak .9 */

USE Northwind
SELECT C.ContactName, C.CustomerID, O.OrderID, 
FORMAT(O.OrderDate, 
'dd-MM-yyyy') as Datum, ROUND(SUM(OD.Quantity * 
OD.UnitPrice * (1 - OD.Discount)),2) 
as 'Ukupno s popustom', ROUND(SUM(OD.Quantity * 
OD.UnitPrice),2) as 'Ukupno bez popusta'
FROM dbo.Customers as C
INNER JOIN dbo.Orders as O
ON C.CustomerID = O.CustomerID
INNER JOIN dbo.[Order Details] as OD
ON O.OrderID = OD.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY C.ContactName, C.CustomerID, 
O.OrderID, FORMAT(O.OrderDate, 
'dd-MM-yyyy')
ORDER BY 5 DESC

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

/* Zadatak .10 */

/* Koristeći tabele Employees 
i Customers, prikaži kombinovani 
set svih imena zaposlenih
(FirstName iz Employees) 
i imena kontakt osoba kupaca 
(ContactName iz Customers). Rezultat 
treba da prikaže jedinstvene nazive. */

SELECT E.FirstName
FROM Employees as E
UNION
SELECT C.ContactName
FROM Customers as C

/* Prikaži samo one OrderID koji su zajednički u 
tabelama Orders i OrderDetails. */

SELECT O.OrderID
FROM Orders as O
INTERSECT
SELECT OD.OrderID
FROM [Order Details] as OD

/* Prikaži sve kupce (CustomerID iz 
tabele Customers) koji nemaju narudžbe u tabeli Orders. */
SELECT C.CustomerID
FROM Customers as C
EXCEPT
SELECT O.CustomerID
FROM Orders as O

/* Iz baze Northwind, prikaži OrderID i 
CompanyName kupaca koji su naručili robu. */
USE Northwind
SELECT O.OrderID, C.CompanyName
FROM dbo.Orders as O
INNER JOIN dbo.Customers as C
ON O.CustomerID = C.CustomerID

/* Prikaži sve proizvode iz tabele 
Products, zajedno sa imenom dobavljača 
(SupplierName), čak i 
ako neki proizvodi nemaju dobavljača. */

USE Northwind
SELECT P.ProductID, P.ProductName, S.ContactName
FROM dbo.Products as P
LEFT OUTER JOIN dbo.Suppliers as S
ON P.SupplierID = S.SupplierID

/* Prikaži sve zaposlenike 
iz tabele Employees, zajedno sa 
informacijama o teritorijama iz 
tabele Territories, čak i ako neki 
teritoriji nisu dodeljeni zaposlenicima. */

USE Northwind
SELECT E.EmployeeID, E.FirstName, E.LastName, T.TerritoryDescription
FROM dbo.Employees as E
RIGHT JOIN dbo.EmployeeTerritories as ET
ON E.EmployeeID = ET.EmployeeID
RIGHT JOIN dbo.Territories as T
ON ET.TerritoryID = T.TerritoryID

/* Prikaži sve moguće kombinacije 
između kupaca (Customers) i proizvoda */

SELECT C.CustomerID, C.CompanyName, P.ProductID, P.ProductName
FROM Customers AS C
CROSS JOIN Products AS P;

/* Zadatak 13 */
USE pubs
SELECT A.au_id
FROM dbo.authors as A
EXCEPT
SELECT TA.au_id
FROM dbo.titleauthor as TA

SELECT A.au_id 'Autori bez naslova'
FROM authors AS A
LEFT OUTER JOIN titleauthor AS TA
ON A.au_id=TA.au_id
WHERE TA.title_id IS NULL

SELECT A.au_id
FROM authors AS A
INTERSECT
SELECT TA.au_id
FROM titleauthor AS TA

SELECT DISTINCT A.au_id as 'Napisali po jedan' 
FROM authors as A
INNER JOIN titleauthor as TA
ON A.au_id = TA.au_id

/* Zadatak 14 */

USE AdventureWorks2017
SELECT TOP 10 SOD.SalesOrderID, P.[Name], STR(SOD.OrderQty) + ' kom', 
STR(ROUND(SOD.UnitPrice, 2)) + ' KM' as UnitPrice, STR(ROUND(SOD.UnitPrice * SOD.OrderQty, 2)) + ' KM' AS VrijednostStavke
FROM Sales.SalesOrderDetail as SOD
INNER JOIN .Production.[Product] as P 
ON SOD.ProductID = P.ProductID
ORDER BY ROUND((SOD.OrderQty*SOD.UnitPrice), 2) DESC

USE AdventureWorks2017
SELECT TOP 10 PP.Name,
SOD.SalesOrderDetailID,
CONCAT(SOD.OrderQty , ' kom') Kolicina,
CONCAT(ROUND(SOD.UnitPrice, 2), ' KM') 'Cijena',
CONCAT(ROUND((SOD.OrderQty*SOD.UnitPrice), 2), ' KM') 'Vrijednost stavke prodaje'
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Production.Product AS PP
ON SOD.ProductID=PP.ProductID
ORDER BY ROUND((SOD.OrderQty*SOD.UnitPrice), 2) DESC

/* Zadatak 15 */

USE AdventureWorks2017
SELECT ST.[Name] , COUNT(SOH.SalesOrderID) as BrojNarudzbi
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.SalesTerritory as ST
ON SOH.TerritoryID = ST.TerritoryID
GROUP BY ST.[Name]
HAVING COUNT(SOH.SalesOrderID) > 1000

SELECT ST.Name, COUNT(*) 'Ukupan broj narudžbi'
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
HAVING COUNT(*) >1000

/* Zadatak 16 */

USE AdventureWorks2017
SELECT P.[Name], ROUND(SUM(SOD.UnitPrice * SOD.OrderQty), 2) as 
'Ukupno bez popusta', ROUND(SUM(SOD.UnitPrice * SOD.OrderQty *(1 - SOD.UnitPriceDiscount)), 2) as
'Ukupno s popustom'
FROM Production.[Product] as P
INNER JOIN .Sales.SalesOrderDetail as SOD
ON P.ProductID = SOD.ProductID
WHERE SOD.UnitPriceDiscount > 0
GROUP BY P.[Name]
ORDER BY 3 DESC

SELECT PP.Name,
ROUND(SUM(SOD.UnitPrice*SOD.OrderQty), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL (18,2)) 'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Production.Product AS PP
ON PP.ProductID=SOD.ProductID
WHERE SOD.UnitPriceDiscount>0
GROUP BY PP.Name
ORDER BY 3 DESC 