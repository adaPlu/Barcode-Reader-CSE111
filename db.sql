CREATE TABLE Inventory(
 i_barcode  INT(15,0) not NULL,
 i_stock       INT(15,0) not NULL,
 i_storeID    INT(15,0) not NULL
);

CREATE TABLE Producer(
 pr_type VARCHAR(25) not NULL,
 pr_cityKey  INT(15,0) not NULL,   
 pr_shippingRateKey  INT(15,0) not NULL
);


CREATE TABLE Supplier(
 s_supplierID  INT(15,0) not NULL,
 s_cityKey      INT(15,0) not NULL,
 s_shippingRateKey  INT(15,0) not NULL
);

CREATE TABLE Product(
 p_barcode  INT(15,0) not NULL,
 p_supplierID  INT(15,0) not NULL,
 p_type   VARCHAR(25) not NULL
);

CREATE TABLE Customer(
 cu_storeID  INT(15,0) not NULL,
 cu_barcode  INT(15,0) not NULL,
 cu_customerID  INT(15,0) not NULL
);

CREATE TABLE Store(
 st_storeID  INT(15,0) not NULL,
 st_cityKey  INT(15,0) not NULL,
 st_type   VARCHAR(25) not NULL
);

CREATE TABLE ShippingCost(
 sh_countryKey    INT(15,0) not NULL,
 sh_shippingRate  DECIMAL(10,0) not NULL
);

CREATE TABLE Country(
 c_countryKey  INT(15,0) not NULL,
 c_name    VARCHAR(25) not NULL
);

CREATE TABLE City(
 ci_cityKey   INT(15,0) not NULL,
 ci_countryKey   INT(15,0) not NULL,
 ci_name   VARCHAR(25) not NULL
);

CREATE TABLE StoreSupp(
 stu_storeID    INT(15,0) not NULL,
 stu_suppID  INT(15,0) not NULL
);

CREATE TABLE ProductCustomer(
 pc_custID        INT(15,0) not NULL,
 pc_barcode     INT(15,0) not NULL
);

--For manual insertion and their input type
INSERT INTO Inventory Values (int,int,int);
INSERT INTO Producer Values (varchar,int,int);
INSERT INTO Supplier Values (int,int,int);
INSERT INTO Product Values (int,int,varchar);
INSERT INTO Customer Values (int,int,int);
INSERT INTO Store Values (int,int,varchar);
INSERT INTO ShippingCost Values (int,decimal);
INSERT INTO Country Values (int,varchar);
INSERT INTO City Values (int,int,varchar);
INSERT INTO StoreSupp Values (int,int);
INSERT INTO ProductCustomer Values (int,int);

--To test that the table was properly created and is taking inputs
INSERT INTO Inventory Values (2,3,5);

SELECT *
FROM Inventory;