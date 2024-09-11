SELECT DAY(O.OrderDate), MONTH(O.OrderDate), year(O.OrderDate)
FROM
Northwind.dbo.Orders AS O

SELECT 2024 - YEAR(O.OrderDate)
FROM Northwind.dbo.Orders AS O

SELECT * 
FROM Northwind.dbo.Employees as E
WHERE E.FirstName LIKE 'A%'

SELECT * 
FROM PUBS.dbo.employee as E
WHERE E.fname LIKE 'A%' OR E.fname LIKE 'M%'

SELECT * 
FROM Northwind.dbo.Customers as C
WHERE C.ContactTitle LIKE '%manager%'

SELECT * 
FROM Northwind.dbo.Customers
WHERE PostalCode LIKE '%[0-9]%' AND PostalCode NOT LIKE '%[^0-9]%';

SELECT P.FirstName + ' ' + ISNULL(P.MiddleName, '') + ' ' + P.LastName
FROM AdventureWorks2017.Person.Person as P

SELECT E.EmployeeID, E.FirstName, E.LastName, E.Country, E.Title
FROM Northwind.dbo.Employees as E
WHERE E.EmployeeID = 9 OR E.Country = 'USA'

/* ZADATAK .9 */
SELECT O.OrderID, O.OrderDate, O.CustomerID, O.ShipCity
FROM Northwind.dbo.Orders as O
WHERE O.OrderDate < '1996-07-19'

/* ZADATAK .10 */
SELECT * FROM
Northwind.dbo.[Order Details]

SELECT *
FROM Northwind.dbo.[Order Details] as O
WHERE O.Quantity > 100 AND O.Discount > 0

SELECT * FROM
Northwind.dbo.Customers


/* ZADATAK 11. */
SELECT C.CompanyName, C.Phone
FROM Northwind.dbo.Customers as C
WHERE C.CompanyName LIKE '%Restaurant%' 
AND C.CompanyName NOT LIKE '%-%'

/* ZADATAK 12. */
SELECT *
FROM Northwind.dbo.Products as P
WHERE P.ProductName LIKE '[CG]_[AO]%'

/* ZADATAK 13. */
SELECT *
FROM Northwind.dbo.Products as P
WHERE (P.ProductName LIKE '[LT]%' OR P.ProductID = 46) 
AND (P.UnitPrice BETWEEN 10 AND 50)

SELECT *
FROM Northwind.dbo.Products as P
WHERE (P.ProductName LIKE '[LT]%' OR P.ProductID = 46) 
AND (P.UnitPrice >= 10 AND P.UnitPrice <= 50)

/* ZADATAK 14. */
SELECT P.ProductName, P.UnitPrice, 
(UnitsOnOrder - UnitsInStock) AS StockDifference
FROM Northwind.dbo.Products as P
WHERE P.UnitsInStock < P.UnitsOnOrder


/* ZADATAK 15. */
SELECT SupplierID, 
    CompanyName, 
    ContactName, 
    Country, 
    Phone, 
    COALESCE(Fax, 'Nema unesen faks broj') AS FaxStatus
FROM Northwind.dbo.Suppliers as S
WHERE (S.Country = 'Spain' OR S.Country = 'Germany') 
AND S.Fax IS NULL

/* PUBS. */
/* ZADATAK 16. */

SELECT * FROM pubs.dbo.authors

SELECT A.au_id, A.au_fname + ' ' + A.au_lname AS ImePrezime, A.city
FROM pubs.dbo.authors as A
WHERE (A.au_id LIKE '8%' OR A.city = 'Salt Lake City') AND 
A.[contract] = 1

/* ZADATAK 17. */
SELECT DISTINCT T.type
FROM pubs.dbo.titles as T
ORDER BY 1 ASC

/* ZADATAK 18. */
SELECT S.stor_id, S.ord_num, S.qty
FROM pubs.dbo.sales as S 
WHERE S.qty BETWEEN 10 AND 50
ORDER BY 3 DESC

SELECT S.stor_id, S.ord_num, S.qty
FROM pubs.dbo.sales as S 
WHERE S.qty >= 10 AND S.qty <= 50
ORDER BY 3 DESC

/* ZADATAK 19. */

SELECT T.title, T.[type], T.price, 
    CAST(ROUND(T.price * 0.20, 2) AS DECIMAL(10, 2)) AS [20% od cijene],
    CAST(ROUND(T.price * 0.80, 2) AS DECIMAL(10, 2)) AS [Cijena umanjena za 20%]
FROM pubs.dbo.titles as T
WHERE T.price IS NOT NULL
ORDER BY 2 ASC, 3 DESC

/* ZADATAK 19. */

SELECT S.ord_num, S.ord_date, S.qty
FROM pubs.dbo.sales as S

/* ZADATAK 20. */