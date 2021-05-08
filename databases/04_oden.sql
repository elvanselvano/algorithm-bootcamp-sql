CREATE DATABASE gerobak_oden
GO
USE gerobak_oden

GO

DROP TABLE TrHeaderTransaction
DROP TABLE TrDetailTransaction
DROP TABLE MsOden
DROP TABLE MsCustomer
DROP TABLE MsStaff
CREATE TABLE MsOden(
	OdenId CHAR(5) CHECK(OdenId LIKE 'OD[0-9][0-9][0-9]') PRIMARY KEY NOT NULL,
	OdenName VARCHAR(50) NOT NULL,
	OdenTopping VARCHAR(50) NOT NULL,
	OdenSauce VARCHAR(30) NOT NULL,
	OdenPrice INT NOT NULL
)

CREATE TABLE MsCustomer(
	CustomerId CHAR(5) CHECK(CustomerId LIKE 'CU[0-9][0-9][0-9]') PRIMARY KEY NOT NULL,
	Customername VARCHAR(50)NOT NULL,
	CustomerGender VARCHAR(10) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerPhone VARCHAR(15) NOT NULL
)

CREATE TABLE MsStaff(
	StaffId CHAR(5) CHECK(StaffId LIKE 'ST[0-9][0-9][0-9]') PRIMARY KEY NOT NULL,
	StaffName VARCHAR(50)NOT NULL,
	StaffGender VARCHAR(10) NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffPhone VARCHAR(15) NOT NULL
)

CREATE TABLE TrHeaderTransaction(
	TransactionId CHAR(5) CHECK(TransactionId LIKE 'TR[0-9][0-9][0-9]') NOT NULL PRIMARY KEY,
	[Date] DATE NOT NULL,
	CustomerId CHAR(5) NOT NULL ,
	StaffId CHAR(5) NOT NULL
	CONSTRAINT CustomerId FOREIGN KEY (CustomerId) REFERENCES MsCustomer(CustomerId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT StaffId FOREIGN KEY (StaffId) REFERENCES MsStaff(StaffId) ON DELETE CASCADE ON UPDATE CASCADE
)

CREATE TABLE TrDetailTransaction(
	TransactionId CHAR(5) NOT NULL,
	OdenId CHAR(5) CHECK(OdenId LIKE 'OD[0-9][0-9][0-9]') NOT NULL,
	Quantity INT NOT NULL
	CONSTRAINT TransactionId FOREIGN KEY (TransactionId) REFERENCES TrHeaderTransaction(TransactionId) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT OdenId FOREIGN KEY (OdenId) REFERENCES MsOden(OdenId) ON DELETE CASCADE ON UPDATE CASCADE
)

GO
INSERT INTO MsCustomer VALUES('CU001', 'James Hogwart', 'Male', '09/07/2000', '0856959120000')
INSERT INTO MsCustomer VALUES('CU002', 'John Wik', 'Male', '06/06/1998', '0856959056000')
INSERT INTO MsCustomer VALUES('CU003', 'Anna Kimberly', 'female', '12/07/2001', '0856959350000')
INSERT INTO MsCustomer VALUES('CU004', 'Jane Mary', 'female', '01/11/1995', '0856959002200')
INSERT INTO MsCustomer VALUES('CU005', 'Tommy Back', 'Male', '12/12/2000', '0856959007700')
GO
GO
INSERT INTO MsStaff VALUES('ST001', 'Bone wart', 'Male', '03/07/2000', '0856959044000')
INSERT INTO MsStaff VALUES('ST002', 'Banner Kiw', 'Male', '01/07/1998', '08569590000120')
INSERT INTO MsStaff VALUES('ST003', 'Iana Kimberly', 'female', '03/07/2001', '08569590100000')
INSERT INTO MsStaff VALUES('ST004', 'Ash Lee', 'female', '01/11/2000', '0856959001100')
INSERT INTO MsStaff VALUES('ST005', 'Toms Spel', 'Male', '12/12/2000', '0856959000012')
GO
INSERT INTO MsOden VALUES('OD001', 'Daikon', 'Nori', 'Teriyaki Sauce', 2000)
INSERT INTO MsOden VALUES('OD002', 'Sumire', 'Nori', 'Dengaku Miso', 2000)
INSERT INTO MsOden VALUES('OD003', 'Chikuwa', 'Katsuoboshi', 'Daikon Sauce', 2500)
INSERT INTO MsOden VALUES('OD004', 'Aburaage Tofu', 'Chili Flakes', 'Ponzu Sauce', 3000)
INSERT INTO MsOden VALUES('OD005', 'Konnyaku', 'Katsuoboshi', 'Teriyaki Sauce', 1500)

GO
INSERT INTO TrHeaderTransaction VALUES('TR001', '11/12/2019', 'CU002', 'ST001')
INSERT INTO TrHeaderTransaction VALUES('TR002', '09/10/2019', 'CU001', 'ST002')
INSERT INTO TrHeaderTransaction VALUES('TR003', '08/08/2019', 'CU002', 'ST005')
INSERT INTO TrHeaderTransaction VALUES('TR004', '12/01/2019', 'CU005', 'ST004')
INSERT INTO TrHeaderTransaction VALUES('TR005', '07/03/2019', 'CU003', 'ST001')
INSERT INTO TrHeaderTransaction VALUES('TR006', '12/12/2019', 'CU002', 'ST003')
INSERT INTO TrHeaderTransaction VALUES('TR007', '01/11/2019', 'CU003', 'ST002')
INSERT INTO TrHeaderTransaction VALUES('TR008', '01/01/2019', 'CU002', 'ST002')
INSERT INTO TrHeaderTransaction VALUES('TR009', '12/01/2019', 'CU002', 'ST004')
INSERT INTO TrHeaderTransaction VALUES('TR010', '07/03/2019', 'CU004', 'ST001')

GO
INSERT INTO TrDetailTransaction VALUES('TR001', 'OD002', '1')
INSERT INTO TrDetailTransaction VALUES('TR002', 'OD001', '2')
INSERT INTO TrDetailTransaction VALUES('TR003', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR004', 'OD005', '5')
INSERT INTO TrDetailTransaction VALUES('TR005', 'OD003', '3')
INSERT INTO TrDetailTransaction VALUES('TR006', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR006', 'OD003', '3')
INSERT INTO TrDetailTransaction VALUES('TR007', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR007', 'OD002', '4')
INSERT INTO TrDetailTransaction VALUES('TR008', 'OD004', '5')
INSERT INTO TrDetailTransaction VALUES('TR009', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR009', 'OD001', '1')
INSERT INTO TrDetailTransaction VALUES('TR009', 'OD002', '5')
INSERT INTO TrDetailTransaction VALUES('TR010', 'OD005', '5')
INSERT INTO TrDetailTransaction VALUES('TR010', 'OD003', '3')
INSERT INTO TrDetailTransaction VALUES('TR001', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR002', 'OD003', '10')
INSERT INTO TrDetailTransaction VALUES('TR003', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR003', 'OD002', '2')
INSERT INTO TrDetailTransaction VALUES('TR004', 'OD004', '3')