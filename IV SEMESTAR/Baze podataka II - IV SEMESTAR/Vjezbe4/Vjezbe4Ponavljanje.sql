/* . Iz tabele HumanResources.Employee baze AdventureWorks2017 iz kolone LoginID izvući 
ime uposlenika. */

USE AdventureWorks2017
SELECT E.LoginID, SUBSTRING(E.LoginID, CHARINDEX('\', E.LoginID) + 1, PATINDEX('%[0-9]%', E.LoginID))
FROM HumanResources.Employee as E

USE AdventureWorks2017;
SELECT E.LoginID, 
       LEFT(SUBSTRING(E.LoginID, CHARINDEX('\', E.LoginID) + 1, LEN(E.LoginID)), 
            PATINDEX('%[0-9]%', SUBSTRING(E.LoginID, CHARINDEX('\', E.LoginID) + 1, LEN(E.LoginID)) + '0') - 1) AS EmployeeName
FROM HumanResources.Employee AS E;

/* Kreirati upit koji prikazuje podatke o zaposlenicima. Lista treba da sadrži sljedeće kolone: ID 
uposlenika, korisničko ime i novu lozinku:
 Uslovi su sljedeći: 
• Za korisničko ime potrebno je koristiti kolonu LoginID (tabela Employees). Npr. 
LoginID zaposlenika sa identifikacijskim brojem 23 je adventureworks\mary0. 
Korisničko ime zaposlenika je sve što se nalazi iza znaka \ (backslash) što je u ovom 
primjeru mary0, 
• Nova lozinka se formira koristeći Rowguid zaposlenika na sljedeći način: Rowguid je 
potrebno okrenuti obrnuto (npr. dbms2015 -> 5102smbd) i nakon toga preskačemo 
prvih 5 i uzimamo narednih 7 karaktera. Sljedeći korak jeste da iz dobijenog stringa 
počevši od drugog karaktera naredna dva zamijenimo sa X# (npr. ako je dobiveni 
string dbms2015 izlaz će biti dX#s2015) 