/* VJEŽBA 5 */

SELECT O.ShipCountry, SUM(O.Freight) as TotalFreight
FROM Northwind.dbo.Orders as O
WHERE O.ShipCountry IN ('France', 'Germany','Switzerland')
GROUP BY O.ShipCountry
HAVING SUM(Freight) > 4000

SELECT TOP 10 P.ProductID, SUM(P.UnitPrice * P.UnitsInStock)
FROM Northwind.dbo.Products as P
GROUP BY SUM(P.UnitPrice * P.UnitsInStock)