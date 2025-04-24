--QUESTION1
--Transforming the ProductDetail table into 1NF by splitting multi-valued Products
--Create a new normalized table
CREATE TABLE OrderProducts_1NF AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product
FROM ProductDetail
WHERE Products IS NOT NULL AND Products != ''

UNION ALL

SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', 2), ',', -1)) AS Product
FROM ProductDetail
WHERE Products LIKE '%,%'

UNION ALL

SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(Products, ',', -1)) AS Product
FROM ProductDetail
WHERE Products LIKE '%,%,%';

--QUESTION2
--Creating Orders table to remove partial dependency
CREATE TABLE Orders_2NF AS
SELECT DISTINCT 
    OrderID, 
    CustomerName
FROM OrderDetails;

--Creating OrderItems table with complete dependency on composite key
CREATE TABLE OrderItems_2NF AS
SELECT 
    OrderID,
    Product,
    Quantity
FROM OrderDetails;

--Adding primary keys
ALTER TABLE Orders_2NF ADD PRIMARY KEY (OrderID);
ALTER TABLE OrderItems_2NF ADD PRIMARY KEY (OrderID, Product);