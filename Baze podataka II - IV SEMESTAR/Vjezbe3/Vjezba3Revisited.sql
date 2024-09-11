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