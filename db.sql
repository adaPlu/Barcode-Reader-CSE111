------------------------------TABLES CREATED------------------------------

CREATE TABLE Inventory(
 i_storeID    VARCHAR(30) not NULL,
 i_barcode  INT(15,0) not NULL,
 i_stock       INT(15,0) not NULL
);

CREATE TABLE Producer(
 pr_name VARCHAR(25) not NULL,
 pr_type VARCHAR(25) not NULL,
 pr_cityKey  INT(15,0) not NULL,   
 pr_shippingRateKey  INT(15,0) not NULL
);

CREATE TABLE Supplier(
 s_supplierID  VARCHAR(25) not NULL,
 s_cityKey      INT(15,0) not NULL,
 s_shippingRateKey  INT(15,0) not NULL
);

CREATE TABLE Product(
 p_barcode  INT(15,0) not NULL,
 p_supplierID  VARCHAR(25) not NULL,
 p_type   VARCHAR(25) not NULL,
 p_price    DECIMAL(15,0) not NULL
);

CREATE TABLE Customer(
 cu_customerID  VARCHAR(30) not NULL,
 cu_storeID  VARCHAR(30) not NULL,
 cu_barcode  INT(15,0) not NULL
);

CREATE TABLE Store(
 st_storeID  VARCHAR(25) not NULL,
 st_cityKey  INT(15,0) not NULL,
 st_type   VARCHAR(25) not NULL
);

CREATE TABLE ShippingCost(
 sh_countryKey    INT(15,0) not NULL,
 sh_shippingRate  DECIMAL(10,0) not NULL
);

CREATE TABLE Country(
 c_countryKey  INT(15,0) not NULL,
 c_name    VARCHAR(25) not NULL
);

CREATE TABLE City(
 ci_cityKey   INT(15,0) not NULL,
 ci_countryKey   INT(15,0) not NULL,
 ci_name   VARCHAR(25) not NULL
);

CREATE TABLE StoreSupp(
 stu_storeID VARCHAR(25) not NULL,
 stu_suppID  VARCHAR(25) not NULL
);

CREATE TABLE ProductCustomer(
 pc_custID      VARCHAR(30) not NULL,
 pc_barcode     INT(15,0) not NULL
);

------------------------------TABLES POPULATED------------------------------------

--Inventory: Table data
INSERT INTO Inventory Values ('Store#001',10000001,1);
INSERT INTO Inventory Values ('Store#001',10000002,3);
INSERT INTO Inventory Values ('Store#001',10100001,7);
INSERT INTO Inventory Values ('Store#001',10000001,23);
INSERT INTO Inventory Values ('Store#001',11140001,65);
INSERT INTO Inventory Values ('Store#001',10060001,11);
INSERT INTO Inventory Values ('Store#001',10007002,1);
INSERT INTO Inventory Values ('Store#001',10100801,12);
INSERT INTO Inventory Values ('Store#001',10000901,18);
INSERT INTO Inventory Values ('Store#001',11140201,1);
INSERT INTO Inventory Values ('Store#002',10000001,1);
INSERT INTO Inventory Values ('Store#002',10000002,3);
INSERT INTO Inventory Values ('Store#003',10100001,7);
INSERT INTO Inventory Values ('Store#003',10000001,23);
INSERT INTO Inventory Values ('Store#003',11140001,65);
INSERT INTO Inventory Values ('Store#004',10060001,11);
INSERT INTO Inventory Values ('Store#004',10007002,1);
INSERT INTO Inventory Values ('Store#004',10100801,12);
INSERT INTO Inventory Values ('Store#005',10000901,18);
INSERT INTO Inventory Values ('Store#005',11140201,1);


--Producer: Table data
--go from 0000 to 1000. Replace the far left zero with 1
INSERT INTO Producer Values ('Producer#0001','produce',1000,0);
INSERT INTO Producer Values ('Producer#0002','meat',1000,0);
INSERT INTO Producer Values ('Producer#0003','dryGoods',1004,1);
INSERT INTO Producer Values ('Producer#0004','fruit',1000,0);
INSERT INTO Producer Values ('Producer#0005','clothes',1000,0);
INSERT INTO Producer Values ('Producer#0006','electronics',1004,1);
INSERT INTO Producer Values ('Producer#0007','furniture',1000,0);
INSERT INTO Producer Values ('Producer#0008','meat',1000,0);
INSERT INTO Producer Values ('Producer#0009','clothes',1004,1);
INSERT INTO Producer Values ('Producer#0010','produce',1000,0);
INSERT INTO Producer Values ('Producer#0011','meat',1000,0);
INSERT INTO Producer Values ('Producer#0012','dryGoods',1004,1);

--Supplier: Table data
--go from 0000 to 1000. Replace the far left zero with 1
INSERT INTO Supplier Values ('Supplier#000000001',1000,9);
INSERT INTO Supplier Values ('Supplier#000000001',1000,9);
INSERT INTO Supplier Values ('Supplier#000000002',1000,9);
INSERT INTO Supplier Values ('Supplier#000000003',1001,8);
INSERT INTO Supplier Values ('Supplier#000000004',1002,7);
INSERT INTO Supplier Values ('Supplier#000000005',1003,5);
INSERT INTO Supplier Values ('Supplier#000000006',1003,5);
INSERT INTO Supplier Values ('Supplier#000000007',1002,7);
INSERT INTO Supplier Values ('Supplier#000000008',1004,2);
INSERT INTO Supplier Values ('Supplier#000000009',1005,11);
INSERT INTO Supplier Values ('Supplier#000000010',1005,11);

--Product: Table data
INSERT INTO Product Values (10000001,'Supplier#000000001','meat',3.96);
INSERT INTO Product Values (10000002,'Supplier#000000002','produce',2.96);
INSERT INTO Product Values (10100001,'Supplier#000000003','electonics',32.96);
INSERT INTO Product Values (10000001,'Supplier#000000004','furniture',322.96);
INSERT INTO Product Values (11140001,'Supplier#000000005','clothes',33.99);
INSERT INTO Product Values (10060001,'Supplier#000000001','meat',3.99);
INSERT INTO Product Values (10007002,'Supplier#000000002','produce',1.99);
INSERT INTO Product Values (10100801,'Supplier#000000003','electonics',432.96);
INSERT INTO Product Values (10000901,'Supplier#000000004','furniture',22.96);
INSERT INTO Product Values (11140201,'Supplier#000000005','clothes',3.99);

--Customer: Table data
INSERT INTO Customer Values ('Customer#000000001','Store#001',11140001);
INSERT INTO Customer Values ('Customer#000000002','Store#001',10060001);
INSERT INTO Customer Values ('Customer#000000003','Store#001',10007002);
INSERT INTO Customer Values ('Customer#000000004','Store#001',10100801);
INSERT INTO Customer Values ('Customer#000000005','Store#001',10000901);
INSERT INTO Customer Values ('Customer#000000006','Store#002',11140201);
INSERT INTO Customer Values ('Customer#000000007','Store#002',10000001);
INSERT INTO Customer Values ('Customer#000000008','Store#003',10000002);
INSERT INTO Customer Values ('Customer#000000009','Store#004',10100001);
INSERT INTO Customer Values ('Customer#000000010','Store#005',11140001);


--Store: Table data
--go from 0000 to 1000. Replace the far left zero with 1
INSERT INTO Store Values ('Store#001',1001,'meat');
INSERT INTO Store Values ('Store#001',1001,'produce');
INSERT INTO Store Values ('Store#002',1003,'electronics');
INSERT INTO Store Values ('Store#003',1004,'electronics');
INSERT INTO Store Values ('Store#004',1003,'produce');
INSERT INTO Store Values ('Store#004',1003,'meat');
INSERT INTO Store Values ('Store#004',1003,'dryGoods');
INSERT INTO Store Values ('Store#005',1002,'produce');
INSERT INTO Store Values ('Store#005',1002,'meat');
INSERT INTO Store Values ('Store#005',1002,'dryGoods');
INSERT INTO Store Values ('Store#006',1002,'clothes');
INSERT INTO Store Values ('Store#007',1003,'clothes');
INSERT INTO Store Values ('Store#008',1002,'electronics');


--ShippingCost: Table data
INSERT INTO ShippingCost Values (0,100);
INSERT INTO ShippingCost Values (1,130);
INSERT INTO ShippingCost Values (2,52);
INSERT INTO ShippingCost Values (3,85);
INSERT INTO ShippingCost Values (4,96);
INSERT INTO ShippingCost Values (5,35);
INSERT INTO ShippingCost Values (6,56);
INSERT INTO ShippingCost Values (7,77);
INSERT INTO ShippingCost Values (8,55);
INSERT INTO ShippingCost Values (9,34);
INSERT INTO ShippingCost Values (10,88);
INSERT INTO ShippingCost Values (11,68);
INSERT INTO ShippingCost Values (12,69);
INSERT INTO ShippingCost Values (13,55);
INSERT INTO ShippingCost Values (14,33);
INSERT INTO ShippingCost Values (15,54);
INSERT INTO ShippingCost Values (16,87);
INSERT INTO ShippingCost Values (17,112);
INSERT INTO ShippingCost Values (18,31);
INSERT INTO ShippingCost Values (19,32);
INSERT INTO ShippingCost Values (20,41);
INSERT INTO ShippingCost Values (21,87);
INSERT INTO ShippingCost Values (22,55);
INSERT INTO ShippingCost Values (23,24);
INSERT INTO ShippingCost Values (24,44);

--Country: Table data
INSERT INTO Country Values (0,'ALGERIA');
INSERT INTO Country Values (1,'ARGENTINA');
INSERT INTO Country Values (2,'BRAZIL');
INSERT INTO Country Values (3,'CANADA');
INSERT INTO Country Values (4,'EGYPT');
INSERT INTO Country Values (5,'ETHIOPIA');
INSERT INTO Country Values (6,'FRANCE');
INSERT INTO Country Values (7,'GERMANY');
INSERT INTO Country Values (8,'INDIA');
INSERT INTO Country Values (9,'INDONESIA');
INSERT INTO Country Values (10,'IRAN');
INSERT INTO Country Values (11,'IRAQ');
INSERT INTO Country Values (12,'JAPAN');
INSERT INTO Country Values (13,'JORDAN');
INSERT INTO Country Values (14,'KENYA');
INSERT INTO Country Values (15,'MOROCCO');
INSERT INTO Country Values (16,'MOZAMBIQUE');
INSERT INTO Country Values (17,'PERU');
INSERT INTO Country Values (18,'CHINA');
INSERT INTO Country Values (19,'ROMANIA');
INSERT INTO Country Values (20,'SAUDI ARABIA');
INSERT INTO Country Values (21,'VIETNAM');
INSERT INTO Country Values (22,'RUSSIA');
INSERT INTO Country Values (23,'UNITED KINGDOM');
INSERT INTO Country Values (24,'UNITED STATES');

--City: Table data
--go from 000 to 1000. Add a 1 on the far left
INSERT INTO City Values (1000,24,'NEW YORK');
INSERT INTO City Values (1001,23,'LONDON');
INSERT INTO City Values (1002,24,'LOS ANGELES');
INSERT INTO City Values (1003,24,'CHICAGO');
INSERT INTO City Values (1004,24,'HOUSTON');
INSERT INTO City Values (1005,24,'PHOENIX');
INSERT INTO City Values (1006,24,'SAN ANTONIO');
INSERT INTO City Values (1007,24,'AUSTION');
INSERT INTO City Values (1008,24,'SAN FRANCISCO');
INSERT INTO City Values (1009,24,'OAKLAND');
INSERT INTO City Values (1010,24,'SACROMENTO');
INSERT INTO City Values (1011,24,'CHARLOTTE');
INSERT INTO City Values (1012,24,'FORT WORTH');
INSERT INTO City Values (1013,24,'SEATTLE');
INSERT INTO City Values (1014,24,'DENVER');
INSERT INTO City Values (1015,24,'STOCKTON');
INSERT INTO City Values (1016,24,'BOSTON');
INSERT INTO City Values (1017,24,'DETROIT');
INSERT INTO City Values (1018,24,'MEMPHIS');
INSERT INTO City Values (1019,24,'FRESNO');
INSERT INTO City Values (1020,24,'MERCED');
INSERT INTO City Values (1021,24,'MESA');
INSERT INTO City Values (1022,24,'ATLANTA');
INSERT INTO City Values (1023,12,'TOKYO');
INSERT INTO City Values (1024,24,'LONG BEACH');

--StoreSupp: Table data
INSERT INTO StoreSupp Values ('Store#001','Supplier#000000001');
INSERT INTO StoreSupp Values ('Store#001','Supplier#000000002');
INSERT INTO StoreSupp Values ('Store#002','Supplier#000000001');
INSERT INTO StoreSupp Values ('Store#003','Supplier#000000003');
INSERT INTO StoreSupp Values ('Store#004','Supplier#000000001');
INSERT INTO StoreSupp Values ('Store#004','Supplier#000000002');
INSERT INTO StoreSupp Values ('Store#004','Supplier#000000003');
INSERT INTO StoreSupp Values ('Store#005','Supplier#000000001');
INSERT INTO StoreSupp Values ('Store#005','Supplier#000000002');
INSERT INTO StoreSupp Values ('Store#005','Supplier#000000003');
INSERT INTO StoreSupp Values ('Store#006','Supplier#000000010');
INSERT INTO StoreSupp Values ('Store#007','Supplier#000000009');
INSERT INTO StoreSupp Values ('Store#008','Supplier#000000011');

--ProductCustomer
--Replace the far left 0 with 1
INSERT INTO ProductCustomer Values ('Customer#000000001',10000001);
INSERT INTO ProductCustomer Values ('Customer#000000002',10000002);
INSERT INTO ProductCustomer Values ('Customer#000000003',10000003);
INSERT INTO ProductCustomer Values ('Customer#000000004',10000004);
INSERT INTO ProductCustomer Values ('Customer#000000005',10000005);
INSERT INTO ProductCustomer Values ('Customer#000000006',10000006);
INSERT INTO ProductCustomer Values ('Customer#000000007',10000007);
INSERT INTO ProductCustomer Values ('Customer#000000008',10000008);
INSERT INTO ProductCustomer Values ('Customer#000000009',10000009);
INSERT INTO ProductCustomer Values ('Customer#000000010',10000010);


------------------------------TABLE DISPLAY------------------------------
SELECT *
FROM Inventory;

SELECT *
FROM Producer;

SELECT *
FROM Supplier;

SELECT *
FROM Product;

SELECT *
FROM Customer;

SELECT *
FROM Store;

SELECT *
FROM ShippingCost;

SELECT *
FROM Country;

SELECT *
FROM City;

SELECT *
FROM StoreSupp;

SELECT *
FROM ProductCustomer;


------------------------------QUERIES------------------------------
--Display test data
SELECT * FROM Inventory;

--Use Case Queries
--Lookup Item
SELECT i_barcode, i_stock, i_storeID, p_price
FROM Inventory, Product
WHERE i_barcode = p_barcode;

--Display Inventory
SELECT i_storeID, i_barcode, i_stock, p_price
FROM Inventory, Product, Store
WHERE i_barcode = p_barcode
AND st_storeID = i_storeID;

--Display Price
SELECT  i_barcode, p_price
FROM Inventory, Product
WHERE i_barcode = p_barcode;

--Lookup City of Store
SELECT ci_name
FROM Inventory, Store, City
WHERE ci_cityKey = st_cityKey
AND st_storeID = i_storeID;

--Add Product
--INSERT INTO Product(p_barcode,p_supplerID,
--p_type, p_price) Values()
--Delete Product
--DELETE
--Update Product Price

--Add to Inventory
--INSERT
--Remove From Inventory
--DELETE
--Enter/Scan Barcode
--?