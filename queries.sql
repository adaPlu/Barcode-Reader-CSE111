--Deletes all Data in Tables
--/*
delete from Inventory;
delete from Producer;
delete from Supplier;
delete from Customer;
delete from Product;
delete from Store;
delete from City;
delete from Country;
delete from ShippingCost;
delete from StoreSupp;
delete from ProductCustomer;
--*/
--Create all tables
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

CREATE TABLE IF NOT EXISTS ShippingCost(
 sh_countryKey    INT(15,0) not NULL,
 sh_shippingRate  DECIMAL(10,0) not NULL
);

CREATE TABLE IF NOT EXISTS Country(
 c_countryKey  INT(15,0) not NULL,
 c_name    VARCHAR(25) not NULL
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

--Load Sample Data
.mode "csv"
.separator "|"
.import "data/city.tbl" city

.separator "|"
.import "data/country.tbl" country

.separator "|"
.import "data/customer.tbl" customer

.separator "|"
.import "data/product.tbl" product

.separator "|"
.import "data/inventory.tbl" inventory 

.separator "|"
.import "data/producer.tbl" producer

.separator "|"
.import "data/shippingcost.tbl" shippingcost

.separator "|"
.import "data/storesupp.tbl" storesupp

.separator "|"
.import "data/productcustomer.tbl" productcustomer

.separator "|"
.import "data/supplier.tbl" supplier


/* This didnt work for me? --Ada
--For manual insertion and their input type
INSERT INTO Inventory Values (int,int,int);
INSERT INTO Producer Values (varchar,int,int);
INSERT INTO Supplier Values (int,int,int);
INSERT INTO Product Values (varchar,int,int,varchar,int);
INSERT INTO Customer Values (int,int,int);
INSERT INTO Store Values (int,int,varchar);
INSERT INTO ShippingCost Values (int,decimal);
INSERT INTO Country Values (int,varchar);
INSERT INTO City Values (int,int,varchar);
INSERT INTO StoreSupp Values (int,int);
INSERT INTO ProductCustomer Values (int,int);

--To test that the table was properly created and is taking inputs
--Add test data
INSERT INTO Inventory Values (2,3,5);
*/

--Queries
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

--Lookup City of Store that has item
SELECT ci_name
FROM Inventory, Store, City
WHERE ci_cityKey = st_cityKey
AND st_storeID = i_storeID;

--Add Product
--INSERT INTO Product(p_barcode,p_supplerID,
--p_type, p_price) Values()
--Delete Product
--Update Product Price
--Add to Inventory
--Remove From Inventory
--Enter/Scan Barcode