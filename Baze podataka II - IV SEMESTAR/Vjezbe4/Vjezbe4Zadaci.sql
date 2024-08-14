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
b) dohvatiti one zapise kojima je unijet podatak u kolonu PersonID*//* Assignment 1: Extract the first 4 characters from a string of your choice.

Assignment 2: Extract the first N characters from a column value where N is provided as a parameter. */

SELECT LEFT('Aydhiny Beats', 6)

/*  Combine LEFT and UPPER:

Extract the first 7 characters from the string 'sql performance tuning' and convert them to uppercase. */

SELECT UPPER(LEFT('sql performance tuning', 7))

/* Combine CHARINDEX and SUBSTRING:

Find the position of the first space in the string 'Database Management System' and extract the substring starting from the position after the space. */
SELECT SUBSTRING('Database Management System', 
		CHARINDEX(' ', 'Database Management System')+1, 
		LEN('Database Management System') - 
		CHARINDEX(' ', 'Database Management System'))

/*  Combine PATINDEX and REPLACE:
Find the position of the first digit in the string 'Order Number: 12345' and replace the digit with 'X'. 
PATINDEX('%[0-9]%', 'Order Number: 12345')
*/ 

SELECT REPLACE('Order Number: 12345', 
		SUBSTRING('Order Number: 12345', 
		PATINDEX('%[0-9]%', 'Order Number: 12345'), 1), 'X')

/*  Combine UPPER, LEFT, and LEN:
Convert the first 6 characters of the string 'Data Analysis' to uppercase and display their length.
5. Combine */

SELECT LEN(UPPER(LEFT('Data Analysis', 6))) AS LengthOfUppercaseSubstring;

/*  Combine STUFF and LOWER:
Replace a portion of the string 'SQL Tutorial Guide' 
starting from position 5 with 'advanced guide' and convert the result to lowercase. */

SELECT LOWER(STUFF('SQL Tutorial Guide', 5, LEN('SQL Tutorial Guide'), 'advanced guide'))

/* Combine LEFT, RIGHT, and UPPER
Task: Extract the first 4 characters of the string 'Welcome to SQL World', convert them to uppercase, and then 
append the last 5 characters of the string 'Welcome to SQL World'.
*/

SELECT UPPER(LEFT('Welcome to SQL World', 4)) + RIGHT('Welcome to SQL World', 5) AS Result

/* 2. Combine CHARINDEX, SUBSTRING, and REPLACE
Task: Find the position of the first space in the string 'Find and Replace', 
extract the substring from the beginning up to that space, and replace the extracted substring with 'Search'. */

SELECT REPLACE('Find and Replace', 
		SUBSTRING('Find and Replace', 1, 
		CHARINDEX(' ','Find and Replace') - 1), 'Search') 

/* Combine PATINDEX, STUFF, and LEN
Task: Find the position of the first occurrence of the pattern  
'Report' in 'Annual Sales Report 2024', replace it with 'Summary', 
and then append the length of the original string. */

SELECT STUFF('Annual Sales Report 2024', PATINDEX('%Report%', 'Annual Sales Report 2024'), LEN('Report'), 'Summary')

/* Combine LOWER, RIGHT, and CHARINDEX
Task: Extract the substring from the position of the last space in 
'Project Proposal Document' to the end of the string, convert it to 
lowercase, and prepend 'Final '.
*/
SELECT 'Final ' + LOWER(RIGHT('Project Proposal Document', 
CHARINDEX(' ', REVERSE('Project Proposal Document'))))

/* Combine STUFF, RIGHT, and LEN
Task: Replace the substring from the 6th position to the end of 
'The quick brown fox jumps over the lazy dog' with 'red fox',
and then display the length of the resulting string. */
SELECT LEN(
    STUFF(
    'The quick brown fox jumps over the lazy dog',
    6,
        LEN('The quick brown fox jumps over the lazy dog') - LEN(RIGHT('The quick brown fox jumps over the lazy dog', LEN('The quick brown fox jumps over the lazy dog') - 5)),
        'red fox')) AS Result;