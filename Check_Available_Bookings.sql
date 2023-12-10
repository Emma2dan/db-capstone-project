-- Populating the Bookings table
INSERT INTO Bookings VALUES ((1, '2022-10-10', 5, 'CR-12730'), 
(2, '2022-11-12', 3, 'JR-16210'), (3, '2022-10-11', 2, 'JM-15655'), 
(4, '2022-10-13', 2, 'JW-15220'), (5, '2022-10-14', 4, 'KM-16375'), 
(6, '2022-10-15', 3, 'MB-18085'), (7, '2022-10-17', 4, 'RH-19495'), 
(8, '2022-10-16', 2, 'RH-9495'), (9, '2022-10-18', 6, 'TS-21340'));



-- Change the delimiter to enable the use of semicolons within the procedure
DELIMITER //

-- Create procedure called CheckBooking
CREATE PROCEDURE CheckBooking(IN p_booking_date DATE, IN p_table_number INT)
BEGIN
    DECLARE v_booking_status VARCHAR(50);

    -- Check if the table is already booked on the given date
    SELECT 
        CASE 
            WHEN COUNT(*) > 0 THEN 'Booked'
            ELSE 'Available'
        END INTO v_booking_status
    FROM bookings
     WHERE BookingDate = p_booking_date AND TableNumber = p_table_number;

    -- Show the result
    IF v_booking_status = 'Booked' THEN
        SELECT CONCAT('Table ', p_table_number, ' is already booked on ', p_booking_date) AS Message;
    ELSE
        SELECT CONCAT('Table ', p_table_number, ' is available on ', p_booking_date) AS Message;
    END IF;
END //

-- Reset the delimiter back to semicolon
DELIMITER ;

-- Invoke the created procedure
CALL CheckBooking('2022-10-17', 2);