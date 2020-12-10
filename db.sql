--Deletes all Data in Tables
--/*
delete from  Inventory;
delete from Producer;
delete from Supplier;
delete from Customer;
delete from Product;
delete from Store;
delete from City;
delete from Country;
delete from StoreSupp;
delete from ProductCustomer;
--*/


------------------------------TABLES CREATED------------------------------

CREATE TABLE IF NOT EXISTS Inventory(
 i_storeID    VARCHAR(30) not NULL,
 i_barcode  INT(15,0) not NULL,
 i_stock       INT(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Producer(
 pr_name VARCHAR(25) not NULL,
 pr_type VARCHAR(25) not NULL,
 pr_cityKey  INT(15,0) not NULL,   
 pr_shippingRateKey  INT(15,0) not NULL
);


CREATE TABLE IF NOT EXISTS Supplier(
 s_supplierID  VARCHAR(25) not NULL,
 s_cityKey      INT(15,0) not NULL,
 s_shippingRateKey  INT(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Product(
 p_barcode  INT(15,0) not NULL,
 p_supplierID  VARCHAR(25) not NULL,
 p_type   VARCHAR(25) not NULL,
 p_price    DECIMAL(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Customer(
 cu_customerID  VARCHAR(30) not NULL,
 cu_storeID  VARCHAR(30) not NULL,
 cu_barcode  INT(15,0) not NULL
);

CREATE TABLE IF NOT EXISTS Store(
 st_storeID  VARCHAR(25) not NULL,
 st_cityKey  INT(15,0) not NULL,
 st_type   VARCHAR(25) not NULL
);


CREATE TABLE IF NOT EXISTS Country(
 c_countryKey  INT(15,0) not NULL,
 c_name    VARCHAR(25) not NULL,
 c_shippingRate  DECIMAL(10,0) not NULL
);

CREATE TABLE IF NOT EXISTS City(
 ci_cityKey   INT(15,0) not NULL,
 ci_countryKey   INT(15,0) not NULL,
 ci_name   VARCHAR(25) not NULL
);

CREATE TABLE IF NOT EXISTS StoreSupp(
 stu_storeID VARCHAR(25) not NULL,
 stu_suppID  VARCHAR(25) not NULL
);

CREATE TABLE IF NOT EXISTS ProductCustomer(
 pc_custID      VARCHAR(30) not NULL,
 pc_barcode     INT(15,0) not NULL
);

--Trigger remove any customers of a removed prduct and any inventory of a removed product
CREATE TRIGGER IF NOT EXISTS removeCustomers after DELETE on Product
begin
    DELETE FROM Customer WHERE OLD.p_barcode = cu_barcode;
    DELETE FROM ProductCustomer WHERE OLD.p_barcode = pc_barcode;
end;

CREATE TRIGGER IF NOT EXISTS removeInventory after DELETE on Product
begin
    DELETE FROM Inventory WHERE OLD.p_barcode = i_barcode;
end;
--DROP TRIGGER addProductCustomer;
CREATE TRIGGER IF NOT EXISTS addProductCustomer after INSERT on Customer
begin
    INSERT INTO ProductCustomer Values (NEW.cu_customerID, NEW.cu_barcode);
end;
------------------------------TABLES POPULATED------------------------------------

--Inventory: Table data

INSERT INTO Inventory Values ('Store#001',10000002,3);
INSERT INTO Inventory Values ('Store#001',10100001,7);
INSERT INTO Inventory Values ('Store#001',11140001,65);
INSERT INTO Inventory Values ('Store#001',10060001,11);
INSERT INTO Inventory Values ('Store#001',10007002,1);
INSERT INTO Inventory Values ('Store#001',10100801,12);
INSERT INTO Inventory Values ('Store#001',10000901,18);
INSERT INTO Inventory Values ('Store#001',11140201,1);
INSERT INTO Inventory Values ('Store#002',10000001,5);
INSERT INTO Inventory Values ('Store#002',10000002,1);
INSERT INTO Inventory Values ('Store#003',10100001,7);
INSERT INTO Inventory Values ('Store#003',10000001,23);
INSERT INTO Inventory Values ('Store#003',11140001,65);
INSERT INTO Inventory Values ('Store#004',10060001,11);
INSERT INTO Inventory Values ('Store#004',10007002,1);
INSERT INTO Inventory Values ('Store#004',10100801,12);
INSERT INTO Inventory Values ('Store#005',10000901,18);
INSERT INTO Inventory Values ('Store#005',11140201,1);
INSERT INTO Inventory Values ('Store#005',10000001,35);

--Producer: Table data
--go from 0000 to 1000. Replace the far left zero with 1
INSERT INTO Producer Values ('Producer#0001','produce',1000,5);
INSERT INTO Producer Values ('Producer#0002','meat',1000,7);
INSERT INTO Producer Values ('Producer#0003','dryGoods',1004,7);
INSERT INTO Producer Values ('Producer#0004','fruit',1000,9);
INSERT INTO Producer Values ('Producer#0005','clothes',1000,3);
INSERT INTO Producer Values ('Producer#0006','electronics',1004,11);
INSERT INTO Producer Values ('Producer#0007','furniture',1000,10);
INSERT INTO Producer Values ('Producer#0008','meat',1000,9);
INSERT INTO Producer Values ('Producer#0009','clothes',1004,7);
INSERT INTO Producer Values ('Producer#0010','produce',1000,8);
INSERT INTO Producer Values ('Producer#0011','meat',1000,11);
INSERT INTO Producer Values ('Producer#0012','dryGoods',1004,5);

--Supplier: Table data
--go from 0000 to 1000. Replace the far left zero with 1
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
INSERT INTO Product Values (10000002,'Supplier#000000002','produce',5.96);
INSERT INTO Product Values (10100001,'Supplier#000000003','electronics',32.96);
INSERT INTO Product Values (11140001,'Supplier#000000005','clothes',33.99);
INSERT INTO Product Values (10060001,'Supplier#000000001','meat',3.99);
INSERT INTO Product Values (10007002,'Supplier#000000002','produce',1.99);
INSERT INTO Product Values (10100801,'Supplier#000000003','electronics',432.96);
INSERT INTO Product Values (10000901,'Supplier#000000004','furniture',22.96);
INSERT INTO Product Values (11140201,'Supplier#000000005','clothes',3.99);
INSERT INTO Product Values (10100802,'Supplier#000000025','electronics',89.99);

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
INSERT INTO Customer Values ('Customer#000000010','Store#005',11140002);
INSERT INTO Customer Values ('C1','S1',1114);
INSERT INTO Customer Values ('C2','S1',1006);
INSERT INTO Customer Values ('C3','S1',1000);
INSERT INTO Customer Values ('C4','S1',1010);
INSERT INTO Customer Values ('C5','S2',1000);
INSERT INTO Customer Values ('C6','S4',1114);
INSERT INTO Customer Values ('C7','S4',1000);
INSERT INTO Customer Values ('C8','S4',1000);
INSERT INTO Customer  Values ('C9','S5',1010);
INSERT INTO Customer Values ('C10','S5',1114);


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
INSERT INTO Store Values ('S1',01, 'meat');
INSERT INTO Store Values ('S2',10, 'food');
INSERT INTO Store Values ('S3',09, 'electronics');
INSERT INTO Store Values ('S4',08, 'clothes');
INSERT INTO Store Values ('S5',07, 'food');
INSERT INTO Store Values ('S6',06, 'food');
INSERT INTO Store Values ('S7',05, 'electronics');
INSERT INTO Store Values ('S8',04, 'clothes');
INSERT INTO Store Values ('S9',03,'electronics');
INSERT INTO Store Values ('S10',02, 'produce');


--Country: Table data
INSERT INTO Country Values (0,'ALGERIA',100);
INSERT INTO Country Values (1,'ARGENTINA',130);
INSERT INTO Country Values (2,'BRAZIL',52);
INSERT INTO Country Values (3,'CANADA',85);
INSERT INTO Country Values (4,'EGYPT',96);
INSERT INTO Country Values (5,'ETHIOPIA',35);
INSERT INTO Country Values (6,'FRANCE',56);
INSERT INTO Country Values (7,'GERMANY',77);
INSERT INTO Country Values (8,'INDIA',55);
INSERT INTO Country Values (9,'INDONESIA',34);
INSERT INTO Country Values (10,'IRAN',88);
INSERT INTO Country Values (11,'IRAQ',68);
INSERT INTO Country Values (12,'JAPAN',69);
INSERT INTO Country Values (13,'JORDAN',55);
INSERT INTO Country Values (14,'KENYA',33);
INSERT INTO Country Values (15,'MOROCCO',54);
INSERT INTO Country Values (16,'MOZAMBIQUE',87);
INSERT INTO Country Values (17,'PERU',112);
INSERT INTO Country Values (18,'CHINA',31);
INSERT INTO Country Values (19,'ROMANIA',32);
INSERT INTO Country Values (20,'SAUDI ARABIA',41);
INSERT INTO Country Values (21,'VIETNAM',87);
INSERT INTO Country Values (22,'RUSSIA',55);
INSERT INTO Country Values (23,'UNITED KINGDOM',24);
INSERT INTO Country Values (24,'UNITED STATES',44);

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

/*
--ProductCustomer
--Replace the far left 0 with 1
INSERT INTO ProductCustomer Values ('Customer#000000001',11140001);
INSERT INTO ProductCustomer Values ('Customer#000000002',10060001);
INSERT INTO ProductCustomer Values ('Customer#000000003',10007002);
INSERT INTO ProductCustomer Values ('Customer#000000004',10100801);
INSERT INTO ProductCustomer Values ('Customer#000000005',10000901);
INSERT INTO ProductCustomer Values ('Customer#000000006',11140201);
INSERT INTO ProductCustomer Values ('Customer#000000007',10000001);
INSERT INTO ProductCustomer Values ('Customer#000000008',10000002);
INSERT INTO ProductCustomer Values ('Customer#000000009',10100001);
INSERT INTO ProductCustomer Values ('Customer#000000010',11140002);
INSERT INTO ProductCustomer Values ('C1',1114);
INSERT INTO ProductCustomer Values ('C2',1006);
INSERT INTO ProductCustomer Values ('C3',1000);
INSERT INTO ProductCustomer Values ('C4',1010);
INSERT INTO ProductCustomer Values ('C5',1000);
INSERT INTO ProductCustomer Values ('C6',1114);
INSERT INTO ProductCustomer Values ('C7',1000);
INSERT INTO ProductCustomer Values ('C8',1000);
INSERT INTO ProductCustomer Values ('C9',1010);
INSERT INTO ProductCustomer Values ('C10',1114);
*/


