CREATE DATABASE CoffeeShop
GO
USE CoffeeShop
GO
CREATE TABLE Customer (
	CustomerID CHAR(5) NOT NULL PRIMARY KEY,
	CustomerName VARCHAR(30),
	CustomerGender VARCHAR(8),
	CustomerAddress VARCHAR(50),
	CustomerPhone VARCHAR(20),
	CustomerDOB DATE
)
GO
CREATE TABLE Coffee (
	CoffeeID CHAR(5) NOT NULL PRIMARY KEY,
	CoffeeName VARCHAR(30),
	CoffeeBean VARCHAR(30),
	CoffeePrice INT,
	ExtraTopping VARCHAR(30)
)
GO
CREATE TABLE HeaderTransaction (
	TransactionID CHAR(5) NOT NULL PRIMARY KEY,
	CustomerID CHAR(5) REFERENCES Customer(CustomerID) ON UPDATE CASCADE ON DELETE CASCADE,
	TransactionDate DATE
)
GO
CREATE TABLE DetailTransaction (
	TransactionID CHAR(5) REFERENCES HeaderTransaction(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE,
	CoffeeID CHAR(5) REFERENCES Coffee(CoffeeID) ON UPDATE CASCADE ON DELETE CASCADE,
	Quantity INT,
	PRIMARY KEY(TransactionID, CoffeeID)
)
GO
INSERT INTO Customer
VALUES 
	('CS001', 'Saviordo Then', 'Male', 'Anggrek Besar Street', '082149488159', '1998-09-02'),
	('CS002', 'Leonardo Kurwan', 'Male', 'Syahdan Street', '086888204012', '1998-06-06'),
	('CS003', 'Gabrielnyan', 'Female', 'Mangga Lily Street', '087889678332', '2000-04-10'),
	('CS004', 'Eric Van Panda', 'Male', 'Kijang King Street', '086688295871', '1997-03-12'),
	('CS005', 'Natasia Yun', 'Female', 'Anggrek Besar Street', '083326598210', '1998-07-02'),
	('CS006', 'Stephen Draiga ', 'Male', 'La Tale Street', '0878868222441', '1998-01-01')
GO
INSERT INTO Coffee
VALUES
	('CF001', 'Latte', 'Arabica', 32000, 'Caramel'),
	('CF002', 'Cappucino', 'Robusta', 30000, 'Chocolate'),
	('CF003', 'Au-Lait', 'Arabica', 28000, 'Milk'),
	('CF004', 'Americano', 'Robusta', 26000, 'Milk'),
	('CF005', 'Frappucino', 'Robusta', 35000, 'Caramel'),
	('CF006', 'Mocha', 'Liberica', 25000, 'Milk')
GO
INSERT INTO HeaderTransaction
VALUES
	('TR001', 'CS002', '2017-08-14'),
	('TR002', 'CS005', '2017-08-14'),
	('TR003', 'CS006', '2017-08-24'),
	('TR004', 'CS002', '2017-08-24'),
	('TR005', 'CS001', '2017-09-11'),
	('TR006', 'CS003', '2017-09-11'),
	('TR007', 'CS005', '2017-09-11'),
	('TR008', 'CS004', '2017-10-21'),
	('TR009', 'CS003', '2017-10-21'),
	('TR010', 'CS003', '2017-10-21')
GO
INSERT INTO DetailTransaction
VALUES 
	('TR001', 'CF002', 2),
	('TR001', 'CF003', 2),
	('TR002', 'CF005', 3),
	('TR002', 'CF003', 4),
	('TR003', 'CF006', 5),
	('TR004', 'CF006', 4),
	('TR004', 'CF003', 2),
	('TR004', 'CF002', 2),
	('TR005', 'CF004', 3),
	('TR006', 'CF004', 2),
	('TR007', 'CF004', 4),
	('TR007', 'CF006', 3),
	('TR008', 'CF001', 4),
	('TR009', 'CF001', 5),
	('TR010', 'CF002', 6),
	('TR010', 'CF001', 6)