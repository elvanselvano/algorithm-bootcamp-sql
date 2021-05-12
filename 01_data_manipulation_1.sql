-- Membuat sebuah database bernama session2
CREATE DATABASE session2

USE session2

-- Membuat sebuah tabel bernama Heroes
CREATE TABLE Heroes(
	-- Menjadikan kolum HeroID sebagai Primary Key yang 
-- berfungsi untuk membedakan satu hero dengan hero lainnya
	HeroId CHAR(5) PRIMARY KEY,

	-- Membuat kolum HeroName dengan tipe data varchar 255 yang artinya dapat menampung 255 karakter, bedanya dengan char 5 adalah kalau varchar kita tidak wajib mengisi dengan jumlah yang kita berikan sedangkan char wajib.
	HeroName VARCHAR(255),
	HeroType VARCHAR(10),
	-- NOT NULL artinya kolum tidak boleh NULL (kosong)
	HeroAttribute CHAR(3) NOT NULL
		-- Mengecek apakah HeroAttribute merupakan int/str/agi
		CHECK(HeroAttribute like 'int' or HeroAttribute like 'str' or 
			HeroAttribute like 'agi')
)

CREATE TABLE Equipments(
	EquipmentId CHAR(5),
	HeroId CHAR(5),
	EquipmentName VARCHAR(255),
	EquipmentRarity VARCHAR(20),
	EquipmentPrice INT DEFAULT 0,
	-- 	Selain kita bisa langsung tulis PK di EquipmentID, kita juga bisa menggunakan constraint
	CONSTRAINT EquipmentsPK PRIMARY KEY(EquipmentId),
	CONSTRAINT EquipmentFK FOREIGN KEY(HeroId) REFERENCES Heroes(HeroId) 
		ON UPDATE CASCADE ON DELETE SET NULL
)

-- Nambah kolom baru HeroUseRate dengan constraint default 0 
ALTER TABLE Equipments
ADD HeroUseRate FLOAT DEFAULT 0

-- Menghapus kolom HeroUseRate
ALTER TABLE Equipments
DROP COLUMN HeroUseRate

-- Mengubah tipe data pada kolom EquipmentName dari VARCHAR(255) menjadi VARCHAR(200)
ALTER TABLE Equipments
ALTER COLUMN EquipmentName VARCHAR(200)

-- Menambahkan constraint CHECK pada table Heroes dengan nama constraint PKCheck
ALTER TABLE Heroes
ADD CONSTRAINT PKCheck CHECK(HeroId like 'HE[0-9][0-9][0-9]')

-- Menghapus constraint PKCheck yang ada pada table Heroes
ALTER TABLE Heroes
DROP CONSTRAINT PKCheck

-- Melakukan insert dengan input berurutan sesuai yang telah ditentukan
INSERT INTO Heroes (HeroId, HeroAttribute, HeroName, HeroType)
VALUES
('HE001', 'int', 'wukong', 'Melee')

-- Melakukan insert sesuai dengan urutan aslinya pada sebuah kolom 
INSERT INTO Heroes
VALUES('HE002', 'test', 'Melee', 'agi')

-- Melakukan insert dengan value lebih dari 1 
-- Kita dapat menambahkan value pada kolom-kolom terpilih/tertentu
INSERT INTO Heroes (HeroId, HeroAttribute)
VALUES
('HE004', 'str'),
('HE005', 'int')

-- DELETE statement digunakan untuk men-delete data dalam suatu table
-- DELETE FROM: digunakan untuk memilih database yang datanya akan dihapus
-- query ini menghapus hero dengan Id HE001
DELETE FROM Heroes
WHERE HeroId like 'HE001'

-- UPDATE statement digunakan untuk meng-update data dalam suatu table
-- SET: digunakan untuk meng-update column tertentu

-- dalam query ini semua hero dengan HeroId HE003 diupdate 
-- sehingga HeroName menjadi ‘nautilus’ dan HeroType menjadi ‘Range’
UPDATE Heroes
SET HeroName = 'nautilus', 
HeroType = 'Range'
WHERE HeroId like 'HE003'

-- BEGIN TRAN: mulai transaksi dan kunci table, semua proses tidak bisa mengakses table
BEGIN TRAN

-- dalam query ini kondisi where tidak dispesifikasi sehingga semua row mengalami perubahan
UPDATE Heroes
SET HeroName = NULL

-- COMMIT: digunakan untuk meng-unlock table dan simpan perubahan
-- ROLLBACK: digunakan untuk meng-unlock table dan membuang perubahan
COMMIT
ROLLBACK
