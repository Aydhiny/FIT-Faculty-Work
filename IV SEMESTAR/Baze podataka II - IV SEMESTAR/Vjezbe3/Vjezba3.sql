/* 2. Koristeći bazu Northwind izračunati koliko je godina prošlo od datum narudžbe do danas. 
3. Koristeći bazu Northwind dohvatiti sve zapise u kojima ime zaposlenika počinje slovom A. 
4. Koristeći bazu Pubs dohvatiti sve zapise u kojima ime zaposlenika počinje slovom A ili M. 
*/

SELECT YEAR(O.ShippedDate), MONTH(O.ShippedDate), DAY(O.ShippedDate)  
FROM Northwind.dbo.Orders as O

SELECT *
FROM Northwind.dbo.Employees as E
WHERE E.FirstName LIKE 'A%' 

USE pubs
SELECT * FROM dbo.employee as E
WHERE E.fname LIKE 'A%' OR E.fname LIKE 'M%'

USE Northwind
SELECT * FROM dbo.Customers as C
WHERE C.ContactTitle LIKE '%manager%'

USE Northwind
SELECT * FROM dbo.Customers as C
WHERE C.PostalCode LIKE '[0-9]%' AND C.PostalCode NOT LIKE '%-%'

USE AdventureWorks2017
SELECT DISTINCT PP.FirstName + ' ' + PP.LastName + ' ' + ISNULL(PP.MiddleName, ' ')
FROM Person.Person AS PP
/*
7. Koristeći bazu AdventureWorks2017 prikazati spojeno ime, srednje ime i prezime osobe. Uslov je 
da se između pojedinih segmenata nalazi space. Omogućiti prikaz podataka i ako neki od podataka 
nije unijet. Prikazati samo jedinstvene zapise (bez ponavljanja istih zapisa).  */

/* . Prikazati listu zaposlenika sa sljedećim atributima: Id, ime, prezime, država i titula, gdje je Id 9 ili 
dolaze iz Amerike.  */

USE Northwind
SELECT E.EmployeeID, E.FirstName, E.LastName, E.Country FROM dbo.Employees as E
WHERE E.EmployeeID = 9 OR E.Country LIKE 'USA'

/* Prikazati podatke o narudžbama koje su napravljene prije 19.07.1996. godine. Izlaz treba da sadrži 
sljedeće kolone: Id narudžbe, datum narudžbe, ID kupca, te grad. */

USE Northwind
SELECT O.OrderID, O.OrderDate, O.CustomerID, O.ShipCity
FROM dbo.Orders as O
WHERE O.OrderDate < '1996-07-19'

/* Prikazati stavke narudžbe gdje je količina narudžbe bila veća od 100 komada uz odobreni popust. */

USE Northwind
SELECT *
FROM dbo.[Order Details] as OD
WHERE OD.Quantity > 100 AND OD.Discount > 0

/* Prikazati ime kompanije kupca i kontakt telefon i to samo onih koji u svome imenu posjeduju riječ 
„Restaurant“. Ukoliko naziv kompanije sadrži karakter (-), kupce izbaciti iz rezultata upita */

USE Northwind
SELECT C.CompanyName, C.Phone
FROM dbo.Customers as C
WHERE C.CompanyName LIKE '%Restaurant%' AND c.CompanyName NOT LIKE '%-%'

/* 2. Prikazati proizvode čiji naziv počinje slovima „C“ ili „G“, drugo slovo može biti bilo koje, a treće 
slovo u nazivu je „A“ ili „O“.  */

USE Northwind
SELECT *
FROM dbo.Products as P
WHERE P.ProductName LIKE '[CG]_[AO]%'

/* . Prikazati listu proizvoda čiji naziv počinje slovima „L“ ili „T“, ili je ID proizvoda = 46. Lista treba 
da sadrži samo one proizvode čija se cijena po komadu kreće između 10 i 50 (uključujući granične 
vrijednosti). Upit napisati na dva načina.  */

USE Northwind
SELECT *
FROM dbo.Products as P
WHERE (P.ProductName LIKE '[LT]%' OR P.CategoryID = 46) AND P.UnitPrice BETWEEN 10 AND 50

USE Northwind
SELECT *
FROM dbo.Products as P
WHERE (P.ProductName LIKE '[LT]%' OR P.CategoryID = 46) AND P.UnitPrice >= 10 AND P.UnitPrice <= 50

/* Prikazati naziv proizvoda i cijenu, gdje je stanje na zalihama manje od naručene količine. Također, 
u rezultate upita uključiti razliku između stanja zaliha i naručene količine.  */

USE Northwind
SELECT *
FROM dbo.Products as P
WHERE (P.ProductName LIKE '[LT]%' OR P.CategoryID = 46) AND P.UnitPrice >= 10 AND P.UnitPrice <= 50

/* Prikazati sve podatke o dobavljačima koji dolaze iz Španije ili Njemačke a nemaju unesen broj 
faxa. Formatirati izlaz NULL vrijednosti na način da se prikaže umjesto NULL prikladno 
objašnjenje. Upit napisati na dva načina. */

USE Northwind
SELECT *
FROM dbo.Suppliers as S
WHERE (S.Country = 'Spain' OR S.Country = 'Germany') AND S.Fax IS NULL

/* Prikazati listu autora sa sljedećim kolonama: Id, ime i prezime (spojeno), grad i to samo one autore 
čiji Id počinje brojem 8 ili dolaze iz grada „Salt Lake City“. Također autorima status ugovora treba 
biti 1. Koristiti aliase nad kolonama.*/

USE pubs
SELECT A.au_id, A.au_fname + ' ' + A.au_lname AS 'Ime Prezime', A.city
FROM dbo.authors as A
WHERE (A.au_id LIKE '8%' OR A.city = 'Salt Lake City') AND A.contract = 1

/* Prikazati sve tipove knjiga bez duplikata. Listu sortirati u abecednom redoslijedu. */
USE pubs
SELECT DISTINCT T.type
FROM dbo.titles as T
ORDER BY 1 asc

/* 8. Prikazati listu prodaje knjiga sa sljedećim kolonama: Id prodavnice, broj narudžbe i količinu, ali 
samo gdje je količina između 10 i 50, uključujući i granične vrijednosti. Rezultat upita sortirati po 
količini opadajućim redoslijedom. Upit napisati na dva načina */

USE pubs
SELECT S.stor_id, S.ord_num, S.qty
FROM dbo.sales as S 
WHERE S.qty BETWEEN 10 AND 50 
ORDER BY 3 DESC

/* Prikazati listu knjiga sa sljedećim kolonama: naslov, tip djela i cijena. Kao novu kolonu dodati 
20% od prikazane cijene (npr. Ako je cijena 19.99 u novoj koloni treba da piše 3,998). Naziv 
kolone se treba zvati „20% od cijene“. Listu sortirati abecedno po tipu djela i po cijeni opadajućim 
redoslijedom. Sa liste eliminisati one knjige koje nemeju pohranjenu vrijednost cijene. 
Modifikovati upit tako da uz već prikazane kolone se prikaže i cijena umanjena za 20 %. Naziv 
kolone treba da se zove „Cijena umanjena za 20%“ */

SELECT 
    T.title AS Naslov,
    T.type AS TipDjela,
    T.price AS Cijena,
    ROUND(T.price * 0.20, 3) AS [20% od cijene],
    ROUND(T.price * 0.80, 2) AS [Cijena umanjena za 20%]
FROM dbo.titles AS T
WHERE T.price IS NOT NULL
ORDER BY T.type ASC, T.price DESC;

/*  Prikazati 10 količinski najvećih stavki prodaje. Lista treba da sadrži broj narudžbe, datum narudžbe 
i količinu. Provjeriti da li ima više stavki sa količinom kao posljednja u listi, te uključiti ih u 
rezultate upita ukoliko postoje.  */

USE pubs;
SELECT 
    S.ord_num, 
    S.ord_date, 
    S.qty
FROM dbo.sales AS S
WHERE S.qty >= (
    SELECT MIN(qty)
    FROM (
        SELECT TOP 10 qty
        FROM dbo.sales
        ORDER BY qty DESC
    ) AS Top10
)
ORDER BY S.qty DESC;