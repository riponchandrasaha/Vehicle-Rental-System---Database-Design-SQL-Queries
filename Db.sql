CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','confirmed','completed','cancelled')),
    total_cost DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_vehicle
        FOREIGN KEY (vehicle_id)
        REFERENCES vehicles(vehicle_id)
        ON DELETE CASCADE
);
CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,   -- hashed passwords
    phone VARCHAR(20),
    role VARCHAR(50) NOT NULL CHECK (role IN ('admin', 'customer'))
);
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(50) NOT NULL CHECK (type IN ('Car', 'Bike', 'Truck')),
    model VARCHAR(100),
    registration_number VARCHAR(50) UNIQUE NOT NULL,
    rental_price DECIMAL(10,2) NOT NULL,   -- price per day
    status VARCHAR(30) NOT NULL DEFAULT 'available' CHECK (status IN ('available','rented','maintenance'))
);
/* Query 1: JOIN
Requirement: Retrieve booking information along with Customer name and Vehicle name. */
SELECT
    b.booking_id,
    u.name AS customer_name,
    v.name AS vehicle_name,
    b.start_date,
    b.end_date,
    b.status,
    b.total_cost
FROM
    bookings b
INNER JOIN
    users u ON b.user_id = u.user_id
INNER JOIN
    vehicles v ON b.vehicle_id = v.vehicle_id
ORDER BY
    b.booking_id;

/* Query 2: EXISTS
Requirement: Find all vehicles that have never been booked. */
SELECT
    v.vehicle_id,
    v.name AS vehicle_name,
    v.type,
    v.registration_number
FROM
    vehicles v
WHERE
    NOT EXISTS (
        SELECT 1
        FROM bookings b
        WHERE b.vehicle_id = v.vehicle_id
    );
/* Query 3: WHERE
Requirement: Retrieve all available vehicles of a specific type (e.g. cars). */
SELECT
    vehicle_id,
    name AS vehicle_name,
    type,
    model,
    registration_number,
    rental_price,
    status
FROM
    vehicles
WHERE
    type = 'Car'  -- change to 'Bike' or 'Truck' as needed
    AND status = 'available';
/* Query 4: GROUP BY and HAVING */
SELECT

    v.name AS vehicle_name,
    COUNT(b.booking_id) AS total_bookings
FROM
    vehicles v
INNER JOIN
    bookings b ON v.vehicle_id = b.vehicle_id
GROUP BY
     v.name
HAVING
    COUNT(b.booking_id) > 2;