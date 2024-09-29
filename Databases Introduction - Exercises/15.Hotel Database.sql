CREATE DATABASE Hotel
USE Hotel

CREATE TABLE Employees
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Title VARCHAR(100) NOT NULL,
	Notes VARCHAR(2000),
)

INSERT INTO Employees (FirstName, LastName, Title) VALUES
('FirstEmployee', '1LastName', 'worker1'),
('SecondEmployee', '2LastName', 'worker2'),
('LastEmployee', '3LastName', 'worker3')

CREATE TABLE Customers
(
	Id INT PRIMARY KEY IDENTITY,
	AccountNumber VARCHAR(200) NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	PhoneNumber VARCHAR(50),
	EmergencyName VARCHAR(200),
	Notes VARCHAR(2000)
)

INSERT INTO Customers (AccountNumber, FirstName, LastName) VALUES
('FirstAccount125091', 'FirstCustomer', 'HisLastName1'),
('SecondtAccount125091', 'SecondCustomer', 'HisLastName2'),
('LastAccount125091', 'ThirdCustomer', 'HisLastName3')

CREATE TABLE RoomStatus
(
	Id INT PRIMARY KEY IDENTITY,
	RoomStatus VARCHAR(50) NOT NULL,
	Notes VARCHAR(2000)
)

INSERT INTO RoomStatus (RoomStatus) VALUES
('Available'),
('Not Available'),
('Not Cleaned')

CREATE TABLE RoomTypes
(
	Id INT PRIMARY KEY IDENTITY,
	RoomType VARCHAR(50) NOT NULL,
	Notes VARCHAR(2000)
)

INSERT INTO RoomTypes (RoomType) VALUES
('Single Room'),
('Double Room'),
('Familly Room')

CREATE TABLE BedTypes
(
	Id INT PRIMARY KEY IDENTITY,
	BedType VARCHAR(50) NOT NULL,
	Notes VARCHAR(2000)
)

INSERT INTO BedTypes (BedType) VALUES
('Single beds'),
('Single bed and double bed'),
('Double bed')

CREATE TABLE Rooms
(
	Id INT PRIMARY KEY IDENTITY,
	RoomNumber INT NOT NULL,
	RoomType INT NOT NULL FOREIGN KEY REFERENCES RoomTypes(Id),
	BedType INT NOT NULL FOREIGN KEY REFERENCES BedTypes(Id),
	Rate MONEY NOT NULL,
	RoomStatus INT NOT NULL FOREIGN KEY REFERENCES RoomStatus(Id),
	Notes VARCHAR(2000)
)

INSERT INTO Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus) VALUES
(1,1,1,100.00,1),
(2,1,3,250,2),
(3,2,2,55.30,3)

CREATE TABLE Payments
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber VARCHAR(200),
	FirstDateOccupied DATETIME2,
	LastDateOccupied DATETIME2,
	TotalDays INT NOT NULL,
	AmountCharged MONEY NOT NULL,
	TaxRate DECIMAL(5,2),
	TaxAmount MONEY,
	PaymentTotal MONEY NOT NULL,
	Notes VARCHAR(2000)
)

INSERT INTO Payments (EmployeeID, PaymentDate, TotalDays, AmountCharged, PaymentTotal) VALUES
(1,'1990-05-10', 10, 768.50, 810.15),
(2,'1954-05-10', 12, 1168.50, 1310),
(3,'2000-05-10', 3, 268.50, 310.5)

CREATE TABLE Occupancies
(
	Id INT PRIMARY KEY IDENTITY,
	EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employees(Id),
	DateOccupied DATETIME2,
	AccountNumber VARCHAR(200),
	RoomNumber INT NOT NULL,
	RateApllied MONEY NOT NULL,
	PhoneCharge MONEY,
	Notes VARCHAR(2000)
)

INSERT INTO Occupancies (EmployeeID, RoomNumber, RateApllied) VALUES
(1,1,200.50),
(2,3,22.5),
(3,2,333)
