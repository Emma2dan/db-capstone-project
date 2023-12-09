CREATE VIEW `ordersview` AS SELECT OrderID, Quantity, Cost FROM Orders
WHERE Quantity > 2;


SELECT Customers.CustomerID, Customers.FullName, Orders.OrderID, Orders.Cost, 
Products.ProductName, Category.CategoryName 
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
JOIN Products ON Orders.ProductID = Products.ProductID 
JOIN Category ON Products.CategoryID = Category.CategoryID 
WHERE Orders.Cost > 150 
ORDER BY Orders.Cost ASC;


SELECT ProductName FROM Products WHERE ProductID 
IN (SELECT ProductID FROM Orders WHERE Quantity > 2);

