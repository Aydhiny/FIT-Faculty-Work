

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