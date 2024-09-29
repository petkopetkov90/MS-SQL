USE SoftUni

--1 
SELECT TOP 5
	EmployeeID,
	JobTitle,
	e.AddressID,
	AddressText
FROM Employees AS e JOIN Addresses AS a ON a.AddressID = e.AddressID
ORDER BY e.AddressID

--2
SELECT TOP 50
	FirstName,
	LastName,
	t."Name",
	AddressText
FROM Employees AS e JOIN Addresses AS a ON a.AddressID = e.AddressID JOIN Towns as t ON t.TownID = a.TownID
ORDER BY FirstName, LastName

--3
SELECT 
	EmployeeID,
	FirstName,
	LastName,
	d."Name"
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID WHERE d."Name" = 'Sales'
ORDER BY EmployeeID

--4
SELECT TOP 5
	EmployeeID,
	FirstName,
	Salary,
	d."Name"
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID 
WHERE e.Salary > 15000
ORDER BY e.DepartmentID

--5
SELECT TOP 3
	e.EmployeeID,
	e.FirstName
FROM Employees AS e 
LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
WHERE ep.EmployeeID IS NULL
ORDER BY e.EmployeeID

--6
SELECT 
	e.FirstName,
	e.LastName,
	e.HireDate,
	d."Name"
FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE e.HireDate > '1999-01-01' AND d."Name" IN ('Sales', 'Finance')
ORDER BY e.HireDate

--7
SELECT TOP 5
	e.EmployeeID,
	e.FirstName,
	p."Name"
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON p.ProjectID = ep.ProjectID WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--8
SELECT
	e.EmployeeID,
	FirstName,
	CASE
		WHEN YEAR(p.StartDate) >= 2005
		THEN NULL
		ELSE p."Name" 
	END AS "Name"
FROM Employees AS e
JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
JOIN Projects AS p ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24

--9
SELECT
	e.EmployeeID,
	e.FirstName,
	e.ManagerID,
	e2.FirstName
FROM Employees AS e JOIN Employees AS e2 ON e.ManagerID = e2.EmployeeID
WHERE e.ManagerID IN (3, 7)
ORDER BY e.EmployeeID

--10
SELECT TOP 50
	e.EmployeeID,
	CONCAT_WS(' ', e.FirstName, e.LastName) AS EmployeeName,
	CONCAT_WS(' ', e2.FirstName, e2.LastName) AS ManagerName,
	d."Name"
FROM Employees AS e
JOIN Employees AS e2 ON e.ManagerID = e2.EmployeeID
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
ORDER BY e.EmployeeID

--11
SELECT TOP 1
	AVG(e.Salary) AS AVGSalaries
FROM Employees AS e
GROUP BY e.DepartmentID
ORDER BY AVGSalaries


USE Geography
--12
SELECT
	mc.CountryCode,
	m.MountainRange,
	p.PeakName,
	p.Elevation
FROM Peaks AS p
JOIN Mountains AS m ON p.MountainId = m.Id
JOIN MountainsCountries AS mc ON mc.MountainId = m.Id WHERE mc.CountryCode = 'BG' AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--13
SELECT
	mc.CountryCode,
	COUNT(m.Id) AS MountainRange
FROM MountainsCountries AS mc
JOIN Mountains AS m ON m.Id = mc.MountainId 
WHERE mc.CountryCode IN ('BG', 'RU', 'US')
GROUP BY mc.CountryCode

--14
SELECT TOP 5
	c.CountryName,
	r.RiverName
FROM Countries AS c 
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName

--15
SELECT
	ContinentCode,
	CurrencyCode,
	CurrencyUsage
FROM (SELECT
	c.ContinentCode,
	c.CurrencyCode,
	COUNT(c.CurrencyCode) AS CurrencyUsage,
	DENSE_RANK() OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS "Rank"
FROM Countries AS c
GROUP BY c.ContinentCode, c.CurrencyCode) AS CurrencyRanked
WHERE "Rank" = 1 and CurrencyUsage > 1

--16
SELECT
	COUNT(c.ContinentCode)
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
WHERE mc.MountainId IS NULL

--17
SELECT TOP 5
	c.CountryName,
	MAX(p.Elevation) AS HighestPeakElevation,
	MAX(r."Length") AS LongestRiverLength
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
LEFT JOIN Peaks AS p ON p.MountainId = mc.MountainId
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC, C.CountryName

--18
SELECT TOP 5
	CountryName,
	"Highest Peak Name",
	"Highest Peak Elevation",
	"Mountain"
FROM (SELECT
	c.CountryName,
	CASE 
	   WHEN (p.PeakName) IS NULL 
	   THEN '(no highest peak)'
	   ELSE p.PeakName
	END AS 'Highest Peak Name',
	CASE 
	   WHEN (p.Elevation) IS NULL 
	   THEN 0
	   ELSE p.Elevation
	END AS 'Highest Peak Elevation',
	CASE 
	   WHEN (m.MountainRange) IS NULL 
	   THEN '(no mountain)'
	   ELSE m.MountainRange
	END AS 'Mountain',
	DENSE_RANK() OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS PeakRank
FROM Countries AS c
LEFT JOIN MountainsCountries AS mc ON mc.CountryCode = c.CountryCode
LEFT JOIN Mountains AS m ON m.Id = mc.MountainId
LEFT JOIN Peaks AS p ON p.MountainId = m.Id) AS CountryPeakMountain
WHERE PeakRank = 1
ORDER BY CountryName
