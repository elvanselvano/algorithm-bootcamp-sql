USE OOVEO_Salon
GO

--1
CREATE OR ALTER VIEW ViewBonus
AS
SELECT STUFF(CustomerId, 1, 2, 'BN') as [BinusId], CustomerName
FROM MsCustomer
WHERE LEN(CustomerName) > 10
GO

--2
-- agus budiman
CREATE VIEW ViewCustomerData
AS
SELECT SUBSTRING(CustomerName, 1, CHARINDEX(' ', Customername) - 1) as [Name],
	CustomerAddress as [Address], CustomerPhone as [Phone]
FROM MsCustomer
WHERE CustomerName like '% %'
GO
--3
CREATE VIEW ViewTreatment
AS
SELECT t.TreatmentName, tt.TreatmentTypeName,
	'Rp. ' + CAST(t.Price as VARCHAR) as [Price]
FROM MsTreatment as t
JOIN MsTreatmentType as tt on t.TreatmentTypeId = tt.TreatmentTypeId
WHERE tt.TreatmentTypeName = 'Hair Treatment' AND t.Price BETWEEN 450000 AND 800000
GO

--4
CREATE VIEW ViewTransaction
AS
SELECT s.StaffName, c.CustomerName, 
CONVERT(VARCHAR, hss.TransactionDate, 106) as [TransactionDate], hss.PaymentType
FROM HeaderSalonServices as hss
JOIN MsCustomer as c on hss.CustomerId = c.CustomerId
JOIN MsStaff as s on hss.StaffId = s.StaffId
WHERE hss.PaymentType = 'Credit' AND DAY(hss.TransactionDate) BETWEEN 21 AND 25
GO
--5
-- agus budiman
-- namidub suga
-- namidub
-- Budiman
-- budiman
CREATE VIEW ViewBonusCustomer
AS
SELECT REPLACE(c.CustomerId, 'CU', 'BN') as [BonusId],
	LOWER(REVERSE(SUBSTRING(
		REVERSE(c.CustomerName), 1, CHARINDEX(' ', REVERSE(c.CustomerName)) - 1))) as [Name],
	DATENAME(WEEKDAY, hss.TransactionDate) as [Day],
	CONVERT(VARCHAR, hss.TransactionDate, 101) as [TransactionDate]
FROM MsCustomer as c
JOIN HeaderSalonServices as hss on c.CustomerId = hss.CustomerId
WHERE CustomerName like '% %a%' 
GO

--6
SELECT hss.TransactionId, CONVERT(VARCHAR, hss.TransactionDate, 107) as [Date],
	t.TreatmentName
FROM MsStaff as s
JOIN HeaderSalonServices as hss on s.StaffId = hss.StaffId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as t on dss.TreatmentId = t.TreatmentId
WHERE DAY(hss.TransactionDate) = 21 AND s.StaffName like 'Livia Ashianti'
GO
--7
--8
CREATE VIEW ViewCustomer
AS
SELECT CustomerId, CustomerName, CustomerGender
FROM MsCustomer
GO

BEGIN TRAN
GO
INSERT INTO ViewCustomer
VALUES ('CU006', 'Christian', 'Male')
GO
SELECT *
FROM MsCustomer
GO
ROLLBACK
Go
--9
--10
DROP VIEW ViewCustomerData

-- contoh delete dari view
BEGIN TRAN
GO
DELETE FROM ViewCustomer
WHERE CustomerId = 'CU005'
GO
SELECT *
FROM MsCustomer
GO
ROLLBACK
Go

-- CURSOR: digunakan untuk meloop dari row paling atas ke bawah
-- Query ini digunakan untuk menggunakan cursor
DECLARE 
	@name varchar(max),
	@phone varchar(20)

DECLARE customerCursor CURSOR
FOR
SELECT CustomerName, CustomerPhone
FROM MsCustomer

OPEN customerCursor

FETCH NEXT FROM customerCursor INTO
@name, @phone

WHILE @@FETCH_STATUS = 0
	BEGIN
		PRINT @name + ' ' + @phone

		FETCH NEXT FROM customerCursor INTO
		@name, @phone
	END

CLOSE customerCursor
DEALLOCATE customerCursor
GO


-- PROCEDURE: merupakan statement yang disimpan agar bisa digunakan berkali-kali
-- Procedure di bawah menunjukkan transaksi dengan jumlah treatment yang ditentukan
CREATE PROCEDURE GetTransactionByTotal(
	@total int
)
AS
SELECT hss.TransactionId, COUNT(*) as [total treatment]
FROM HeaderSalonServices as hss
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
GROUP BY hss.TransactionId
HAVING COUNT(*) = @total
GO

EXEC GetTransactionByTotal 4

GO

-- TRIGGER: trigger adalah sebuah stored procedure yang secara otomatis bekerja jika ada suatu event
-- trigger di bawah mengoutputkan semua, trigger di bawah menggantikan operasi delete
CREATE TRIGGER InsteadOfDeleteCustomer
ON MsCustomer
INSTEAD OF DELETE
AS
	SELECT *
	FROM MsCustomer
GO


-- trigger ini mengoutputkan semua setelah ada operasi insert
CREATE TRIGGER AfterCustomerInsert
ON MsCustomer
AFTER INSERT
AS
	SELECT *
	FROM MsCustomer
GO

DELETE FROM MsCustomer
WHERE CustomerGender = 'Male'

INSERT INTO MsCustomer
VALUES ('CU006', 'Test', 'Male', '08566543338', 'Daan mogot baru Street no 6')

GO


-- Function: potongan code yang bisa digunakan berkali-kali
-- Function di bawah menambahkan '....' kepada sebuah kalimat yang dimasukkan
CREATE FUNCTION testFunction(@string VARCHAR(max))
RETURNS VARCHAR(max)
AS
	BEGIN
	RETURN @string + '....'
	END
GO

-- pada saat mau menggunakan Function yang kita buat kita harus menggunakan 'dbo.', 
-- contoh: dbo.functionName
SELECT dbo.testFunction(CustomerName)
FROM MsCustomer