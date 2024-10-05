USE pubs

SELECT E.fname, E.lname, AVG(S.qty) as ProsjekProdat
FROM dbo.employee as E
INNER JOIN dbo.jobs as J ON E.job_id = J.job_id
INNER JOIN dbo.publishers as P ON E.pub_id = P.pub_id
INNER JOIN dbo.titles as T ON P.pub_id = T.pub_id
INNER JOIN dbo.sales as S on T.title_id = S.title_id
WHERE J.job_desc LIKE '%Designer%'
GROUP BY  E.fname, E.lname
HAVING AVG(S.qty) > 
(
	SELECT AVG(S.qty)
	FROM dbo.sales as S
	INNER JOIN dbo.titles as T
	ON T.title_id = S.title_id
	WHERE T.pub_id = 0877
)

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

/* VJEŽBA .9 */

/* Zadatak 1*/
CREATE DATABASE View_
USE View_
/* Zadatak 2*/
GO
CREATE VIEW v_Employee
AS 
SELECT E.FirstName + ' ' + E.LastName 
as 'Ime i prezime', 
T.TerritoryDescription as 'Teritorija', R.RegionDescription as Regija
FROM Northwind.dbo.Employees as E
INNER JOIN Northwind.dbo.EmployeeTerritories as ET ON E.EmployeeID = ET.EmployeeID
INNER JOIN Northwind.dbo.Territories as T on ET.TerritoryID = T.TerritoryID
INNER JOIN Northwind.dbo.Region as R ON T.RegionID = R.RegionID
WHERE YEAR(GETDATE()) - YEAR(E.BirthDate) > 60
GO

GO
CREATE VIEW v_Employee1
AS
SELECT E.[FirstName] + ' ' + E.[LastName] 'Ime i prezime', T.[TerritoryDescription] 'Teritorija', R.[RegionDescription] 'Regija'
FROM Northwind.dbo.Employees AS E
INNER JOIN Northwind.dbo.EmployeeTerritories AS ET ON E.EmployeeID=ET.EmployeeID
INNER JOIN Northwind.dbo.Territories AS T ON ET.TerritoryID=T.TerritoryID
INNER JOIN Northwind.dbo.Region AS R ON T.RegionID=R.RegionID
WHERE DATEDIFF (YEAR, E.[BirthDate], GETDATE ()) > 60
GO

SELECT * FROM v_Employee;
SELECT * FROM v_Employee1;

/* Zadatak 3*/

SELECT V.[Ime i prezime], V.Regija, COUNT(V.Teritorija) as BrojTeritorija
FROM v_Employee as V
GROUP BY V.[Ime i prezime], V.Regija
ORDER BY 3 DESC, 1 ASC

SELECT VE.[Ime i prezime], VE.Regija, COUNT(VE.Teritorija) 'Broj teritorija'
FROM v_Employee AS VE
GROUP BY VE.[Ime i prezime], VE.Regija
ORDER BY 3 DESC,1

/* Zadatak 4*/

GO
CREATE VIEW v_Sales
AS
SELECT C.CustomerID as IDKupca, 
P.FirstName + ' ' + P.LastName 
as ImePrezime, YEAR(SOH.OrderDate) 
as GodinaNarudzbe, SOH.SubTotal as Vrijednost
FROM AdventureWorks2017.Sales.Customer as C
INNER JOIN AdventureWorks2017.Person.Person as P
ON C.PersonID = P.BusinessEntityID
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader as SOH
ON C.CustomerID = SOH.CustomerID
GO

GO 
CREATE VIEW v_Sales1
AS
SELECT SC.CustomerID 'Id kupca', CONCAT(PP.FirstName, ' ', PP.LastName) 'Ime i prezime kupca', YEAR(SOH.OrderDate) 'Godina narudžbe', SOH.SubTotal 'Vrijednost'
FROM AdventureWorks2017.Person.Person AS PP
INNER JOIN AdventureWorks2017.Sales.Customer AS SC ON PP.BusinessEntityID=SC.PersonID
INNER JOIN AdventureWorks2017.Sales.SalesOrderHeader AS SOH ON SC.CustomerID=SOH.CustomerID
GO

/* Zadatak 5 */

SELECT V.ImePrezime, V.GodinaNarudzbe, SUM(V.Vrijednost) 
as SumarniPromet
FROM v_Sales as V
GROUP BY V.ImePrezime, V.GodinaNarudzbe

/* Zadatak 6 */

SELECT V.ImePrezime, V.Vrijednost
FROM v_Sales AS V
ORDER BY V.Vrijednost DESC

GO
CREATE VIEW v_Sales2013
AS
SELECT *
FROM v_Sales AS VS
WHERE  VS.GodinaNarudzbe= 2013
GO

SELECT VS13.ImePrezime, VS13.Vrijednost
FROM v_Sales2013 AS VS13
WHERE VS13.Vrijednost BETWEEN 
(SELECT AVG (VS13_2.Vrijednost) FROM v_Sales2013 AS VS13_2) - 
0.1 * (SELECT AVG (VS13_2.Vrijednost) FROM v_Sales2013 AS VS13_2)
AND
(SELECT AVG (VS13_2.Vrijednost) FROM v_Sales2013 AS VS13_2) +
0.1 * (SELECT AVG (VS13_2.Vrijednost) FROM v_Sales2013 AS VS13_2)
ORDER BY 2 DESC

SELECT VS13.ImePrezime, VS13.Vrijednost
FROM v_Sales2013 AS VS13
WHERE VS13.Vrijednost BETWEEN 
(
	SELECT AVG(V13_2.Vrijednost) - 0.1 * 
	(
		SELECT AVG(V13_2.Vrijednost)
		FROM v_Sales2013 AS V13_2
	)
	FROM v_Sales2013 AS V13_2
)
AND 
(
	SELECT AVG(V13_2.Vrijednost) + 0.1 * 
	(
		SELECT AVG(V13_2.Vrijednost)
		FROM v_Sales2013 AS V13_2
	)
	FROM v_Sales2013 AS V13_2
)
ORDER BY 2 DESC


SELECT * FROM Northwind.dbo.Employees
GO


SELECT * INTO Zaposlenici
FROM Northwind.dbo.Employees;

SELECT * FROM Zaposlenici

GO
CREATE VIEW v_Zaposlenici
AS
SELECT Z.EmployeeID, Z.FirstName, Z.LastName, Z.Country
FROM Zaposlenici as Z
GO

GO
ALTER VIEW v_Zaposlenici
AS
SELECT Z.EmployeeID, Z.FirstName, Z.LastName, Z.Country
FROM Zaposlenici as Z
WHERE Z.Country IN ('USA', 'UK')
GO

SELECT * FROM
v_Zaposlenici


INSERT 
INTO v_Zaposlenici
VALUES ('Amer', 'Mehmedovic', 'UK')

INSERT 
INTO v_Zaposlenici
VALUES ('Amer', 'Mehmedovic', 'Bosna')

/* Zadatak .11 */

GO
CREATE VIEW v_Purchasing
AS
SELECT V.[Name], POD.PurchaseOrderID, POD.DueDate, 
POD.OrderQty, POD.UnitPrice, POD.OrderQty * POD.UnitPrice as Ukupno
FROM AdventureWorks2017.Purchasing.Vendor as V
INNER JOIN AdventureWorks2017.Purchasing.PurchaseOrderHeader as POH
ON V.BusinessEntityID = POH.VendorID
INNER JOIN AdventureWorks2017.Purchasing.PurchaseOrderDetail as POD
ON POH.PurchaseOrderID = POD.PurchaseOrderID
WHERE DATEPART(QUARTER, POD.DueDate) IN (1,3)
GO

SELECT * FROM v_Purchasing
SELECT * FROM v_Purchasing1

GO
CREATE VIEW V_Purchasing1
AS
SELECT V.Name, POD.PurchaseOrderID, POD.DueDate, POD.OrderQty, POD.UnitPrice, POD.UnitPrice*POD.OrderQty 'Ukupno'
FROM AdventureWorks2017.Purchasing.Vendor AS V
INNER JOIN AdventureWorks2017.Purchasing.PurchaseOrderHeader AS POH ON V.BusinessEntityID=POH.VendorID
INNER JOIN AdventureWorks2017.Purchasing.PurchaseOrderDetail AS POD ON POH.PurchaseOrderID=POD.PurchaseOrderID
WHERE DATEPART(QUARTER,POD.DueDate)=1 OR DATEPART(QUARTER,POD.DueDate)=3
--WHERE MONTH (POD.DueDate) IN (1,2,3,7,8,9)
--DATEPART(QUARTER,POD.DueDate) IN (1,3)
GO

SELECT V.[Name], V.PurchaseOrderID, V.Ukupno
FROM v_Purchasing as V