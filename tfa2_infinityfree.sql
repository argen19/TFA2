-- TFA2 POS database export for InfinityFree/phpMyAdmin.
-- First select the database created in your InfinityFree panel, then import this file.
-- This file intentionally does not create or select a database.

-- TFA2 POS tables and sample records. Import into the existing database.

CREATE TABLE `customers` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `full_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20),
    `created_at` DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `customers` (`full_name`, `email`, `phone`, `created_at`) VALUES
('Edzel Arce', 'edzelarce@gmail.com', '09216799439', '2026-01-10 09:00:00'),
('Nadine Carino', 'ccarino@gmail.com', '09195235035', '2026-01-11 09:00:00'),
('Jp Robes', 'jprobes@gmail.com', '09195062310', '2026-01-12 09:00:00'),
('Arby Puno', 'arbypuno@gmail.com', '09247882574', '2026-01-13 09:00:00'),
('Denzel Gavin', 'denzelgavin@gmail.com', '09255872685', '2026-01-14 09:00:00');

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `full_name` VARCHAR(100) NOT NULL,
    `created_at` DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `users` (`username`, `full_name`, `created_at`) VALUES
('admin01', 'Kim Cortez', '2026-01-10 09:00:00'),
('cashier01', 'Ellimac Key', '2026-01-11 09:00:00'),
('cashier02', 'Camille Ye', '2026-01-12 09:00:00'),
('manager01', 'Thea Maine', '2026-01-13 09:00:00'),
('staff01', 'Ali Rain', '2026-01-14 09:00:00');
