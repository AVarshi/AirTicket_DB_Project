CREATE DATABASE team3;

USE team3;

/*

Tables Summary
Airport: airport_code (PK), name, city, country
Airline: airline_code (PK), name, region, website, icao_code
Aircraft: aircraft_id (PK), model, manufacturer, capacity, flight_range, engine_type, year_of_manufacture
Flight: flight_number (PK), departure_time, arrival_time, origin_airport_code (FK), destination_airport_code (FK), airline_code (FK), aircraft_id (FK)
FlightDepartureDay: departure_day (PK), flight_number (FK)
FlightArrivalDay: arrival_day (PK), flight_number (FK)
Class: class_id (PK), name, amenities
TripType: trip_type_id (PK), type_name
Customer: customer_id (PK), first_name, last_name, email, phone, date_of_birth
Booking: booking_number (PK), customer_id (FK), booking_date, status
Passenger: passenger_id (PK), first_name, last_name, date_of_birth, id_proof
Seat: seat_number (PK), flight_number (PK, FK), class_id (FK), is_available
Ticket: ticket_number (PK), booking_number (FK), passenger_id (FK), flight_number (FK), seat_number (FK), class_id (FK), trip_type_id (FK)
Baggage: baggage_id (PK), ticket_number (FK), weight, dimensions, type
Invoice: invoice_number (PK), booking_number (FK), total_amount
Payment: payment_number (PK), invoice_number (FK), payment_date, payment_method, payment_status
*/


-- 1. Airport
CREATE TABLE Airport (
    airport_code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL
);

-- 2. Airline
CREATE TABLE Airline (
    airline_code VARCHAR(10) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    region VARCHAR(50),
    website VARCHAR(100),
    icao_code VARCHAR(10)
);

-- 3. Aircraft
CREATE TABLE Aircraft (
    aircraft_id INT PRIMARY KEY,
    model VARCHAR(50),
    manufacturer VARCHAR(50),
    capacity INT,
    flight_range INT,
    engine_type VARCHAR(50),
    year_of_manufacture INT
);

-- 4. Flight
CREATE TABLE Flight (
    flight_number VARCHAR(10) PRIMARY KEY,
    departure_time DATETIME NOT NULL,
    arrival_time DATETIME NOT NULL,
    origin_airport_code VARCHAR(10),
    destination_airport_code VARCHAR(10),
    airline_code VARCHAR(10),
    aircraft_id INT,
    FOREIGN KEY (origin_airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (destination_airport_code) REFERENCES Airport(airport_code),
    FOREIGN KEY (airline_code) REFERENCES Airline(airline_code),
    FOREIGN KEY (aircraft_id) REFERENCES Aircraft(aircraft_id)
);

-- 6
CREATE TABLE FlightDepartureDay (
    departure_day VARCHAR(15),
    flight_number VARCHAR(10),
    PRIMARY KEY(departure_day, flight_number),
    FOREIGN KEY (flight_number) REFERENCES Flight(flight_number)
);

-- 7
CREATE TABLE FlightArrivalDay (
    arrival_day VARCHAR(15),
    flight_number VARCHAR(10),
    PRIMARY KEY(arrival_day, flight_number),
    FOREIGN KEY (flight_number) REFERENCES Flight(flight_number)
);

-- 7. Customer
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    date_of_birth DATE
);

-- 8. Booking
CREATE TABLE Booking (
    booking_number INT PRIMARY KEY,
    customer_id INT,
    booking_date DATETIME NOT NULL,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

-- 9. Passenger
CREATE TABLE Passenger (
    passenger_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    id_proof VARCHAR(50)
);

-- 10. Class
CREATE TABLE Class (
    class_id INT PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    amenities TEXT
);

-- 11. TripType
CREATE TABLE TripType (
    trip_type_id INT PRIMARY KEY,
    type_name VARCHAR(20) NOT NULL
);

-- 12. Seat (Weak Entity of Flight)
CREATE TABLE Seat (
    seat_number VARCHAR(10),
    flight_number VARCHAR(10),
    class_id INT,
    is_available BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (seat_number, flight_number),
    FOREIGN KEY (flight_number) REFERENCES Flight(flight_number),
    FOREIGN KEY (class_id) REFERENCES Class(class_id)
);

-- 13. Ticket
CREATE TABLE Ticket (
    ticket_number INT PRIMARY KEY,
    booking_number INT,
    passenger_id INT,
    flight_number VARCHAR(10),
    seat_number VARCHAR(10),
    class_id INT,
    trip_type_id INT,
    FOREIGN KEY (booking_number) REFERENCES Booking(booking_number),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(passenger_id),
    FOREIGN KEY (flight_number) REFERENCES Flight(flight_number),
    FOREIGN KEY (seat_number, flight_number) REFERENCES Seat(seat_number, flight_number),
    FOREIGN KEY (class_id) REFERENCES Class(class_id),
    FOREIGN KEY (trip_type_id) REFERENCES TripType(trip_type_id)
);

-- 14. Baggage
CREATE TABLE Baggage (
    baggage_id INT PRIMARY KEY,
    ticket_number INT,
    weight DECIMAL(5, 2),
    dimensions VARCHAR(20),
    type VARCHAR(20),
    FOREIGN KEY (ticket_number) REFERENCES Ticket(ticket_number)
);

-- 15. Invoice
CREATE TABLE Invoice (
    invoice_number INT PRIMARY KEY,
    booking_number INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (booking_number) REFERENCES Booking(booking_number)
);

-- 16. Payment (1-1 Relationship with Invoice)
CREATE TABLE Payment (
    payment_number INT PRIMARY KEY,
    invoice_number INT UNIQUE,
    payment_date DATETIME NOT NULL,
    payment_method VARCHAR(20),
    payment_status VARCHAR(20),
    FOREIGN KEY (invoice_number) REFERENCES Invoice(invoice_number)
);