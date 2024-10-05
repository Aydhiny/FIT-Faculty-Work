/* Zadatak .1 */

USE pubs
SELECT E.fname + ' ' + E.lname as ImePrezime,
YEAR(GETDATE()) - YEAR(E.hire_date) as GodineStaza, 
J.job_desc, COUNT(*) as 'Broj naslova'
FROM dbo.employee as E
INNER JOIN dbo.jobs as J ON E.job_id = J.job_id
INNER JOIN publishers as P ON E.pub_id = P.pub_id
INNER JOIN titles as T ON P.pub_id = T.pub_id
WHERE(YEAR(GETDATE()) - YEAR(E.hire_date)) > 31
GROUP BY E.fname, E.lname,
YEAR(GETDATE()) - YEAR(E.hire_date), 
J.job_desc
HAVING COUNT(*) >
(
	SELECT COUNT(*)
	FROM dbo.titles as T
	WHERE T.pub_id LIKE 0736
)
ORDER BY 2 ASC, 4 DESC

SELECT CONCAT(E.fname, ' ', E.lname) 
'Ime i prezime', 
DATEDIFF(YEAR, E.hire_date, GETDATE()) 
'Staž', J.job_desc 'Opis posla', COUNT(*) 
'Broj naslova'
FROM employee AS E
INNER JOIN jobs AS J ON E.job_id=J.job_id
INNER JOIN publishers AS P ON E.pub_id=P.pub_id
INNER JOIN titles AS T ON P.pub_id=T.pub_id
WHERE DATEDIFF(YEAR, E.hire_date, GETDATE())>31 
GROUP BY CONCAT(E.fname, ' ', E.lname), 
DATEDIFF(YEAR, E.hire_date, GETDATE()), J.job_desc
HAVING COUNT(*)>
(
	SELECT COUNT(*)
	FROM titles AS T
	WHERE T.pub_id=0736
)
ORDER BY 2, 4 DESC