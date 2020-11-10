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


/*
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
--Display test data
SELECT *
FROM Inventory;

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
--Delete Product
--Update Product Price
--Add to Inventory
--Remove From Inventory
--Enter/Scan Barcode