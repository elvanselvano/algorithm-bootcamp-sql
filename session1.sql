-- Membuat Database
-- Kita dapat membuat sebuah database object menggunakan `create database [nama tabel]`
-- Query di bawah membuat sebuah database bernama hello_world
create database hello_world

-- USE: digunakan untuk memilih database yang akan digunakan
-- query ini digunakan untuk memilih database hello_world
use hello_world

-- DROP: digunakan untuk menghapus objek dalam database
-- query ini digunakan untuk menghapus database bernama hello_world
drop database hello_world

-- kita memilih doto untuk database yang akan digunakan
use doto

-- SELECT statement digunakan untuk mengoutput isi dari satu atau lebih table
-- SELECT: digunakan untuk memilih column yang mau kita output-kan
-- *: berarti kita mau meng-outputkan semua column yang ada di dalam tabel
-- FROM: digunakan untuk memilih table mana yang akan digunakan
-- query ini mengoutputkan semua column dalam tabel Users
select *
from Users

-- dalam select kita dapat memasukkan column apa saja yang akan dioutputkan
-- query ini mengoutputkan column UserName dalam tabel Users
select UserName
from Users

-- WHERE: digunakan untuk melakukan filtering berdasarkan suatu kondisi
-- operators: < > <= >= = between
-- && = and | || = or

-- query ini mengoutputkan semua column dalam equipments, 
-- equipment yand dioutputkan adalah equipment dengan
-- EquipmentPrice di antara 12 dan 300 (inclusive)
select *
from Equipments
where EquipmentPrice >= 12 and EquipmentPrice <= 300

-- BETWEEN: sebuah operator yang melakukan pengecekan apakah value dalam suatu range
-- queri ini juga mengoutputkan hal yang sama dengan query di atas
-- tetapi query ini menggunakan between
select *
from Equipments
where EquipmentPrice between 12 and 300

-- query ini menunjukkan equipment yang memiliki harga di bawah 12 atau di atas 300
select *
from Equipments
where EquipmentPrice < 12 or EquipmentPrice > 300

-- LIKE: operator yang digunakan untuk mencari suatu pattern
-- %: menunjukkan pattern 0 atau lebih character
-- query ini menunjukkan user dengan username yang mengandung a
SeLEcT *
fRoM Users
WheRe UserName like '%a%'

-- query ini menunjukkan user dengan username yang mulai dengan a
SeLEcT *
fRoM Users
WheRe UserName like 'a%'

-- query ini menunjukkan user dengan username yang berakhir dengan a
SeLEcT *
fRoM Users
WheRe UserName like '%a'

-- NOT: operator yang melakukan negasi hasil kondisi
--query ini mendapatkan username yang tidak memiliki huruf a
select *
from Users
where UserName not like '%a%'

-- ORDER BY: digunakan untuk mengurutkan output 
-- mengikuti satu atau lebih column pembanding by default ascending
-- ASCENDING: berurut sehingga value semakin membesar
-- query ini mengeluarkan semua equipment dan diurutkan berdasarkan harga secara ascending
select *
from Equipments
order by EquipmentPrice

-- DESCENDING: berurut sehingga value semakin mengecil
-- tambah keyword DESC untuk sorting descending
-- query ini mengeluarkan semua equipment dan diurutkan berdasarkan harga secara descending
select *
from Equipments
order by EquipmentPrice desc

-- order by bisa menggunakan lebih dari 2 column sebagai pembanding
-- prioritas ada di kiri, sehingga dalam query ini dilakukan ordering berdasarkan harga
-- jika harga sama maka baru diorder berdasarkan rarity
select *
from Equipments
order by EquipmentPrice desc, EquipmentRarity

-- AS: operator yang digunakan untuk memberi alias (nama sementara)
-- alias dapat diberikan ke table atau column
-- jika column diberikan alias maka nama column output mengikuti alias
-- []: digunakan untuk memberi alias dengan nama yang memilik spasi atau merupakan keyword
-- query ini mengeluarkan column EquipmentPrice dari tabel Equipments, 
-- output memiliki nama column 'Equipment Price'
select EquipmentPrice as [Harga Barang]
from Equipments