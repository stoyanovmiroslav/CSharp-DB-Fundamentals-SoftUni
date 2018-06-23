CREATE TABLE Clients(
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
LastName NVARCHAR(30) NOT NULL,
Gender CHAR CHECK(Gender = 'M' OR Gender = 'F'),
BirthDate DATETIME2,
CreditCard NVARCHAR(30) NOT NULL,
CardValidity DATETIME2,
Email NVARCHAR(50) NOT NULL,
)

CREATE TABLE Towns(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(50) NOT NULL,
)

CREATE TABLE Offices(
Id INT PRIMARY KEY IDENTITY,
Name NVARCHAR(40) NOT NULL,
ParkingPlaces INT,
TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Models(
Id INT PRIMARY KEY IDENTITY,
Manufacturer NVARCHAR(50) NOT NULL,
Model NVARCHAR(50) NOT NULL,
ProductionYear DATETIME2,
Seats INT, 
Class NVARCHAR(10) NOT NULL,
Consumption DECIMAL(14, 2)
)

CREATE TABLE Vehicles(
Id INT PRIMARY KEY IDENTITY,
ModelId INT NOT NULL FOREIGN KEY REFERENCES Models(Id),
OfficeId INT NOT NULL FOREIGN KEY REFERENCES Offices(Id),
Mileage INT
)

CREATE TABLE Orders(
Id INT PRIMARY KEY IDENTITY,
ClientId INT FOREIGN KEY REFERENCES Clients(Id) NOT NULL,
TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL,
VehicleId INT FOREIGN KEY REFERENCES Vehicles(Id) NOT NULL,
CollectionDate DATETIME2 NOT NULL,
CollectionOfficeId INT FOREIGN KEY REFERENCES Offices(Id) NOT NULL,
ReturnDate DATETIME2,
ReturnOfficeId INT FOREIGN KEY REFERENCES Offices(Id),
Bill DECIMAL(14, 2),
TotalMileage INT
)