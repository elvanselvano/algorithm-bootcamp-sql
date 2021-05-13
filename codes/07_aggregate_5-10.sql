USE OOVEO_Salon

-- 5
SELECT tt.TreatmentTypeName, COUNT(*) as [Total Transaction]
FROM DetailSalonServices as dss
JOIN MsTreatment as t on dss.TreatmentId = t.TreatmentId
JOIN MsTreatmentType as tt on t.TreatmentTypeId = tt.TreatmentTypeId
GROUP BY tt.TreatmentTypeName
ORDER BY [Total Transaction] DESC

-- 6
SELECT CONVERT(VARCHAR, hss.TransactionDate, 106) as [Date],
	 'Rp. ' + CAST(SUM(t.Price) as VARCHAR) as [Revenue per Day]
FROM HeaderSalonServices as hss
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as t on dss.TreatmentId = t.TreatmentId
GROUP BY hss.TransactionDate
HAVING SUM(t.Price) BETWEEN 1000000 and 5000000

-- 7
SELECT REPLACE(tt.TreatmentTypeId, 'TT0', 'Treatment Type ') as [ID],
	tt.TreatmentTypeName,
	CAST(COUNT(*) as VARCHAR) + ' Treatment' as [Total Treatment per Type]
FROM MsTreatment as t
JOIN MsTreatmentType as tt on t.TreatmentTypeId = tt.TreatmentTypeId
GROUP BY tt.TreatmentTypeId, tt.TreatmentTypeName
HAVING COUNT(*) > 5
ORDER BY COUNT(*) DESC

-- 8
SELECT LEFT(s.StaffName, CHARINDEX(' ', s.StaffName) - 1) as [StaffName],
	hss.TransactionId, COUNT(*) as [Total Treatment per Transaction]
FROM MsStaff as s
JOIN HeaderSalonServices as hss on s.StaffId = hss.StaffId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
GROUP BY s.StaffName, hss.TransactionId

-- 9
SELECT hss.TransactionDate, c.CustomerName, t.TreatmentName, t.Price
FROM MsCustomer as c
JOIN HeaderSalonServices as hss on c.CustomerId = hss.CustomerId
JOIN MsStaff as s on hss.StaffId = s.StaffId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as t on dss.TreatmentId = t.TreatmentId
WHERE DATENAME(WEEKDAY, hss.TransactionDate) like 'Thursday' AND
	s.StaffName like '%Ryan%'
ORDER BY hss.TransactionDate, c.CustomerName

-- 10
SELECT hss.TransactionDate, c.CustomerName, 
	SUM(t.Price) as [Total Price]
FROM MsCustomer as c
JOIN HeaderSalonServices as hss on c.CustomerId = hss.CustomerId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as t on dss.TreatmentId = t.TreatmentId
WHERE DAY(hss.TransactionDate) > 20
GROUP BY hss.TransactionDate, c.CustomerName
ORDER BY hss.TransactionDate
