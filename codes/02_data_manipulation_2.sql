USE doto

-- fungsi agregat: MAX, MIN, AVG, COUNT, SUM
SELECT MAX(EquipmentName) AS [max of equipment name]
FROM Equipments

SELECT *
FROM Equipments
ORDER BY EquipmentName DESC

SELECT MAX(EquipmentName) AS [max of equipment name],
	MIN(EquipmentName) AS [min of equipment name]
FROM Equipments

--SELECT MAX(EquipmentPrice, EquipmentName)
--FROM Equipments

SELECT EquipmentRarity, SUM(EquipmentPrice) as [total equipment price]
FROM Equipments
GROUP BY EquipmentRarity
ORDER BY EquipmentRarity


-- Menerapkan group by dengan 2 kolom
SELECT HeroId, EquipmentRarity, SUM(EquipmentPrice) as [total equipment price]
FROM Equipments
GROUP BY HeroId, EquipmentRarity

-- HAVING: melakukan filtering dengan aggregate function
-- query ini mengoutputkan row dengan sum < 300
SELECT HeroId, SUM(EquipmentPrice) as [total equipment price]
FROM Equipments
GROUP BY HeroId
HAVING SUM(EquipmentPrice) < 300

-- Untuk mengakses dokumentasi: F1/FN + F1/CTRL + F1 -> Documentation (Microsoft)
-- Sumber alternatif : https://www.w3schools.com/sql/default.asp


-- REVERSE: membalikkan string
-- Contoh penggunaan fungsi  dengan menggunakan kolom sebagai argument
SELECT REVERSE(EquipmentName)
FROM Equipments

-- Contoh penggunaan fungsi dengan constant value sebagai argument
SELECT LEFT('budi', 2)

-- CAST: melakukan typecasting
-- CONVERT: melakukan typecasting dengan format
-- Melakukan casting tipe data int menjadi varchar
-- '+' dalam varchar berarti append
SELECT CAST(15 as VARCHAR) + '$'
SELECT CONVERT(VARCHAR, 15) + '$'


-- DATE FUNCTIONS

-- GETDATE: fungsi yang mendapatkan tanggal sekarang
SELECT GETDATE()
-- DATENAME(datepart, date): fungsi yang digunakan 
-- untuk mendapatkan nama dari bagian tanggal yang dimau
SELECT DATENAME(WEEKDAY, GETDATE())
-- DATEDIFF(datepart, date1, date2): fungsi yang digunakan untuk
-- mendapatkan selisih dari 2 tanggal
SELECT DATEDIFF(DAY, '2001-2-1', '2004-9-1')
-- YEAR(date): fungsi untuk mendapatkan tahun dalam tanggal tersebut
SELECT YEAR('2001-9-1')


