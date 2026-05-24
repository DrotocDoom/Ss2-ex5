CREATE DATABASE HotelDB;
CREATE SCHEMA hotel;

CREATE TABLE hotel.room_types(
    room_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL UNIQUE,
    price_per_night NUMERIC(10, 2) CHECK ( price_per_night > 0),
    max_capacity INT CHECK (max_capacity > 0)
);

CREATE TABLE hotel.rooms(
    room_id SERIAL PRIMARY KEY,
    room_number VARCHAR(10) NOT NULL UNIQUE,
    room_type_id INT,
    status VARCHAR(20) NOT NULL CHECK (status IN ('available', 'occupied', 'maintenance')),
    FOREIGN KEY (room_type_id) REFERENCES room_types(room_type_id)
);

CREATE TABLE hotel.customers(
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL
);

CREATE TABLE hotel.bookings(
    booking_id SERIAL PRIMARY KEY,
    customer_id INT,
    room_id INT,
    check_in DATE NOT NULL,
    check_out DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('confirmed', 'cancelled', 'pending')),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE hotel.payments(
    payment_id SERIAL PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('credit card', 'cash', 'bank transfer')),
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);