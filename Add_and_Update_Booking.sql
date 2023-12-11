DELIMITER //
CREATE PROCEDURE AddBooking(
    IN p_BookingID INT,
    IN p_CustomerID VARCHAR(45),
    IN p_BookingDate DATE,
    IN p_TableNumber INT
)
BEGIN
		-- Check if the BookingID is unique
    IF NOT EXISTS (SELECT 1 FROM Bookings WHERE BookingID = p_BookingID) THEN
        -- Insert the new booking record
        INSERT INTO Bookings (BookingID, CustomerID, BookingDate, TableNumber)
        VALUES (p_BookingID, p_CustomerID, p_BookingDate, p_TableNumber);
	
		-- Output a success message
        SELECT 'Booking added successfully' AS Result;
	ELSE
		-- Output an error message if the BookingID is not unique
        SELECT 'Error: Booking ID already exists' AS Result;
	END IF;
END //

DELIMITER ;

CALL AddBooking(10, 'RH-19495', '2022-10-16', 3);




DELIMITER //
-- Create update stored procedure
CREATE PROCEDURE UpdateBooking(IN p_BookingID INT, IN p_NewBookingDate DATE)

BEGIN
	-- Check if the BookingID exists
    IF EXISTS (SELECT 1 FROM Bookings WHERE BookingID = p_BookingID) THEN
        -- Update the booking record with the new booking date
        UPDATE Bookings
        SET BookingDate = p_NewBookingDate
        WHERE BookingID = p_BookingID;
        
        -- Output the result
        SELECT CONCAT('Booking ', p_BookingID, ' Updated ') AS Message;
	ELSE
		-- Output an error message if the BookingID is not found
        SELECT CONCAT('Error: Booking ', p_BookingID, ' not found ') AS Message;
	END IF;
END //

DELIMITER ;

CALL UpdateBooking(12, '2022-10-13');




DELIMITER //
CREATE PROCEDURE CancelBooking(
    IN p_BookingID INT
)
BEGIN
	-- Check if the BookingID exists
    IF EXISTS (SELECT 1 FROM Bookings WHERE BookingID = p_BookingID) THEN
        -- Delete the booking record
        DELETE FROM Bookings WHERE BookingID = p_BookingID;
        -- Display the result
        SELECT CONCAT('Booking ', p_BookingID, ' canceled successfully') AS Result;
    ELSE
		-- Display an error message if the BookingID is not found
        SELECT CONCAT('Error: Booking ', p_BookingID, ' not found') AS Result;
    END IF;
END //

DELIMITER ;

CALL CancelBooking(12);