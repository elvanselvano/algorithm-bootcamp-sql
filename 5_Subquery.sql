USE OOVEO_Salon
 
SELECT *
FROM MsTreatmentType
WHERE TreatmentTypeId = 'TT002' OR TreatmentTypeId = 'TT003'


-- IN: digunakan untuk mencocokkan value dengan sebuah list atau subquery
-- menunjukkan treatment type dengan id 001 dan 002
SELECT *
FROM MsTreatmentType
WHERE TreatmentTypeId IN ('TT001', 'TT002')

-- EXISTS: digunakan untuk mengecek keberadaan
-- menunjukkan customer yang membayar dengan credit
SELECT *
FROM MsCustomer as c
WHERE EXISTS (
	SELECT *
	FROM HeaderSalonServices as hss
	WHERE c.CustomerId = hss.CustomerId AND PaymentType = 'Credit'
)

-- menunjukkan customer yang membayar dengan credit, menggunakan syntax IN
SELECT *
FROM MsCustomer as c
WHERE c.CustomerId in (
	SELECT hss.CustomerId
	FROM HeaderSalonServices as hss
	WHERE PaymentType = 'Credit'
)

SELECT *
FROM MsCustomer as c
WHERE c.CustomerId in ('CU001', 'CU002', 'CU001', 'CU003')


SELECT *
FROM MsCustomer as c
WHERE c.CustomerId not in (
	SELECT 'CU001', 'CU002'
)

--EXIST in c code
--FOR(int i = 0; i < 10; i++)
--	FOR(int j = 0; j < 5; j++)
--		IF(condition) break

-- 1
SELECT TreatmentId, TreatmentName
FROM MsTreatment
WHERE TreatmentId in ('TM001', 'TM002')

--3
SELECT c.CustomerName, c.CustomerPhone, c.CustomerAddress
FROM MsCustomer as c
WHERE LEN(CustomerName) > 8 and EXISTS (
	SELECT *
	FROM HeaderSalonServices as hss
	WHERE DATENAME(WEEKDAY, TransactionDate) = 'Friday' AND c.CustomerId = hss.CustomerId
)


-- ALL: melakukan comparison satu value ke value lainnya, true jika semua memenuhi
-- memunculkan staff dengan nama ter-rendah
SELECT *
FROM MsStaff
WHERE StaffName <= ALL (
	SELECT StaffName
	FROM MsStaff
)


-- ANY: melakukan comparison satu value ke value lainnya, true jika ada yang memenuhi
-- menunjukkan staff yang salary nya tidak ada dalam tabel
SELECT *
FROM MsStaff
WHERE not StaffSalary = ANY (
	SELECT StaffSalary
	FROM MsStaff
)
ORDER BY StaffPhone


-- melihat staff dengan salary max dan min
SELECT *
FROM MsStaff
WHERE StaffSalary <= ALL (
	SELECT StaffSalary
	FROM MsStaff
)
UNION
SELECT *
FROM MsStaff
WHERE StaffSalary >= ALL (
	SELECT StaffSalary
	FROM MsStaff
)


-- nested query 3 tingkat
SELECT *
FROM MsCustomer
WHERE EXISTS (
	SELECT *
	FROM MsStaff
	WHERE EXISTS (
		SELECT *
		FROM HeaderSalonServices
	)
)


-- melihat total perhitungan jumlah staff
SELECT SUM(tempStaff.staffCount)
FROM (
	SELECT COUNT(*) as staffCount
	FROM MsStaff
) as tempStaff


-- 8
SELECT tt.TreatmentTypeName, t.TreatmentName, t.Price
FROM MsTreatment as t
JOIN (
	SELECT AVG(Price) as average
	FROM MsTreatment
) as avgPrice on t.Price > avgPrice.average
JOIN MsTreatmentType as tt ON t.TreatmentTypeId = tt.TreatmentTypeId
-- 9
SELECT s.StaffName, s.StaffPosition, s.StaffSalary
FROM MsStaff as s
JOIN (
	SELECT MAX(StaffSalary) as [maxSalary],
		MIN(StaffSalary) as [minSalary]
	FROM MsStaff
) as salaries on s.StaffSalary = salaries.minSalary OR s.StaffSalary = salaries.maxSalary

-- 10
SELECT c.CustomerName, c.CustomerPhone, c.CustomerAddress, 
	treatmentCounts.treatmentCount as [Count Treatment]
FROM HeaderSalonServices as hss
JOIN (
	SELECT COUNT(TreatmentId) as [treatmentCount], TransactionId
	FROM DetailSalonServices as dss
	GROUP BY TransactionId
) as treatmentCounts on hss.TransactionId = treatmentCounts.TransactionId
JOIN MsCustomer as c on hss.CustomerId = c.CustomerId
WHERE treatmentCounts.treatmentCount = (
	SELECT MAX(treatmentCounts.treatmentCount)
	FROM (
		SELECT COUNT(TreatmentId) as [treatmentCount]
		FROM DetailSalonServices as dss
		GROUP BY TransactionId
	) as treatmentCounts
)