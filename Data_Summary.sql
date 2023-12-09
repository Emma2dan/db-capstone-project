-- Creating a virtual table called OrdersView for all orders with a quantity greater than 2. 
CREATE VIEW `ordersview` AS SELECT OrderID, Quantity, Cost FROM Orders
WHERE Quantity > 2;


-- Using JOIN to extract information from multiple tables on all customers with orders that cost more than $150.
SELECT Customers.CustomerID, Customers.FullName, Orders.OrderID, Orders.Cost, 
Products.ProductName, Category.CategoryName 
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
JOIN Products ON Orders.ProductID = Products.ProductID 
JOIN Category ON Products.CategoryID = Category.CategoryID 
WHERE Orders.Cost > 150 
ORDER BY Orders.Cost ASC;


-- finding all product names for which more than 2 orders have been placed.
SELECT ProductName FROM Products WHERE ProductID 
IN (SELECT ProductID FROM Orders WHERE Quantity > 2);

