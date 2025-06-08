USE e_commerce;
SELECT * FROM ecom;
 
 
# A. Use SELECT, WHERE, ORDER BY, GROUP BY

-- Total quantity sold per country, highest first
SELECT Country, SUM(Quantity) AS TotalQuantity
FROM ecom
GROUP BY Country
ORDER BY TotalQuantity DESC;

-- Orders with unit price over 5
SELECT * FROM ecom
WHERE UnitPrice > 5
ORDER BY UnitPrice DESC;



#B. Use JOINS (INNER, LEFT, RIGHT)

-- Sample customer table
CREATE TABLE customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- INNER JOIN
SELECT e.InvoiceNo, c.CustomerName, e.UnitPrice
FROM ecom e
INNER JOIN customers c ON e.CustomerID = c.CustomerID;

-- LEFT JOIN
SELECT e.*, c.CustomerName
FROM ecom e
LEFT JOIN customers c ON e.CustomerID = c.CustomerID;

-- RIGHT JOIN
SELECT e.*, c.CustomerName
FROM ecom e
RIGHT JOIN customers c ON e.CustomerID = c.CustomerID;



# C. WRITE SUBQUERIES

-- Find all rows with unit price above the average
SELECT * FROM ecom
WHERE UnitPrice > (
    SELECT AVG(UnitPrice) FROM ecom
);



# D. Use AGGREGATE FUNCTIONS (SUM, AVG)

-- Total and average sales per country
SELECT Country,
       SUM(Quantity * UnitPrice) AS TotalSales,
       AVG(UnitPrice) AS AvgUnitPrice
FROM ecom
GROUP BY Country;


# E. CREATE VIEWS FOR ANALYSIS

-- View for Customer Spending Summary
CREATE VIEW css AS
SELECT CustomerID,
       COUNT(DISTINCT InvoiceNo) AS TotalOrders,
       SUM(Quantity * UnitPrice) AS TotalSpent
FROM ecom
GROUP BY CustomerID
ORDER BY TotalSpent DESC;

SELECT * FROM css;



# F. OPTIMIZE QUERIES WITH INDEXES

-- Index on InvoiceDate for faster time-based filtering
CREATE INDEX idx_invoicedate ON ecom(InvoiceDate);
SHOW TABLES;
DESCRIBE ecom;
CREATE INDEX idx_country_customer ON ecom(Country(50), CustomerID);
SHOW INDEX FROM ecom;




