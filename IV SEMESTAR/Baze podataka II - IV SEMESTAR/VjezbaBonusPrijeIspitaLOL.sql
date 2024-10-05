use AdventureWorks2017
SELECT SOH.SalesOrderID, P.FirstName, 
P.LastName, CAST(SUM(SOD.LineTotal) AS decimal(18,2)) as Ukupno
FROM Sales.SalesOrderHeader as SOH
INNER JOIN Sales.Customer AS C
ON SOH.CustomerID = C.CustomerID
INNER JOIN Person.Person AS P
ON C.PersonID = P.BusinessEntityID
INNER JOIN Sales.SalesOrderDetail AS SOD
ON SOH.SalesOrderID = SOD.SalesOrderID
GROUP BY  SOH.SalesOrderID, P.FirstName, 
P.LastName
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

GO
CREATE OR ALTER VIEW v_detalji
AS 
SELECT 
	zn.NarudzbaID,
	zn.ImeKupca, 
	zn.NazivGrada, 
	SUM(dn.Cijena*(1-dn.Popust)*dn.Kolicina) SaPopustom,
	SUM(dn.Cijena*dn.Kolicina) BezPopusta,
	IIF(zn.KreditnaKarticaID IS NULL, 'Nije placeno karticom', 'Placeno karticom') Kartica
FROM ZaglavljeNarudzbe AS zn
INNER JOIN DetaljiNaruzbe AS dn
ON zn.NarudzbaID=dn.NarudzbaID
GROUP BY zn.NarudzbaID, zn.ImeKupca, zn.NazivGrada,
IIF(zn.KreditnaKarticaID IS NULL, 'Nije placeno karticom', 'Placeno karticom')