--1
SELECT
	FirstName,
	LastName
FROM Employees
WHERE SUBSTRING(FirstName, 1, 2) = 'Sa'

--2
SELECT
	FirstName,
	LastName
FROM Employees
WHERE LastName LIKE '%ei%'

--3
SELECT
	FirstName
FROM Employees AS e
WHERE e.DepartmentID IN (3, 10) AND YEAR(e.HireDate) BETWEEN 1995 AND 2005

--4
SELECT
	FirstName,
	LastName
FROM Employees
WHERE JobTitle NOT LIKE '%engineer%'

--5
SELECT
	"Name"
FROM Towns
WHERE LEN("Name") IN (5, 6)
ORDER BY "Name"

--6
SELECT
	TownID,
	"Name"
FROM Towns
WHERE "Name" LIKE '[MKBE]%'
ORDER BY "Name"

--7
SELECT
	TownID,
	"Name"
FROM Towns
WHERE SUBSTRING("Name", 1, 1) NOT IN ('R', 'B', 'D')
ORDER BY "Name"

--8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT 
	FirstName,
	LastName
FROM Employees
WHERE YEAR(HireDate) > 2000

--9
SELECT
	FirstName,
	LastName
FROM Employees
WHERE LEN(LastName) = 5

--10
SELECT
	EmployeeID,
	FirstName,
	LastName,
	Salary,
	DENSE_RANK() OVER (PARTITION BY e.Salary ORDER BY e.EmployeeID) AS Rank
FROM Employees AS e 
WHERE e.Salary BETWEEN 10000 AND 50000
ORDER BY e.Salary DESC

--11
WITH Ranked AS
(SELECT
	EmployeeID,
	FirstName,
	LastName,
	Salary,
	DENSE_RANK() OVER (PARTITION BY e.Salary ORDER BY e.EmployeeID) AS Rank
FROM Employees AS e 
WHERE e.Salary BETWEEN 10000 AND 50000
)

SELECT
	*
FROM Ranked
WHERE "Rank" = 2
ORDER BY Salary DESC


USE Geography
--12
SELECT
	c.CountryName,
	c.IsoCode
FROM Countries AS c
WHERE c.CountryName LIKE '%A%A%A%'
ORDER BY c.IsoCode

--13
SELECT
	p.PeakName,
	r.RiverName,
	LOWER(CONCAT( p.PeakName, SUBSTRING(r.RiverName, 2, LEN(r.RiverName)))) AS Mix
FROM Peaks AS p, Rivers AS r
WHERE SUBSTRING(p.PeakName, LEN(p.PeakName), 1) = SUBSTRING(r.RiverName, 1, 1)
ORDER BY Mix


USE Diablo
--14
SELECT TOP 50
	"Name",
	FORMAT("Start", 'yyyy-MM-dd') AS "Start"
FROM Games
WHERE YEAR("Start") IN (2011, 2012)
ORDER BY "Start", "Name"

--15
SELECT
	Username,
	SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email)) AS 'Email Provider'
FROM Users
ORDER BY 'Email Provider', Username

--16
SELECT
	Username,
	IpAddress
FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username

--17
SELECT
	"Name",
	(CASE
		WHEN DATEPART(HOUR, Start) < 12 THEN 'Morning'
		WHEN DATEPART(HOUR, Start) < 18 THEN 'Afternoon '
		ELSE 'Evening'
	END) AS 'Part of the Day',
	(CASE
		WHEN Duration IS NULL THEN 'Extra Long'
		WHEN Duration < 4 THEN 'Extra Short'
		WHEN Duration < 7 THEN 'Short '
		ELSE 'Long'
	END) AS 'Duration'
FROM Games
ORDER BY "Name", Duration


USE Orders
--18
SELECT
	ProductName,
	OrderDate,
	DATEADD(DAY, 3, OrderDate) AS 'Pay Due',
	DATEADD(MONTH, 1, OrderDate) AS 'Deliver Due'
FROM Orders

--19
CREATE TABLE People
(
	Id INT PRIMARY KEY IDENTITY,
	"Name" VARCHAR(50) NOT NULL,
	Birthdate DATETIME2
)

INSERT INTO People
VALUES ('Victor', '2000-12-07 00:00:00.000'),
('Steven', '1992-09-10 00:00:00.000'),
('Stephen', '1910-09-19 00:00:00.000'),
('John', '2010-01-06 00:00:00.000')

SELECT
	"Name",
	DATEDIFF(YEAR, Birthdate, GETDATE()) AS 'Age in Years',
	DATEDIFF(MONTH, Birthdate, GETDATE()) AS 'Age in Months	',
	DATEDIFF(DAY, Birthdate, GETDATE()) AS 'Age in Days',
	DATEDIFF(MINUTE, Birthdate, GETDATE()) AS 'Age in Minutes'
FROM People