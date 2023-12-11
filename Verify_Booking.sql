-- Change the delimiter to enable the use of semicolons within the body of procedure
DELIMITER //

CREATE PROCEDURE AddValidBooking(IN p_booking_date DATE, IN p_table_number INT, IN p_new_customer_id VARCHAR(45))
BEGIN
	DECLARE v_existing_customer_id VARCHAR(45);
    
    -- Start a transaction
    START TRANSACTION;
    
    -- Check if the table is already booked on the given date
    SELECT CustomerID
    INTO v_existing_customer_id
    FROM Bookings
    WHERE BookingDate = p_booking_date AND TableNumber = p_table_number
    LIMIT 1;
    
    -- If the table is already booked, then rollback the transaction
    IF v_existing_customer_id IS NOT NULL THEN
		ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Table is already booked under another name. Reservation Declined.';
	ELSE
		 -- Proceed with the reservation, provided the table is available
        -- Insert the new reservation details into the bookings table
        INSERT INTO bookings (BookingDate, TableNumber, CustomerID) VALUES (p_booking_date, p_table_number, p_new_customer_id);
                        
        -- Commit the transaction
        COMMIT;
        
        SELECT 'Reservation Successful.' AS Message;
	END IF;
END //


-- Reset the delimiter
DELIMITER ;


CALL AddValidBooking('2022-10-16', 3, 'RH-19495');
