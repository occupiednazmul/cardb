# Vehicle Rental System — SQL Queries

## Project Description

This project implements a **Vehicle Rental System** database with comprehensive SQL queries. The system manages users, vehicles, and bookings with proper schema design, constraints, and relationships.

## queries.sql File

The `queries.sql` file contains three main sections:

### Part A: Schema

Defines three tables with proper structure:

- **users**: Stores user information (ID, name, email, phone, role)
- **vehicles**: Stores vehicle details (ID, name, type, model, registration number, rental price, status)
- **bookings**: Stores booking records (ID, user ID, vehicle ID, dates, status, total cost)

Includes:

- Primary keys for all tables
- Foreign key constraints linking bookings to users and vehicles
- CHECK constraints for valid values (roles, vehicle types, statuses)
- UNIQUE constraints for email and registration number

### Part B: Sample Data

Provides sample data for testing:

- 3 users (Alice, Bob, Charlie)
- 4 vehicles (Toyota Corolla, Honda Civic, Yamaha R15, Ford F-150)
- 4 bookings with various statuses

### Part C: Required Queries

**Query 1 (JOIN)**: Retrieves booking information with customer name and vehicle name using INNER JOIN

**Query 2 (NOT EXISTS)**: Finds all vehicles that have never been booked

**Query 3 (WHERE)**: Retrieves available vehicles of a specific type (e.g., cars)

**Query 4 (GROUP BY + HAVING)**: Shows total bookings per vehicle, displaying only vehicles with more than 2 bookings

## How to Use

1. Create a database in MySQL, MariaDB, or PostgreSQL
2. Run the `queries.sql` file to create tables and insert sample data
3. Execute each query in the "Required Queries" section to see results

## ERD Link

[View Entity Relationship Diagram](https://lucid.app/lucidchart/5ae772cd-c070-4e1e-897b-7568e99a9c5a/view?viewport_loc=-1775%2C-668%2C4336%2C2006%2C0_0)

## Viva Video Link

[Watch Viva Presentation](https://drive.google.com/file/d/1Mr3t522ETgMjYkc4OkoO5-N0jw8ahg9r/view?usp=sharing)
