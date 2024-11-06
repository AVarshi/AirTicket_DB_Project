INSERT INTO Airport (airport_code, name, city, country) VALUES
('ATL', 'Hartsfield-Jackson Atlanta', 'Atlanta', 'USA'),
('LAX', 'Los Angeles International', 'Los Angeles', 'USA'),
('ORD', 'O\'Hare International', 'Chicago', 'USA'),
('DFW', 'Dallas/Fort Worth International', 'Dallas', 'USA'),
('JFK', 'John F. Kennedy International', 'New York', 'USA'),
('LHR', 'Heathrow', 'London', 'UK'),
('CDG', 'Charles de Gaulle', 'Paris', 'France'),
('DXB', 'Dubai International', 'Dubai', 'UAE'),
('HND', 'Tokyo Haneda', 'Tokyo', 'Japan'),
('SYD', 'Sydney Kingsford Smith', 'Sydney', 'Australia');


INSERT INTO Airline (airline_code, name, region, website, icao_code) VALUES
('DL', 'Delta Air Lines', 'North America', 'www.delta.com', 'DAL'),
('AA', 'American Airlines', 'North America', 'www.aa.com', 'AAL'),
('BA', 'British Airways', 'Europe', 'www.ba.com', 'BAW'),
('EK', 'Emirates', 'Middle East', 'www.emirates.com', 'UAE'),
('AF', 'Air France', 'Europe', 'www.airfrance.com', 'AFR'),
('QF', 'Qantas', 'Australia', 'www.qantas.com', 'QFA'),
('JL', 'Japan Airlines', 'Asia', 'www.jal.com', 'JAL'),
('LH', 'Lufthansa', 'Europe', 'www.lufthansa.com', 'DLH'),
('UA', 'United Airlines', 'North America', 'www.united.com', 'UAL'),
('SQ', 'Singapore Airlines', 'Asia', 'www.singaporeair.com', 'SIA');


INSERT INTO Aircraft (aircraft_id, model, manufacturer, capacity, flight_range, engine_type, year_of_manufacture) VALUES
(1, 'Boeing 737', 'Boeing', 189, 3500, 'Turbofan', 2015),
(2, 'Airbus A320', 'Airbus', 180, 3200, 'Turbofan', 2017),
(3, 'Boeing 787', 'Boeing', 296, 7600, 'Turbofan', 2018),
(4, 'Airbus A380', 'Airbus', 555, 8000, 'Turbofan', 2016),
(5, 'Boeing 777', 'Boeing', 396, 7500, 'Turbofan', 2012),
(6, 'Airbus A350', 'Airbus', 325, 8500, 'Turbofan', 2019),
(7, 'Boeing 747', 'Boeing', 416, 7700, 'Turbofan', 2014),
(8, 'Embraer 190', 'Embraer', 106, 2900, 'Turbofan', 2020),
(9, 'Bombardier CRJ900', 'Bombardier', 90, 2500, 'Turbofan', 2013),
(10, 'Airbus A321', 'Airbus', 200, 3700, 'Turbofan', 2021);



INSERT INTO Flight (flight_number, airline_code, origin_airport_code, destination_airport_code, departure_time, arrival_time) VALUES
('DL100', 'DL', 'ATL', 'LAX', '2024-02-01 08:00:00', '2024-02-01 11:00:00'),
('AA200', 'AA', 'ORD', 'JFK', '2024-02-01 09:00:00', '2024-02-01 13:00:00'),
('BA300', 'BA', 'LHR', 'JFK', '2024-02-01 10:00:00', '2024-02-01 14:00:00'),
('EK400', 'EK', 'DXB', 'SYD', '2024-02-01 07:30:00', '2024-02-01 20:30:00'),
('AF500', 'AF', 'CDG', 'ATL', '2024-02-01 14:00:00', '2024-02-01 18:00:00'),
('QF600', 'QF', 'SYD', 'LAX', '2024-02-01 17:00:00', '2024-02-01 07:00:00'),
('JL700', 'JL', 'HND', 'ORD', '2024-02-01 15:00:00', '2024-02-01 05:00:00'),
('LH800', 'LH', 'CDG', 'ATL', '2024-02-01 08:30:00', '2024-02-01 12:30:00'),
('SQ900', 'SQ', 'LAX', 'JFK', '2024-02-01 23:30:00', '2024-02-02 06:00:00'),
('UA1100', 'UA', 'ORD', 'ATL', '2024-02-01 12:00:00', '2024-02-01 15:00:00'),
('AA1200', 'AA', 'ATL', 'LAX', '2024-02-01 08:00:00', '2024-02-01 11:00:00'),
('DL1300', 'DL', 'LAX', 'SYD', '2024-02-01 08:00:00', '2024-02-01 18:00:00'),
('QF1400', 'QF', 'SYD', 'JFK', '2024-02-01 16:00:00', '2024-02-01 19:00:00'),
('UA1500', 'UA', 'LAX', 'ORD', '2024-02-01 06:00:00', '2024-02-01 08:30:00'),
('SQ1600', 'SQ', 'ORD', 'ATL', '2024-02-01 09:00:00', '2024-02-01 12:00:00');



INSERT INTO FlightDepartureDay (departure_day, flight_number) VALUES
('Monday', 'DL100'),
('Tuesday', 'AA200'),
('Wednesday', 'BA300'),
('Thursday', 'EK400'),
('Friday', 'AF500'),
('Saturday', 'QF600'),
('Sunday', 'JL700'),
('Monday', 'LH800'),
('Tuesday', 'SQ900'),
('Wednesday', 'UA1100'),
('Thursday', 'AA1200'),
('Friday', 'DL1300'),
('Saturday', 'QF1400'),
('Sunday', 'UA1500');



INSERT INTO FlightArrivalDay (arrival_day, flight_number) VALUES
('Monday', 'DL100'),
('Tuesday', 'AA200'),
('Wednesday', 'BA300'),
('Thursday', 'EK400'),
('Friday', 'AF500'),
('Saturday', 'QF600'),
('Sunday', 'JL700'),
('Monday', 'LH800'),
('Tuesday', 'UA900'),
('Wednesday', 'SQ1000');


INSERT INTO FlightArrivalDay (arrival_day, flight_number) VALUES
('Monday', 'DL100'),
('Tuesday', 'AA200'),
('Wednesday', 'BA300'),
('Thursday', 'EK400'),
('Friday', 'AF500'),
('Saturday', 'QF600'),
('Sunday', 'JL700'),
('Monday', 'LH800'),
('Tuesday', 'SQ900'),
('Wednesday', 'UA1100'),
('Thursday', 'AA1200'),
('Friday', 'DL1300'),
('Saturday', 'QF1400'),
('Sunday', 'UA1500');


INSERT INTO Customer (customer_id, first_name, last_name, email, phone, date_of_birth) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '555-1234', '1985-05-15'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '555-5678', '1990-08-20'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com', '555-8765', '1988-03-10'),
(4, 'Bob', 'Brown', 'bob.brown@example.com', '555-4321', '1983-11-25'),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com', '555-3456', '1979-09-15'),
(6, 'Eva', 'Wilson', 'eva.wilson@example.com', '555-6789', '1992-01-30'),
(7, 'Michael', 'Garcia', 'michael.garcia@example.com', '555-2345', '1980-06-22'),
(8, 'Sophia', 'Martinez', 'sophia.martinez@example.com', '555-7890', '1987-12-05'),
(9, 'Daniel', 'Lopez', 'daniel.lopez@example.com', '555-1122', '1995-04-18'),
(10, 'Emma', 'Hernandez', 'emma.hernandez@example.com', '555-3344', '1991-10-30'),
(11, 'James', 'Clark', 'james.clark@example.com', '555-5566', '1986-07-12'),
(12, 'Olivia', 'Lewis', 'olivia.lewis@example.com', '555-7788', '1994-02-17'),
(13, 'William', 'Walker', 'william.walker@example.com', '555-9900', '1982-04-25'),
(14, 'Ava', 'Hall', 'ava.hall@example.com', '555-1010', '1993-03-13'),
(15, 'Lucas', 'Young', 'lucas.young@example.com', '555-2020', '1981-12-29');


INSERT INTO Booking (booking_number, customer_id, booking_date, status) VALUES
(1, 1, '2024-01-10 14:30:00', 'Confirmed'),
(2, 2, '2024-01-11 09:15:00', 'Pending'),
(3, 3, '2024-01-12 11:45:00', 'Cancelled'),
(4, 4, '2024-01-13 08:30:00', 'Confirmed'),
(5, 5, '2024-01-14 16:00:00', 'Confirmed'),
(6, 6, '2024-01-15 13:00:00', 'Pending'),
(7, 7, '2024-01-16 10:00:00', 'Confirmed'),
(8, 8, '2024-01-17 12:00:00', 'Cancelled'),
(9, 9, '2024-01-18 15:00:00', 'Confirmed'),
(10, 10, '2024-01-19 09:30:00', 'Pending'),
(11, 11, '2024-01-20 11:15:00', 'Confirmed'),
(12, 12, '2024-01-21 14:00:00', 'Cancelled'),
(13, 13, '2024-01-22 17:45:00', 'Confirmed'),
(14, 14, '2024-01-23 10:30:00', 'Pending'),
(15, 15, '2024-01-24 08:00:00', 'Confirmed');



INSERT INTO Passenger (passenger_id, first_name, last_name, date_of_birth, id_proof) VALUES
(1, 'Ethan', 'Roberts', '1990-05-12', 'Passport123'),
(2, 'Mia', 'Parker', '1988-10-28', 'Passport456'),
(3, 'Aiden', 'Harris', '1992-02-18', 'DriverID789'),
(4, 'Isabella', 'Lewis', '1991-07-07', 'Passport321'),
(5, 'Noah', 'Scott', '1987-11-15', 'DriverID654'),
(6, 'Sophia', 'Nelson', '1993-03-03', 'Passport987'),
(7, 'Liam', 'Carter', '1985-08-22', 'DriverID147'),
(8, 'Emma', 'Mitchell', '1989-09-09', 'Passport258'),
(9, 'Oliver', 'Perez', '1994-06-11', 'DriverID369'),
(10, 'Ava', 'Wood', '1995-04-04', 'Passport159');



INSERT INTO Class (class_id, name, amenities) VALUES
(1, 'Economy', 'Standard seating, in-flight entertainment'),
(2, 'Business', 'Larger seats, extra legroom, priority boarding'),
(3, 'First Class', 'Luxury seating, gourmet meals, lounge access'),
(4, 'Premium Economy', 'Enhanced comfort, additional baggage allowance'),
(5, 'Basic Economy', 'Lowest fare, limited amenities');




INSERT INTO TripType (trip_type_id, type_name) VALUES
(1, 'One-way'),
(2, 'Round-trip'),
(3, 'Multi-city');




INSERT INTO Seat (seat_number, flight_number, class_id, is_available) VALUES
('1A', 'DL100', 1, TRUE),
('1B', 'DL100', 1, TRUE),
('1C', 'DL100', 1, TRUE),
('2A', 'DL100', 2, TRUE),
('2B', 'DL100', 2, TRUE),
('3A', 'AA200', 3, TRUE),
('3B', 'AA200', 3, TRUE),
('4A', 'BA300', 1, TRUE),
('4B', 'BA300', 1, FALSE),
('5A', 'EK400', 2, TRUE),
('5B', 'EK400', 2, TRUE),
('6A', 'AF500', 1, TRUE),
('6B', 'AF500', 1, FALSE),
('7A', 'QF600', 3, TRUE),
('8A', 'JL700', 1, TRUE);




INSERT INTO Ticket (ticket_number, booking_number, passenger_id, flight_number, seat_number, class_id, trip_type_id) VALUES
(1, 1, 1, 'DL100', '1A', 1, 1),
(2, 1, 2, 'DL100', '1B', 1, 1),
(3, 2, 3, 'AA200', '3A', 2, 2),
(4, 3, 4, 'BA300', '4A', 3, 1),
(5, 4, 5, 'EK400', '5A', 1, 2),
(6, 5, 6, 'EK400', '5B', 2, 3),
(7, 6, 7, 'DL100', '2A', 1, 1),
(8, 7, 8, 'JL700', '8A', 1, 2),
(9, 8, 9, 'DL100', '1C', 1, 1),
(10, 9, 10, 'QF600', '7A', 3, 1);



INSERT INTO Baggage (baggage_id, ticket_number, weight, dimensions, type) VALUES
(1, 1, 23.50, '55x35x25', 'Checked'),
(2, 2, 15.00, '50x30x20', 'Carry-on'),
(3, 3, 20.00, '60x40x30', 'Checked'),
(4, 4, 25.00, '55x35x25', 'Checked'),
(5, 5, 10.00, '50x30x20', 'Carry-on'),
(6, 6, 30.00, '70x50x40', 'Checked'),
(7, 7, 12.00, '50x30x20', 'Carry-on'),
(8, 8, 22.50, '55x35x25', 'Checked'),
(9, 9, 18.00, '60x40x30', 'Checked'),
(10, 10, 20.00, '55x35x25', 'Checked');



INSERT INTO Invoice (invoice_number, booking_number, total_amount) VALUES
(1, 1, 300.00),
(2, 2, 450.00),
(3, 3, 250.00),
(4, 4, 600.00),
(5, 5, 400.00),
(6, 6, 350.00),
(7, 7, 500.00),
(8, 8, 275.00),
(9, 9, 325.00),
(10, 10, 425.00);


INSERT INTO Payment (payment_number, invoice_number, payment_date, payment_method, payment_status) VALUES
(1, 1, '2024-01-10 15:00:00', 'Credit Card', 'Completed'),
(2, 2, '2024-01-11 10:30:00', 'Debit Card', 'Completed'),
(3, 3, '2024-01-12 14:45:00', 'PayPal', 'Failed'),
(4, 4, '2024-01-13 09:00:00', 'Credit Card', 'Completed'),
(5, 5, '2024-01-14 11:15:00', 'Debit Card', 'Pending'),
(6, 6, '2024-01-15 13:30:00', 'Credit Card', 'Completed'),
(7, 7, '2024-01-16 16:00:00', 'PayPal', 'Completed'),
(8, 8, '2024-01-17 08:30:00', 'Credit Card', 'Completed'),
(9, 9, '2024-01-18 12:00:00', 'Debit Card', 'Completed'),
(10, 10, '2024-01-19 14:15:00', 'Credit Card', 'Pending');
