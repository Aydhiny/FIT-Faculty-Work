USE AdventureWorks2017


/* Zadatak .1 */
SELECT P.FirstName, P.LastName, 
C.CardType, C.CardNumber, SUM(SOH.TotalDue) as UkupanIznos
FROM Person.Person as P
INNER JOIN Sales.PersonCreditCard as PC
ON P.BusinessEntityID = PC.BusinessEntityID
INNER JOIN Sales.CreditCard AS C
on PC.CreditCardID = C.CreditCardID
INNER JOIN Sales.SalesOrderHeader as SOH
ON C.CreditCardID = SOH.CreditCardID
GROUP BY  P.FirstName, P.LastName, 
C.CardType, C.CardNumber
HAVING COUNT(*) > 20
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

/* Zadatak .2 */
SELECT P.FirstName, P.LastName, 
SOH.SalesOrderID, 
SUM(SOD.OrderQty * SOD.UnitPrice) as Ukupno
FROM Person.Person as P
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader as SOH
ON C.CustomerID = SOH.CustomerID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY P.FirstName, P.LastName, 
SOH.SalesOrderID
HAVING SUM(SOD.OrderQty * SOD.UnitPrice) > 
(
	SELECT AVG(SOD.LineTotal)
	FROM Sales.SalesOrderDetail as SOD
	WHERE SOD.ProductID = 779
)

SELECT PP.FirstName, PP.LastName, SOH.SalesOrderID, SUM(SOD.UnitPrice*SOD.OrderQty) 'Ukupna vrijednost'
FROM Person.Person AS PP
	INNER JOIN Sales.Customer AS C ON PP.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID 
	INNER JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID=SOD.SalesOrderID
GROUP BY SOH.SalesOrderID, PP.FirstName, PP.LastName
HAVING SUM(SOD.UnitPrice*SOD.OrderQty) >
(SELECT AVG(SOD.LineTotal) 
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.ProductID=779)

/* Zadatak .3 */

SELECT PP.FirstName, PP.LastName
FROM Person.Person AS PP
INNER JOIN Sales.Customer as C
ON PP.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN Production.[Product] AS P
ON SOD.ProductID = P.ProductID
WHERE (MONTH(SOH.OrderDate) = 5 AND 
YEAR(SOH.OrderDate) = 2014) 
AND P.[Name] = 'Front Brakes' AND SOD.OrderQty > 5

/* Zadatak .4 */

SELECT PP.FirstName, PP.LastName, 
SUM(SOH.TotalDue) AS UkupniTrosak
FROM Person.Person AS PP
INNER JOIN Sales.Customer as C
ON PP.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader as SOH
ON C.CustomerID = SOH.CustomerID
WHERE MONTH(SOH.OrderDate) = 7
GROUP BY PP.FirstName, PP.LastName
HAVING SUM(SOH.TotalDue) > 200000

SELECT P.FirstName, P.LastName, SUM(SOH.TotalDue) 'Ukupni trošak'
FROM Person.Person AS P
	INNER JOIN Sales.Customer AS C ON P.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
WHERE MONTH(SOH.OrderDate)=7
GROUP BY P.FirstName, P.LastName
HAVING SUM(SOH.TotalDue)>200000
ORDER BY 3 DESC

/* Zadatak .5 */
SELECT P.FirstName, P.LastName, COUNT(*) AS UkupanbrojNarudzbi
FROM Person.Person as P
INNER JOIN HumanResources.Employee as E
ON P.BusinessEntityID = E.BusinessEntityID
INNER JOIN Sales.SalesPerson AS SP
ON E.BusinessEntityID = SP.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader as SOH
ON SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY P.FirstName, P.LastName
HAVING COUNT(*) > 200
ORDER BY 3 DESC

SELECT P.FirstName, P.LastName, COUNT(*) 'Ukupan broj narudžbi'
FROM Person.Person AS P
	INNER JOIN HumanResources.Employee AS E ON P.BusinessEntityID=E.BusinessEntityID
	INNER JOIN Sales.SalesPerson AS SP ON E.BusinessEntityID=SP.BusinessEntityID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON SP.BusinessEntityID=SOH.SalesPersonID
GROUP BY P.FirstName, P.LastName
HAVING COUNT(*)>200
ORDER BY 3 DESC

/* Zadatak .6 */
SELECT P.[Name], L.Name, PI.Quantity,
ISNULL ((
	SELECT SUM(SOD.OrderQty)
	FROM Sales.SalesOrderDetail AS SOD
	WHERE SOD.ProductID = P.ProductID
), 0) as 'Ukupna prodajna kolicina'
FROM Production.Product as P
INNER JOIN Production.ProductInventory as PI
ON P.ProductID = PI.ProductID
INNER JOIN Production.[Location] as L
ON PI.LocationID = L.LocationID
WHERE PI.Quantity < 30 OR P.ProductID NOT IN 
(
	SELECT DISTINCT SOD.ProductID
	FROM Sales.SalesOrderDetail AS SOD
)
ORDER BY 4 DESC

/* ZADATAK .7 */

SELECT ST.Name Teritorija, PP.Name Proizvod , 
		CAST(SUM(SOD.LineTotal) AS DECIMAL(10,2)) 'Ukupna zarada'
FROM Production.Product AS PP
	INNER JOIN Sales.SpecialOfferProduct AS SOP ON PP.ProductID=SOP.ProductID
	INNER JOIN Sales.SpecialOffer AS SO ON SOP.SpecialOfferID=SO.SpecialOfferID
	INNER JOIN Sales.SalesOrderDetail AS SOD ON SOP.SpecialOfferID=SOD.SpecialOfferID AND SOP.ProductID=SOD.ProductID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON SOD.SalesOrderID=SOH.SalesOrderID
	INNER JOIN Sales.SalesTerritory AS ST ON SOH.TerritoryID=ST.TerritoryID
WHERE SO.Description LIKE 'Volume Discount 11 to 14'
GROUP BY ST.Name, PP.Name
HAVING SUM(SOD.OrderQty)>100
ORDER BY 3 DESC

SELECT ST.Name, P.Name, 
SUM(SOD.OrderQty) AS UkupnaKol, SUM(SOD.LineTotal) as UkupnaZarada
FROM Production.Product AS P
INNER JOIN Sales.SpecialOfferProduct AS SOP
ON P.ProductID = SOP.ProductID
INNER JOIN Sales.SpecialOffer AS SO
ON SOP.SpecialOfferID = SO.SpecialOfferID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SO.SpecialOfferID = SOD.SpecialOfferID 
AND P.ProductID = SOD.ProductID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON SOD.SalesOrderID = SOH.SalesOrderID
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID = ST.TerritoryID
WHERE SO.Description = 'Volume Discount 11 to 14' 
GROUP BY ST.Name, P.Name
HAVING SUM(SOD.OrderQty) > 100
ORDER BY 4 DESC

/* Zadatak .8 */

SELECT P.Name, L.Name, PI.Quantity,
ISNULL ((
	SELECT SUM(PI1.Quantity)
	FROM Production.ProductInventory AS PI1
	WHERE PI1.ProductID = P.ProductID
), 0) AS UkupnoStanje,
ISNULL ((
	SELECT SUM(SOD.OrderQty)
	FROM Sales.SalesOrderDetail AS SOD
	INNER JOIN Sales.SalesOrderHeader AS SOH
	ON SOD.SalesOrderID = SOH.SalesOrderID
	WHERE SOD.ProductID = P.ProductID AND YEAR(SOH.OrderDate) = 2013
), 0) as UkupnoProdajnaKolicina
FROM Production.Product AS P
INNER JOIN Production.ProductInventory AS PI
ON P.ProductID = PI.ProductID
INNER JOIN Production.Location AS L
ON PI.LocationID = L.LocationID
ORDER BY 5 DESC

SELECT P.Name 'Proizvod', L.Name 'Lokacija', PI.Quantity 'Zalihe na lokaciji',
(
	SELECT SUM(PI1.Quantity)
	FROM  Production.ProductInventory AS PI1
	WHERE PI1.ProductID=P.ProductID
) 'Ukupno stanje zaliha na svim lokacijama',
ISNULL((SELECT SUM(SOD.OrderQty)
		FROM Sales.SalesOrderHeader AS SOH
		INNER JOIN Sales.SalesOrderDetail AS SOD
		ON SOH.SalesOrderID=SOD.SalesOrderID
		WHERE YEAR(SOH.OrderDate)=2013 AND SOD.ProductID=P.ProductID
),0) 'Ukupna prodana kolicina'
FROM Production.Product AS P
	INNER JOIN Production.ProductInventory AS PI ON P.ProductID=PI.ProductID
	INNER JOIN Production.Location AS L ON PI.LocationID=L.LocationID
ORDER BY 5 DESC

/* Zadatak .9*/

SELECT SOH.SalesOrderID, P.FirstName, P.LastName, 
CAST(SUM(SOD.LineTotal) AS decimal(18,2)) UkupnaVR
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN Sales.Customer AS C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person AS P 
ON C.PersonID = P.BusinessEntityID
GROUP BY SOH.SalesOrderID, P.FirstName, P.LastName
HAVING SUM(SOD.OrderQty * SOD.UnitPrice * SOD.UnitPriceDiscount) >= 100
ORDER BY 4 ASC

SELECT SOH.SalesOrderID, P.FirstName, P.LastName, 
CAST(SUM(SOD.LineTotal)AS decimal (18,2)) 'Ukupna vrijednost narudžbe'
FROM Person.Person AS P
	INNER JOIN Sales.Customer AS C ON P.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
	INNER JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID=SOD.SalesOrderID
GROUP BY SOH.SalesOrderID, P.FirstName, P.LastName
HAVING SUM(SOD.UnitPrice*SOD.OrderQty*SOD.UnitPriceDiscount)>=100
ORDER BY 4 

/* Zadatak .10 */

SELECT TOP 1 IIF(RIGHT(P.FirstName, 1)='a','F','M') 
as Spol, COUNT(*), SUM(SOH.TotalDue)
FROM Person.Person AS P
INNER JOIN Sales.Customer AS C
ON P.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader AS SOH
ON C.CustomerID = SOH.CustomerID
GROUP BY IIF(RIGHT(P.FirstName, 1)='a','F','M') 
ORDER BY 1 DESC

SELECT TOP 1 IIF(RIGHT(P.FirstName, 1) LIKE 'a', 'F', 'M') 'Spol', COUNT(*) 'Ukupan broj narudzbi', 
ROUND(SUM(SOH.TotalDue), 2) 'Ukupna potrošena vrijednost'
FROM Person.Person AS P
	INNER JOIN Sales.Customer AS C ON P.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
GROUP BY IIF(RIGHT(P.FirstName, 1) LIKE 'a', 'F', 'M')
ORDER BY 2 DESC

/* Zadatak 11. */

SELECT V.Name 'Naziv dobavljaca', COUNT(*) 'Ukupan broj proizvoda', SUM(PI.Quantity) 'Ukupna kolicina', 
SUM(P.ListPrice*PI.Quantity) 'Ukupna vrijednost'
FROM Production.Product AS P
	INNER JOIN Production.ProductInventory AS PI ON P.ProductID=PI.ProductID
	INNER JOIN Purchasing.ProductVendor AS PV ON P.ProductID=PV.ProductID
	INNER JOIN Purchasing.Vendor AS V ON PV.BusinessEntityID=V.BusinessEntityID
WHERE P.ListPrice>0
GROUP BY V.Name
HAVING SUM(PI.Quantity)>100
ORDER BY 3 DESC

SELECT V.[Name], COUNT(*) AS 
'Ukupan broj proizvoda', 
SUM(PI.Quantity) as UkupnaKolicina, 
SUM(P.ListPrice * PI.Quantity) 
as UkupnaVrijednost
FROM Production.Product as P
INNER JOIN Production.ProductInventory AS PI
ON P.ProductID = PI.ProductID
INNER JOIN Purchasing.ProductVendor as PV
ON P.ProductID = PV.ProductID
INNER JOIN Purchasing.Vendor AS V
ON PV.BusinessEntityID = V.BusinessEntityID
WHERE P.ListPrice > 0
GROUP BY V.[Name]
HAVING SUM(PI.Quantity) > 100
ORDER BY 3 DESC

/* Zadatak 12 */

USE Northwind
SELECT E.EmployeeID, E.FirstName, E.LastName, COUNT(*) AS 'Broj Narudzbi', Q.UkupnaProdaja AS 'Prodato'
FROM Employees AS E
INNER JOIN Orders AS O ON E.EmployeeID=O.EmployeeID
INNER JOIN (
    SELECT E1.EmployeeID, SUM(OD1.Quantity) AS 'UkupnaProdaja'
    FROM Employees AS E1
    INNER JOIN Orders AS O1 ON E1.EmployeeID=O1.EmployeeID
    INNER JOIN [Order Details] AS OD1 ON O1.OrderID=OD1.OrderID
    WHERE E1.Title LIKE 'Sales Representative'
    GROUP BY E1.FirstName, E1.LastName, E1.EmployeeID
) AS Q
ON E.EmployeeID=Q.EmployeeID
WHERE E.Title LIKE 'Sales Representative' AND Q.UkupnaProdaja>8000
GROUP BY E.FirstName, E.LastName, Q.UkupnaProdaja, E.EmployeeID
HAVING COUNT(*)>125

SELECT E.EmployeeID, E.FirstName, E.LastName,
COUNT(*) as BrojNarudzbi
FROM dbo.Employees as E
INNER JOIN dbo.Orders as O
ON E.EmployeeID = O.EmployeeID
INNER JOIN 
(
	SELECT E1.EmployeeID, SUM(OD.Quantity) as UkupnaProdaja
	FROM Employees as E1
	INNER JOIN Orders as O
	ON E1.EmployeeID = O.EmployeeID
	INNER JOIN [Order Details] as OD
	ON O.OrderID = OD.OrderID
	WHERE E1.Title LIKE '%Sales Representative%'
	GROUP BY E1.FirstName, E1.LastName, E1.EmployeeID
) as Q
ON E.EmployeeID = Q.EmployeeID
WHERE E.Title LIKE '%Sales Representative%'
GROUP BY E.EmployeeID, E.FirstName, E.LastName