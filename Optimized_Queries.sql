-- Procedure that displays the maximum ordered quantity in the Orders table. 
CREATE PROCEDURE GetMaxQuantity() SELECT MAX(Quantity) FROM Orders;
-- invoke the procedure
CALL GetMaxQuantity();

-- creating a prepared statement called GetOrderDetail to reduce the parsing time of queries.
PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost FROM Orders WHERE CustomerID = ?';
-- executing the GetOrderDetail prepared statement
SET @id = 'CR-12730';
EXECUTE GetOrderDetail USING @id;


-- creating stored procedure called CancelOrder to delete an order record based on the user input of the order id.
DELIMITER //
CREATE PROCEDURE CancelOrder (IN p_OrderID VARCHAR(45))
BEGIN
	DELETE FROM Orders WHERE OrderID = p_OrderID;
END //

-- invoking the CancelOrder procedure
DELIMITER ;
CALL CancelOrder('IN-2013-77878');
