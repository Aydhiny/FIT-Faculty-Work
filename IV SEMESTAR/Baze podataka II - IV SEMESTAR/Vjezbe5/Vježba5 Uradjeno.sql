--Vježba 5 :: Zadaci 

--1.	Prikazati ukupnu vrijednost troška prevoza po državama ali samo ukoliko je veæa od 4000 za robu koja se kupila u Francuskoj, Njemaèkoj ili Švicarskoj. (Northwind)
USE Northwind
SELECT O.ShipCountry, SUM(O.Freight)
FROM Orders AS O
WHERE O.ShipCountry IN ('France', 'Germany', 'Switzerland')
GROUP BY O.ShipCountry
HAVING SUM(O.Freight)>4000

--2.	Prikazati 10 najprodavanijih proizvoda. Za proizvod je dovoljno prikazati njegov identifikacijski broj. Ulogu najprodavanijeg ima onaj koji je u najvećim količinama prodat. (Northwind)
USE Northwind
SELECT TOP 10 OD.ProductID, SUM(OD.Quantity) 'Ukupan broj prodanih proizvoda'
FROM [Order Details] AS OD
GROUP BY OD.ProductID
ORDER BY 2 DESC

--3.	Kreirati upit koji prikazuje zaradu od prodaje proizvoda. Lista treba da sadrži identifikacijski broj proizvoda, ukupnu zaradu bez popusta, ukupnu zaradu sa popustom. Vrijednost zarade zaokružiti na dvije decimale. Uslov je da se prikaže zarada samo za stavke gdje je bilo popusta. Listu sortirati prema ukupnoj zaradi sa popustom u opadajućem redoslijedu.
USE AdventureWorks2017
SELECT SOD.ProductID, 
ROUND(SUM(SOD.OrderQty*SOD.UnitPrice), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL(18, 2))'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
WHERE SOD.UnitPriceDiscount>0
GROUP BY SOD.ProductID
ORDER BY 3 DESC
 
--4.	Prikazati tip popusta, naziv prodavnice i njen id. (Pubs) 
USE pubs
SELECT D.discounttype, S.stor_name, S.stor_id
FROM discounts AS D
INNER JOIN stores AS S
ON D.stor_id=S.stor_id

--5.	Prikazati id uposlenika, ime i prezime, te naziv posla koji obavlja. (Pubs)  
SELECT E.emp_id, E.fname, E.lname, J.job_desc
FROM employee AS E
INNER JOIN jobs AS J
ON E.job_id=J.job_id

--6.	Prikazati spojeno ime i prezime uposlenika, teritoriju i regiju koju pokriva. Uslov je da su zaposlenici mlađi od 60 godina. (Northwind) 
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

--7.	Prikazati ukupnu vrijednost obrađenih narudžbi sa popustom za svakog uposlenika pojedinačno. Uslov je da su narudžbe kreirane u 1996. godini, te u obzir uzeti samo one uposlenike čija je ukupna ukupna obrađena vrijednost veća od 20000. Podatke sortirati prema ukupnoj vrijednosti (zaokruženoj na dvije decimale) u rastućem redoslijedu. (Northwind)  
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

--8.	Prikazati naziv dobavljača, adresu i državu dobavljača, te nazive proizvoda koji pripadaju kategoriji pića a ima ih na stanju više od 30 komada. Rezultate upita sortirati po državama u abedecnom redoslijedu. (Northwind)  
USE Northwind
SELECT S.ContactName, S.Address, S.Country, P.ProductName
FROM Suppliers AS S
INNER JOIN Products AS P
ON S.SupplierID=P.SupplierID
INNER JOIN Categories AS C
ON C.CategoryID=P.CategoryID
WHERE P.UnitsInStock>30 AND C.Description LIKE '%drinks%'
ORDER BY 3

--9.	Prikazati kontakt ime kupca, njegov id, id narudžbe, datum kreiranja narudžbe (prikazan u formatu dan.mjesec.godina, npr. 24.07.2021) te ukupnu vrijednost narudžbe sa i bez popusta. Prikazati samo one narudžbe koje su kreirane u 1997. godini. Izračunate vrijednosti zaokružiti na dvije decimale, te podatke sortirati prema ukupnoj vrijednosti narudžbe sa popustom u opadajućem redoslijedu. (Northwind) 
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

--10.	U tabeli Customers baze Northwind ID kupca je primarni ključ. 
--U tabeli Orders baze Northwind ID kupca je vanjski ključ. 
--Koristeći set operatore prikazati:  
--a)	kupce koji su obavili narudžbu    
--INTERSECTOM MOŽEMO PROVJERITI DA LI SU SVI KUPCI OBAVILI NARUDŽBU
SELECT C.CustomerID
FROM Customers AS C
INTERSECT
SELECT O.CustomerID
FROM Orders AS O
--b)	one kupce koji nisu obavili narudžbu (ukoliko ima takvih)  
SELECT C.CustomerID
FROM Customers AS C
EXCEPT
SELECT O.CustomerID
FROM Orders AS O
--ILI LEFT JOIN
SELECT C.CustomerID,O.OrderID
FROM Customers AS C
LEFT OUTER JOIN Orders AS O
ON O.CustomerID=C.CustomerID
WHERE O.OrderID IS NULL

--11.	 Dati pregled vanrednih prihoda svih osoba (i onih koji nemaju vanredne prihode). Pregled treba da sadrži sljedeće kolone: OsobaID, Ime, VanredniPrihodID, IznosPrihoda (Prihodi)
USE prihodi
SELECT O.OsobaID, O.Ime, VP.VanredniPrihodiID, VP.IznosVanrednogPrihoda
FROM Osoba AS O
LEFT OUTER JOIN VanredniPrihodi AS VP
ON VP.OsobaID=O.OsobaID

--12.	Dati pregled redovnih prihoda svih osoba (i onih koji nemaju redovne prihode). Pregled treba da sadrži sljedeće kolone: OsobaID, Ime, RedovniPrihodID, Neto (Prihodi) 
SELECT O.OsobaID,O.Ime,RP.RedovniPrihodiID,RP.Neto
FROM Osoba AS O
LEFT OUTER JOIN RedovniPrihodi AS RP
ON O.OsobaID=RP.OsobaID

--13.	Odrediti da li je svaki autor napisao bar po jedan naslov. (Pubs) 
-- OVIM VIDIMO DA SVI AUTORI NISU NAPISALI PO JEDAN NASLOV
USE pubs
SELECT A.au_id
FROM authors AS A
INTERSECT 
SELECT TA.au_id
FROM titleauthor AS TA

SELECT*
FROM authors

--a)	ako ima autora koji nisu napisali niti jedan naslov navesti njihov ID. 
SELECT A.au_id 'Autori bez naslova'
FROM authors AS A
LEFT OUTER JOIN titleauthor AS TA
ON A.au_id=TA.au_id
WHERE TA.title_id IS NULL
--ILI
SELECT A.au_id 
FROM authors AS A
EXCEPT
SELECT TA.au_id 
FROM titleauthor AS TA

--b)	dati pregled autora koji su napisali bar po jedan naslov. 
-- DISTINCT UKOLIKO ŽELIMO DA SE JEDAN AUTOR NE PONAVLJA VIŠE PUTA
SELECT DISTINCT A.au_id 'Autori s naslovima'
FROM authors AS A
INNER JOIN titleauthor AS TA
ON A.au_id=TA.au_id
--ILI
SELECT A.au_id
FROM authors AS A
INTERSECT
SELECT TA.au_id
FROM titleauthor AS TA

--14.	Prikazati 10 najskupljih stavki narudžbi. Upit treba da sadrži id stavke, naziv proizvoda, količinu, cijenu i vrijednost stavke narudžbe. Cijenu i vrijednost stavke narudžbe zaokružiti na dvije decimale. Izlaz formatirati na način da uz količinu stoji “kom” (npr. 50 kom) a uz cijenu i vrijednost stavke narudžbe “KM” (npr. 50 KM). (AdventureWorks2017) 
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

--15.	Kreirati upit koji prikazuje ukupan broj narudžbi po teritoriji na kojoj je kreirana narudžba. Lista treba da sadrži sljedeće kolone: naziv teritorije, ukupan broj narudžbi. Uzeti u obzir samo teritorije na kojima je kreirano više od 1000 narudžbi. (AdventureWorks2017)  
SELECT ST.Name, COUNT(*) 'Ukupan broj narudžbi'
FROM Sales.SalesOrderHeader AS SOH
INNER JOIN Sales.SalesTerritory AS ST
ON SOH.TerritoryID=ST.TerritoryID
GROUP BY ST.Name
HAVING COUNT(*) >1000

--16.	Kreirati upit koji prikazuje zaradu od prodaje proizvoda. Lista treba da sadrži naziv proizvoda, ukupnu zaradu bez uračunatog popusta i ukupnu zaradu sa uračunatim popustom. Iznos zarade zaokružiti na dvije decimale. Uslov je da se prikaže zarada samo za stavke gdje je bilo popusta. Listu sortirati po zaradi opadajućim redoslijedom. (AdventureWorks2017)
SELECT PP.Name,
ROUND(SUM(SOD.UnitPrice*SOD.OrderQty), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL (18,2)) 'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Production.Product AS PP
ON PP.ProductID=SOD.ProductID
WHERE SOD.UnitPriceDiscount>0
GROUP BY PP.Name
ORDER BY 3 DESC 
--ILI
SELECT PP.Name,
ROUND(SUM(SOD.UnitPrice*SOD.OrderQty), 2) 'Ukupna zarada bez popusta', 
CAST(ROUND(SUM(SOD.LineTotal), 2) AS DECIMAL (18,2)) 'Ukupna zarada sa popustom'
FROM Sales.SalesOrderDetail AS SOD
INNER JOIN Sales.SpecialOfferProduct AS SOP
ON SOD.ProductID =SOP.ProductID AND SOD.SpecialOfferID=SOP.SpecialOfferID
INNER JOIN Production.Product AS PP
ON SOP.ProductID=PP.ProductID
WHERE SOD.UnitPriceDiscount>0
GROUP BY PP.Name
ORDER BY 3 DESC 



 
