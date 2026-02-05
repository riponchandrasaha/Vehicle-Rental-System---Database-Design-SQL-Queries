# Vehicle Rental System Database

## Project Overview
This project implements a relational database for a **Vehicle Rental System**. The database is designed to manage **users, vehicles, and bookings**, reflecting real-world rental scenarios.

It supports:

- Admin and customer roles
- Vehicle types: Car, Bike, Truck
- Booking management with status tracking
- Data integrity via foreign keys and constraints

---

## Database Schema

### 1. Users Table
Stores information about all users.

| Column   | Type           | Description                         |
|----------|----------------|-------------------------------------|
| user_id  | SERIAL PRIMARY KEY | Unique user identifier           |
| name     | VARCHAR(100)   | Name of the user                    |
| email    | VARCHAR(150) UNIQUE | Unique email for login          |
| password | VARCHAR(255)   | Hashed password                     |
| phone    | VARCHAR(20)    | Contact number                      |
| role     | VARCHAR(50)    | Role of the user (admin/customer)   |

### 2. Vehicles Table
Stores vehicle information.

| Column             | Type            | Description                              |
|-------------------|-----------------|------------------------------------------|
| vehicle_id         | SERIAL PRIMARY KEY | Unique vehicle identifier               |
| name               | VARCHAR(100)    | Vehicle name                             |
| type               | VARCHAR(50)     | Vehicle type (Car/Bike/Truck)           |
| model              | VARCHAR(100)    | Vehicle model                            |
| registration_number | VARCHAR(50) UNIQUE | Unique registration number           |
| rental_price       | DECIMAL(10,2)   | Rental price per day                      |
| status             | VARCHAR(30)     | Vehicle status (available/rented/maintenance) |

### 3. Bookings Table
Stores all rental bookings.

| Column       | Type           | Description                                |
|--------------|----------------|--------------------------------------------|
| booking_id   | SERIAL PRIMARY KEY | Unique booking identifier                 |
| user_id      | INT NOT NULL   | References `users.user_id`                |
| vehicle_id   | INT NOT NULL   | References `vehicles.vehicle_id`          |
| start_date   | DATE NOT NULL  | Booking start date                         |
| end_date     | DATE NOT NULL  | Booking end date                           |
| status       | VARCHAR(30)    | Booking status (pending/confirmed/completed/cancelled) |
| total_cost   | DECIMAL(10,2)  | Total cost of booking                      |

**Relationships**:

- `Users` → `Bookings`: 1-to-many
- `Vehicles` → `Bookings`: 1-to-many
- `Bookings` acts as a junction table linking users and vehicles.

---

## Queries and Solutions (`queries.sql`)

### Query 1: Retrieve booking info with customer & vehicle names


ERD Link: https://drawsql.app/teams/ripon-chandra/diagrams/sql