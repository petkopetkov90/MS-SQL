USE Gringotts
--1
SELECT 
	COUNT(*)
FROM WizzardDeposits

--2
SELECT
	MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits

--3
SELECT
	DepositGroup,
	MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

--4
SELECT TOP 2
	DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

--5
SELECT
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

--6
SELECT
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--7
SELECT
	DepositGroup,
	SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

--8
SELECT
	DepositGroup,
	MagicWandCreator,
	MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--9
SELECT
	AgeGroup,
	SUM(WizardCount) AS WizardCount
FROM (SELECT
	CASE
	WHEN Age < 11 THEN '[0-10]'
	WHEN Age < 21 THEN '[11-20]'
	WHEN Age < 31 THEN '[21-30]'
	WHEN Age < 41 THEN '[31-40]'
	WHEN Age < 51 THEN '[41-50]'
	WHEN Age < 61 THEN '[51-60]'
	ELSE '[61+]'
	END AS AgeGroup,
	Count(Id) AS WizardCount
FROM WizzardDeposits
GROUP BY Age) AS AgesGrouped
GROUP BY AgeGroup

--10
SELECT
	SUBSTRING(FirstName, 1, 1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY SUBSTRING(FirstName, 1, 1)
ORDER BY FirstLetter

--11
SELECT
	DepositGroup,
	IsDepositExpired,
	AVG(DepositInterest) AS AverageInterest
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC

--12
SELECT
	SUM("Difference") AS SumDifference
FROM (SELECT 
	DepositAmount - LEAD(DepositAmount) OVER (ORDER BY Id) AS "Difference"
FROM WizzardDeposits) AS Differences


USE SoftUni
--13
SELECT
	DepartmentID,
	SUM(Salary) AS TotalSalary
FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--14
SELECT
	DepartmentID,
	MIN(Salary) AS MinimumSalary
FROM Employees
WHERE HireDate > '2000-01-01'
GROUP BY DepartmentID
HAVING DepartmentID IN (2, 5, 7)

--15
SELECT
	*
INTO NewEmployees
FROM Employees
WHERE Salary > 30000

DELETE
FROM NewEmployees
WHERE ManagerID = 42

UPDATE NewEmployees
SET Salary += 5000
WHERE DepartmentID = 1

SELECT
	DepartmentID,
	AVG(Salary)
FROM NewEmployees
GROUP BY DepartmentID

--16
SELECT
	DepartmentID,
	MAX(Salary) AS MaxSalary
FROM Employees
GROUP BY DepartmentID
HAVING MAX(SALARY) NOT BETWEEN 30000 AND 70000

--17
SELECT
	COUNT(Salary)
FROM Employees
WHERE ManagerID IS NULL

--18
SELECT 
	DepartmentID,
	ThirdHighestSalary
FROM 
	(SELECT
		DepartmentID,
		Salary AS ThirdHighestSalary,
		DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS RankedSalary
	FROM Employees
	GROUP BY DepartmentID, Salary)  AS Grouped
WHERE RankedSalary = 3

--19
SELECT TOP 10
	FirstName,
	LastName,
	e.DepartmentID
FROM Employees AS e
LEFT JOIN 
	(SELECT	
		DepartmentID,
		AVG(Salary) AS AVGSalary
	FROM Employees
	GROUP BY DepartmentID) AS t ON e.DepartmentID = t.DepartmentID
WHERE e.Salary > t.AVGSalary
ORDER BY e.DepartmentID

