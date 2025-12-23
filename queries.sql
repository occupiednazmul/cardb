-- SCHEMAS

DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255),
  phone VARCHAR(30),
  role VARCHAR(20) NOT NULL CHECK (role IN ('Admin', 'Customer'))
);

CREATE TABLE vehicles (
  vehicle_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(20) NOT NULL CHECK (type IN ('car', 'bike', 'truck')),
  model INT NOT NULL,
  registration_number VARCHAR(50) NOT NULL UNIQUE,
  rental_price DECIMAL(10,2) NOT NULL CHECK (rental_price >= 0),
  status VARCHAR(20) NOT NULL CHECK (status IN ('available', 'rented', 'maintenance'))
);

CREATE TABLE bookings (
  booking_id INT PRIMARY KEY,
  user_id INT NOT NULL,
  vehicle_id INT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NOT NULL,
  status VARCHAR(20) NOT NULL CHECK (status IN ('pending', 'confirmed', 'completed', 'cancelled')),
  total_cost DECIMAL(10,2) NOT NULL CHECK (total_cost >= 0),

  CONSTRAINT fk_bookings_user
    FOREIGN KEY (user_id) REFERENCES users(user_id),

  CONSTRAINT fk_bookings_vehicle
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),

  CONSTRAINT chk_date_range
    CHECK (end_date >= start_date)
);

-- SAMPLE DATA ENTRY

INSERT INTO users (user_id, name, email, phone, role) VALUES
(1, 'Alice', 'alice@example.com', '1234567890', 'Customer'),
(2, 'Bob', 'bob@example.com', '0987654321', 'Admin'),
(3, 'Charlie', 'charlie@example.com', '1122334455', 'Customer');

INSERT INTO vehicles (vehicle_id, name, type, model, registration_number, rental_price, status) VALUES
(1, 'Toyota Corolla', 'car',   2022, 'ABC-123',  50, 'available'),
(2, 'Honda Civic',    'car',   2021, 'DEF-456',  60, 'rented'),
(3, 'Yamaha R15',     'bike',  2023, 'GHI-789',  30, 'available'),
(4, 'Ford F-150',     'truck', 2020, 'JKL-012', 100, 'maintenance');

INSERT INTO bookings (booking_id, user_id, vehicle_id, start_date, end_date, status, total_cost) VALUES
(1, 1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(2, 1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 3, 2, '2023-12-01', '2023-12-02', 'confirmed',  60),
(4, 1, 1, '2023-12-10', '2023-12-12', 'pending',   100);

-- ASSIGNMENT QUERIES

-- Query 1:
SELECT
  b.booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  b.start_date,
  b.end_date,
  b.status
FROM bookings b
INNER JOIN users u ON u.user_id = b.user_id
INNER JOIN vehicles v ON v.vehicle_id = b.vehicle_id
ORDER BY b.booking_id;

-- Query 2:
SELECT
  v.vehicle_id, v.name, v.type, v.model, v.registration_number, v.rental_price, v.status
FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE b.vehicle_id = v.vehicle_id
)
ORDER BY v.vehicle_id;

-- Query 3:
SELECT
  vehicle_id, name, type, model, registration_number, rental_price, status
FROM vehicles
WHERE status = 'available'
  AND type = 'car'
ORDER BY vehicle_id;

-- Query 4:
SELECT
  v.name AS vehicle_name,
  COUNT(*) AS total_bookings
FROM bookings b
INNER JOIN vehicles v ON v.vehicle_id = b.vehicle_id
GROUP BY v.name
HAVING COUNT(*) > 2
ORDER BY total_bookings DESC, vehicle_name;
