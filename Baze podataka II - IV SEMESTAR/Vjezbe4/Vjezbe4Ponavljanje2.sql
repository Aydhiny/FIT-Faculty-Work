

/*Iz tabele HumanResources.Employee baze 
AdventureWorks2017 iz kolone LoginID izvući 
ime uposlenika.  */

/*
LEFT and RIGHT
Extract the first 4 characters from the string 'Database Management'.
Extract the last 5 characters from the string 'Database Management'.

CHARINDEX
Find the position of the first occurrence of the letter 'a' in the string 'Advanced SQL Querying'.
Find the position of the word 'SQL' in the string 'Learning SQL with Advanced Topics'.

PATINDEX
Find the position of the first digit in the string 'Data2024'.
Find the position of the first occurrence of any uppercase letter in the string 'sqlQueries'.

SUBSTRING
Extract a substring starting from the 5th character and of length 7 from the string 'Comprehensive SQL Tutorial'.
Extract a substring starting from the 2nd character and of length 10 from the string 'Master SQL Functions'.

UPPER and LOWER
Convert the string 'SQL Fundamentals' to uppercase.
Convert the string 'ADVANCED SQL' to lowercase.

LEN
Determine the length of the string 'String Length Calculation'.
Determine the length of the string 'Function Testing'.

REPLACE
Replace all occurrences of 'i' with 'X' in the string 'SQL Injection'.
Replace 'Database' with 'DB' in the string 'Database Management System'.

STUFF
Replace 3 characters starting from the 6th position in the string 'Introduction to SQL' with 'FUN'.
Replace 4 characters starting from the 5th position in the string 'Programming Basics' with 'ADV'.

STR
Convert the number 4567 to a string.
Convert the number 123 to a string with a width of 5.

REVERSE
Reverse the string 'SQL Query'.
Reverse the string 'Data Analysis'.

*/

SELECT E.LoginID, SUBSTRING(E.LoginID, CHARINDEX(E.LoginID, '\',1), LEN(E.LoginID))
FROM AdventureWorks2017.HumanResources.Employee as E

/*
LEFT and RIGHT
Extract the first 4 characters from the string 'Database Management'.
Extract the last 5 characters from the string 'Database Management'. */

SELECT LEFT('Database Management', 4)
SELECT RIGHT('Database Management', 5)

/* 
CHARINDEX
Find the position of the first occurrence of the letter 'a' in the string 'Advanced SQL Querying'.
Find the position of the word 'SQL' in the string 'Learning SQL with Advanced Topics'.
*/
SELECT CHARINDEX('a', 'Advanced SQL Querying', 0)
SELECT CHARINDEX('SQL', 'Learning SQL with Advanced Topics', 0)

/* PATINDEX
Find the position of the first digit in the string 'Data2024'.
Find the position of the first occurrence of any uppercase letter in the string 'sqlQueries'. */

SELECT PATINDEX('%[0-9]%', 'Data2024')
SELECT PATINDEX('%[A-Z]%', 'sqlqueries')

/* SUBSTRING
Extract a substring starting from the 5th character and of length 7 from the string 'Comprehensive SQL Tutorial'.
Extract a substring starting from the 2nd character and of length 10 from the string 'Master SQL Functions'. */

SELECT SUBSTRING('Comprehensive SQL Tutorial', 5, 7)
SELECT SUBSTRING('Master SQL Functions', 2, 10)

/* REPLACE
Replace all occurrences of 'i' with 'X' in the string 'SQL Injection'.
Replace 'Database' with 'DB' in the string 'Database Management System'. */

SELECT REPLACE('SQL Injection', 'i', 'X')
SELECT REPLACE('Database Management System', 'Database', 'DB')

/* STUFF
Replace 3 characters starting from the 6th position in the string 'Introduction to SQL' with 'FUN'.
Replace 4 characters starting from the 5th position in the string 'Programming Basics' with 'ADV'. */

SELECT STUFF('Introduction to SQL', 6, 3, 'FUN')
SELECT STUFF('Programming Basics', 5, 4, 'ADV')

/*
Extract the first 5 characters from the string 'Database Management'.
Convert the result to uppercase.
Replace all instances of the letter 'A' with the substring 'XY'.
*/

SELECT REPLACE(UPPER(LEFT('Database Management', 5)), 'A', 'XY')

/*
Take the string 'Frontend Developer' and reverse it.
Extract the substring starting at the 4th character and ending at the 8th character.
Find the length of the resulting string.
*/
SELECT LEN(SUBSTRING(REVERSE('Frontend Developer'), 4, 8))

/*
Find the position of the first occurrence of the letter 'i' in the string 'Coding in SQL is fun'.
Replace the first 4 characters of this string with 'DBMS'.
Convert the final string to lowercase.
*/
SELECT CHARINDEX('i', 'Coding in SQL is fun', 1)
SELECT REPLACE('Coding in SQL is fun', LEFT('Coding in SQL is fun', 4), 'DBMS')

/* Take the string 'Learning SQL Functions'.
Extract the substring from the 10th position, and replace all spaces with underscores ('_').
Find the length of the modified string and convert it to uppercase.
*/
SELECT UPPER(REPLACE(SUBSTRING('Learning SQL Functions', 10, LEN('Learning SQL Functions') - 9), ' ', '_'))

/* From the string 'Advanced SQL Query', extract the word 'SQL'.
Find the position of the word 'Query' in the original string.
Replace the extracted 'SQL' with 'Database' and reverse the final result. */
SELECT REVERSE(REPLACE(SUBSTRING('Advanced SQL Query' ,CHARINDEX('SQL', 'Advanced SQL Query', 1), LEN('SQL')), 'SQL', 'Database'))
SELECT CHARINDEX('Query', 'Advanced SQL Query')

/* Take the string 'System Design in SQL'.
Convert all the characters to uppercase.
Replace all spaces with dashes ('-'), and then extract the first 10 characters of the final result. */

SELECT LEFT(REPLACE(UPPER('System Design in SQL'), ' ', '-'), 10)
/* From the string 'Structured Query Language', extract the first word.
Replace all occurrences of 'u' with 'OO'.
Find the position of the first uppercase letter in the original string.
*/

SELECT REPLACE(LEFT('Structured Query Language', CHARINDEX(' ','Structured Query Language', 1)), 'u', '00')
SELECT PATINDEX('%[A-Z]%', 'Structured Query Language')

/* Use the string '2024 SQL Training'.
Replace the number '2024' with '2025'.
Extract the last 6 characters and reverse them.
Convert the entire string to lowercase. */

SELECT LOWER(REVERSE(RIGHT(REPLACE('2024 SQL Training', '2024', '2025'), 6)))

/* For the string 'Building Backend with SQL', find the position of the letter 'e'.
Extract the substring from the 9th character to the end.
Replace the first occurrence of 'SQL' with 'Databases' and convert the result to uppercase. */

SELECT CHARINDEX('e', 'Building Backend with SQL')
SELECT SUBSTRING('Building Backend with SQL', 9, LEN('Building Backend with SQL') - 8)

/* From the string 'Professional SQL Developer', extract the word 'SQL'.
Replace the first occurrence of 'e' with '3'.
Find the length of the new string and reverse it. */

SELECT REVERSE(LEN(REPLACE(SUBSTRING('Professional SQL Developer', CHARINDEX('SQL', 'Professional SQL Developer'),LEN('SQL')), 'S', '3')))

/* VJEŽBA 4 */
/* ZADATAK .1 */
SELECT E.LoginID, SUBSTRING(E.LoginID, CHARINDEX('\', E.LoginID) + 1, LEN(E.loginID) - CHARINDEX('\', E.LoginID) - 1)
FROM AdventureWorks2017.HumanResources.Employee as E

SELECT E.LoginID, SUBSTRING(E.LoginID, 
CHARINDEX('\', E.LoginID) + 1, LEN(E.loginID) - 
CHARINDEX('\', E.LoginID)) as Ime, STUFF(SUBSTRING(REVERSE(E.rowguid), 6, 8), 2, 2, 'X#') as Lozinka
FROM AdventureWorks2017.HumanResources.Employee as E

SELECT *, REPLACE(C.AccountNumber, '0', '') as BROJ
FROM AdventureWorks2017.Sales.Customer as C
WHERE C.PersonID IS NOT NULL

SELECT *, IIF(LEFT(V.AccountNumber,PATINDEX('%[0-9]%', 
V.AccountNumber) - 1) = LEFT(V.[Name], CHARINDEX(' ', V.[Name])), 'ISTO', 'Nije ISTO') as Provjera, LEFT(V.AccountNumber,PATINDEX('%[0-9]%', 
V.AccountNumber) - 1) as AccountIme, LEFT(V.[Name], CHARINDEX(' ', V.[Name])) as Ime2
FROM AdventureWorks2017.Purchasing.Vendor as V

SELECT LEFT(C.ContactName, CHARINDEX(' ', C.ContactName)) as 'Name',
RIGHT(C.ContactName, LEN(C.ContactName) - 
CHARINDEX(' ', C.ContactName)) as Surname, C.CompanyName, C.Country, C.City, 
RIGHT(C.[Address], CHARINDEX(' ', REVERSE(C.[Address])) - 1) as Adresa
FROM Northwind.dbo.Customers as C
WHERE LEN(CHARINDEX(' ', REVERSE(C.[Address])) - 1) BETWEEN 2 AND 3

SELECT *, IIF(RIGHT(LEFT(C.ContactName, CHARINDEX(' ', C.ContactName) - 1), 1) = 'a','F','M') as Spol
FROM Northwind.dbo.Customers as C