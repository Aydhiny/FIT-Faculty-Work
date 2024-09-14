USE AdventureWorks2017

/* ZADATAK -1 */

SELECT PP.FirstName + ' ' + PP.LastName 
as 'Ime i Prezime', CC.CardType, 
CC.CardNumber, ROUND(SUM(SOH.TotalDue), 2) as 'Ukupan iznos'
FROM Person.Person as PP
INNER JOIN Sales.PersonCreditCard as PC
ON PP.BusinessEntityID = PC.BusinessEntityID
INNER JOIN Sales.CreditCard CC 
ON PC.CreditCardID = CC.CreditCardID
INNER JOIN Sales.SalesOrderHeader as SOH
ON SOH.CreditCardID = CC.CreditCardID
GROUP BY PP.FirstName, PP.LastName, CC.CardType, 
CC.CardNumber
HAVING COUNT(*) > 20
ORDER BY 4 DESC

SELECT PP.FirstName+' '+PP.LastName 'Ime i prezime', CC.CardType 'Tip kartice', CC.CardNumber 'Broj kartice',
ROUND( SUM(SOH.TotalDue),2) 'Ukupan iznos'
FROM Person.Person AS PP
	INNER JOIN Sales.PersonCreditCard AS PCC ON PP.BusinessEntityID=PCC.BusinessEntityID
	INNER JOIN Sales.CreditCard AS CC ON PCC.CreditCardID=CC.CreditCardID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON CC.CreditCardID=SOH.CreditCardID
GROUP BY PP.FirstName,PP.LastName , CC.CardType , CC.CardNumber 
HAVING COUNT(*)>20
ORDER BY 4 DESC

/* ZADATAK .2 */

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

/* ZADATAK .3 */

SELECT PP.FirstName + ' ' + PP.LastName as ImePrezime
FROM Person.Person as PP
INNER JOIN Sales.Customer as C
ON PP.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader as SOH
ON C.CustomerID = SOH.CustomerID
INNER JOIN Sales.SalesOrderDetail as SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
INNER JOIN Production.[Product] as P
ON SOD.ProductID = P.ProductID
WHERE (MONTH(SOH.OrderDate) = 5 AND 
YEAR(SOH.OrderDate) = 2014) 
AND P.[Name] LIKE '%Front Brakes%' AND SOD.OrderQty > 5

SELECT CONCAT(PP.FirstName, ' ', PP.LastName) 'Ime i prezime'
FROM Person.Person AS PP
	INNER JOIN Sales.Customer AS C ON PP.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
	INNER JOIN Sales.SalesOrderDetail AS SOD ON SOH.SalesOrderID=SOD.SalesOrderID
	INNER JOIN Production.Product AS P ON SOD.ProductID=P.ProductID
WHERE P.Name LIKE 'Front Brakes' AND YEAR(SOH.OrderDate)=2014 AND MONTH(SOH.OrderDate)=5 AND SOD.OrderQty>5

/* ZADATAK .4 */
SELECT PP.FirstName + ' ' + PP.LastName 
as ImePrezime, SUM(SOH.TotalDue) as 'Ukupni trošak'
FROM Person.Person as PP
INNER JOIN Sales.Customer as C
ON PP.BusinessEntityID = C.PersonID
INNER JOIN Sales.SalesOrderHeader as SOH
ON C.CustomerID = SOH.CustomerID
WHERE MONTH(SOH.OrderDate) = 7
GROUP BY PP.FirstName, PP.LastName 
HAVING SUM(SOH.TotalDue) > 200000
ORDER BY 2 DESC

SELECT P.FirstName, P.LastName, SUM(SOH.TotalDue) 'Ukupni trošak'
FROM Person.Person AS P
	INNER JOIN Sales.Customer AS C ON P.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
WHERE MONTH(SOH.OrderDate)=7
GROUP BY P.FirstName, P.LastName
HAVING SUM(SOH.TotalDue)>200000
ORDER BY 3 DESC

/* ZADATAK .5 */

SELECT PP.FirstName, PP.LastName, COUNT(*) 
as 'ukupno narudzbi'
FROM Person.Person as PP
INNER JOIN HumanResources.Employee as E
ON PP.BusinessEntityID = E.BusinessEntityID
INNER JOIN Sales.SalesPerson as SP
ON E.BusinessEntityID = SP.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader as SOH
ON SP.BusinessEntityID = SOH.SalesPersonID
GROUP BY PP.FirstName, PP.LastName
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

SELECT PP.[Name] as 'Naziv Proizvoda', 
PL.[Name] as 'Lokacija', PI.Quantity, SUM(PI.Quantity) as Prodajna
FROM Production.[Product] as PP
INNER JOIN Production.ProductInventory as PI
ON PP.ProductID = PI.ProductID
INNER JOIN Production.[Location] as PL
ON PI.LocationID = PL.LocationID
GROUP BY PP.[Name],PL.[Name], PI.Quantity

SELECT P.Name, L.Name, PI.Quantity,
ISNULL((SELECT SUM(SOD.OrderQty)
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.ProductID=P.ProductID
), 0) 'Prodana količina'
FROM Production.Product AS P
INNER JOIN Production.ProductInventory AS PI ON P.ProductID=PI.ProductID
INNER JOIN Production.Location AS L ON PI.LocationID=L.LocationID
WHERE PI.Quantity<30 OR 
P.ProductID NOT IN
(SELECT DISTINCT SOD.ProductID
FROM Sales.SalesOrderDetail AS SOD) 
ORDER BY 4 DESC

/* Zadatak .7 */

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

/* Zadatak .8 */

SELECT P.[Name] as NazivProizvod, 
PL.[Name] as NazivLokacije, 
PI.Quantity as StanjeZaliha, 
(
	SELECT SUM(PI1.Quantity)
	FROM Production.ProductInventory as PI1
	WHERE PI1.ProductID = P.ProductID
) AS 'Ukupno stanje zaliha',
ISNULL
((
	SELECT SUM(SOD.OrderQty)
	FROM Sales.SalesOrderHeader as SOH
	INNER JOIN Sales.SalesOrderDetail as SOD
	ON SOH.SalesOrderID = SOD.SalesOrderID
	WHERE YEAR(SOH.OrderDate) = 2013 
	AND SOD.ProductID = P.ProductID
), 0) as 'Ukupna prodana kolicina'
FROM Production.Product as P
INNER JOIN Production.ProductInventory as PI
ON P.ProductID = PI.ProductID
INNER JOIN Production.[Location] as PL
ON PI.LocationID = PL.LocationID
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

/* Zadatak .9 */
SELECT SOH.SalesOrderID, PP.FirstName, 
PP.LastName, CAST(SUM(SOD.LineTotal) as decimal(18,2)) Total
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.Customer as C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person as PP
ON C.PersonID = PP.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail as SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY SOH.SalesOrderID, PP.FirstName, 
PP.LastName
HAVING SUM(SOD.OrderQty * SOD.UnitPrice * SOD.UnitPriceDiscount)
>= 100
ORDER BY 4 

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

SELECT TOP 1 IIF(RIGHT(P.FirstName, 1)='a','F','M') as Spol, 
COUNT(*) as BrojNarudzbi, CAST(SUM(SOH.TotalDue) as Decimal(18,2)) UkupnaPotrosena
FROM Sales.Customer as C
INNER JOIN Person.Person as P
ON C.PersonID = P.BusinessEntityID
INNER JOIN Sales.SalesOrderHeader as SOH
ON C.CustomerID = SOH.CustomerID
GROUP BY IIF(RIGHT(P.FirstName, 1)='a','F','M')
ORDER BY 2 DESC


SELECT TOP 1 IIF(RIGHT(P.FirstName, 1) LIKE 'a', 'F', 'M') 'Spol', COUNT(*) 'Ukupan broj narudzbi', 
ROUND(SUM(SOH.TotalDue), 2) 'Ukupna potrošena vrijednost'
FROM Person.Person AS P
	INNER JOIN Sales.Customer AS C ON P.BusinessEntityID=C.PersonID
	INNER JOIN Sales.SalesOrderHeader AS SOH ON C.CustomerID=SOH.CustomerID
GROUP BY IIF(RIGHT(P.FirstName, 1) LIKE 'a', 'F', 'M')
ORDER BY 2 DESC

/* Zadatak .11 */

SELECT COUNT(*) as UkupanBrojProizvoda
FROM Production.[Product] as P
INNER JOIN 