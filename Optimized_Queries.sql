PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, Cost FROM Orders WHERE CustomerID = ?';
SET @id = 'CR-12730';
EXECUTE GetOrderDetail USING @id;


DELIMITER //
CREATE PROCEDURE CancelOrder (IN p_OrderID VARCHAR(45))
BEGIN
	DELETE FROM Orders WHERE OrderID = p_OrderID;
END //


DELIMITER ;
CALL CancelOrder('IN-2013-77878');