/* Iz tabele HumanResources.Employee baze AdventureWorks2017 iz kolone LoginID izvući 
ime uposlenika.  */
USE AdventureWorks2017
SELECT E.LoginID
FROM HumanResources.Employee as E

USE AdventureWorks2017
SELECT * FROM HumanResources.Employee

/* FUNCKIJE SA STRINGOVIMA */
SELECT LEFT ('Softverski inzinjering', 2) -- rezultat So
SELECT RIGHT('Softverski inzinjering', 2) -- rezultat ng
SELECT CHARINDEX(' ', 'Softverski inzinjering') -- rezultat 11
SELECT PATINDEX('%[0-9]%', 'FITCC2022')
SELECT SUBSTRING('Softverski inzinjering', 11+1,11) AS 'Substring funkcija'-- rezultat Inzinjering
SELECT UPPER('Softverski inzinjering') -- SOTTVERSKI INZINJERING
SELECT LOWER('Softverski inzinjering') -- softverski inzinjering
SELECT LEN('Softverski inzinjering') -- 22
SELECT REPLACE('Softverski inzinjering', 'i', 'hehe') -- Softverskhehe hehenzhehenjerheheng
SELECT STUFF('Softverski inzinjering', 11, 22, 'heheHAHA') -- SoftverskiheheHAHA

USE AdventureWorks2017
SELECT E.LoginID, SUBSTRING(E.LoginID, CHARINDEX('\', E.LoginID)+1, LEN(E.LoginID) - CHARINDEX('\', E.LoginID)+1)
FROM HumanResources.Employee as E

/* Kreirati upit koji prikazuje podatke o zaposlenicima. Lista treba da sadrži sljedeće kolone: ID 
uposlenika, korisničko ime i novu lozinku:
 Uslovi su sljedeći: 
• Za korisničko ime potrebno je koristiti kolonu LoginID (tabela Employees). Npr. 
LoginID zaposlenika sa identifikacijskim brojem 23 je adventureworks\mary0. 
Korisničko ime zaposlenika je sve što se nalazi iza znaka \ (backslash) što je u ovom 
primjeru mary0, */

Use AdventureWorks2017
SELECT *, RIGHT (E. LoginID, CHARINDEX('\', REVERSE (E. LoginID))-1) AS 'Korisnicko ime', STUFF 
(SUBSTRING(REVERSE (E.rowguid), 6,8), 2, 2, 'X#') 'Nova lozinka'
FROM HumanResources.Employee as E

/* Nova lozinka se formira koristeći Rowguid zaposlenika na sljedeći način: Rowguid je 
potrebno okrenuti obrnuto (npr. dbms2015 -> 5102smbd) i nakon toga preskačemo 
prvih 5 i uzimamo narednih 7 karaktera. Sljedeći korak jeste da iz dobijenog stringa 
počevši od drugog karaktera naredna dva zamijenimo sa X# (npr. ako je dobiveni 
string dbms2015 izlaz će biti dX#s2015) */

Use AdventureWorks2017
SELECT *
FROM Sales.Customer as C

/* . Iz tabele Sales.Customer baze AdventureWorks2017 iz kolone AccountNumber izvući broj pri 
čemu je potrebno broj prikazati bez vodećih nula. 
a) dohvatiti sve zapise 
b) dohvatiti one zapise kojima je unijet podatak u kolonu PersonID*/