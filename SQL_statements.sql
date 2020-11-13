--Queries
--------------Use Case Queries-----------------

--Q1
--Lookup Item
SELECT i_barcode, i_stock, i_storeID, p_price
FROM Inventory, Product
WHERE i_barcode = p_barcode;

--Q2
--Display Inventory
SELECT i_storeID, i_barcode, i_stock, p_price
FROM Inventory, Product, Store
WHERE i_barcode = p_barcode
AND st_storeID = i_storeID;

--Q3
--Display Price
SELECT  i_barcode, p_price
FROM Inventory, Product
WHERE i_barcode = p_barcode;

--Q4
--Lookup City of Store
SELECT ci_name
FROM Inventory, Store, City
WHERE ci_cityKey = st_cityKey
AND st_storeID = i_storeID;

--Q5
--Add Product
INSERT INTO Product Values(11326789, 'Supplier#000000025', 'electronics', 89.99);

--Q6
--Delete Product
DELETE FROM Product WHERE p_barcode = 10000001;

--Q7
--Update Product Price
UPDATE Product
SET p_barcode = 10000002,
    p_supplierID = 'Supplier#000000002',
    p_type = 'produce',
    p_price = 5.96
WHERE
    p_barcode = 10000002;


--Q8
--Add Stock to Inventory
INSERT INTO Inventory VALUES('Store#025', 10000001, 35);

--Q9
--Remove From Stock  Inventory
DELETE FROM Inventory WHERE i_barcode = 10000001 AND i_storeID = 'Store#001';

--Q10
--Remove scanned item from inventory
SELECT  i_stock -1 FROM Inventory WHERE i_barcode = 10000002 AND i_storeID = 'Store#002';
UPDATE Inventory
SET i_stock =  1
WHERE i_barcode = 10000002 AND i_storeID = 'Store#002';


--To display scaned barcodes we can read from a file which
--contains the barcodes to look up

--Q11
--Display product type and price base on barcode '10100801' entered
SELECT p_barcode,p_type,p_price
FROM Product
WHERE p_barcode = 10100801;

--WHERE p_barcode = {}; << if we use python to take in the barcode as key input
 

--Q12
--Displays the supplier with the least expensive product
--and the supplier with the most expensive product
SELECT p_supplierID as 'Supplier',p_type as 'Product type',MAX(p_price) as 'Price'
FROM Supplier,Product,City
WHERE s_cityKey = ci_cityKey
    AND s_supplierID = p_supplierID
UNION 
SELECT p_supplierID,p_type ,MIN(p_price)
FROM Supplier,Product,City
WHERE s_cityKey = ci_cityKey
    AND s_supplierID = p_supplierID;



--Q13
--Display product type that needs to be restock. A product needs
--to be restock if there are less than 15 in stock. 
SELECT p_barcode,p_type,p_price,i_storeID,i_stock
FROM Product, Inventory
WHERE p_barcode = i_barcode
    AND i_stock <= 15
ORDER BY i_storeID;



--Q14
--Display the avg price by product type
SELECT AVG(p_price) as 'AVG price',p_type as 'Product type'
FROM Product
GROUP BY p_type;


--Q15
--Display the country and the number of suppliers that it has
SELECT c_name, COUNT(s_cityKey) as 'Number of suppliers'
FROM City,Country,Supplier
WHERE ci_countryKey = c_countryKey
AND s_cityKey = ci_cityKey
GROUP BY c_name;


--Q16
--Display city name and the number of suppliers it has
SELECT ci_name as 'City',COUNT(s_cityKey) as 'Number of Supplier'
FROM Supplier,City
WHERE s_cityKey = ci_cityKey 
GROUP by ci_name;

--Q17
--Display countries with the max and min shipping rate
SELECT c_name as 'Country',MAX(c_shippingRate) as 'Shipping rate'
FROM Country
UNION
SELECT c_name,MIN(c_shippingRate)
FROM Country;

--Q18
--Display the different product type from Producer
SELECT DISTINCT pr_type as 'Product category'
FROM Producer;

--Q19
--Display supplier and the number of product type that it supplies
SELECT p_supplierID as 'Supplier',count(p_type) as 'Num of product type',p_type as 'Product type'
FROM Product
GROUP by  p_supplierID;


--Q20
--Deletes product that was created in Q5
DELETE FROM Product 
WHERE p_barcode = 11326789;
