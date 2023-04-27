DROP DATABASE IF EXISTS Dealership;
CREATE DATABASE Dealership;
USE Dealership;

CREATE TABLE `Vehicles` (
                            `vin` varchar(20) PRIMARY KEY,
                            `make` varchar(20) NOT NULL,
                            `model` varchar(20) NOT NULL,
                            `exterior_color` varchar(20) NOT NULL,
                            `interior_color` varchar(20) NOT NULL,
                            `model_year` year NOT NULL,
                            `drivetrain` varchar(20) NOT NULL,
                            `is_new` bool NOT NULL
);

CREATE TABLE `Inventory` (
                             `stock_id` int PRIMARY KEY AUTO_INCREMENT,
                             `vin` varchar(20) NOT NULL,
                             `landed_cost` decimal(10,2) NOT NULL,
                             `asking_price` decimal(10,2) NOT NULL,
                             `incoming_mileage` int NOT NULL,
                             `sale_id` int COMMENT 'If not present, vehicle can be sold'
);

CREATE TABLE `Salesperson` (
                               `sp_id` varchar(20) PRIMARY KEY,
                               `name` varchar(20) NOT NULL,
                               `hire_year` year NOT NULL,
                               `commission_rate` int NOT NULL
);

CREATE TABLE `Sales` (
                         `sale_id` int AUTO_INCREMENT,
                         `stock_id` int NOT NULL,
                         `customer_id` int NOT NULL,
                         `sp_id` varchar(20) NOT NULL,
                         `sold_price` decimal(10,2) NOT NULL,
                         PRIMARY KEY (`sale_id`, `stock_id`)
);

CREATE TABLE `Customers` (
                             `customer_id` int PRIMARY KEY,
                             `name` varchar(20) NOT NULL,
                             `phone` varchar(12) NOT NULL,
                             `email` varchar(20) NOT NULL,
                             `birthday` date NOT NULL
);

CREATE TABLE `VehicleAttributes` (
                                     `vin` varchar(20) NOT NULL,
                                     `attribute` varchar(20) NOT NULL,
                                     `value` varchar(20) NOT NULL,
                                     PRIMARY KEY (`vin`, `attribute`)
);

CREATE TABLE `Packages` (
                            `pkg_id` int PRIMARY KEY AUTO_INCREMENT,
                            `name` varchar(20) NOT NULL,
                            `contents` text NOT NULL
);

CREATE TABLE `Vehicle_Packages` (
                                    `vin` varchar(20) PRIMARY KEY,
                                    `package_id` int NOT NULL
);

CREATE INDEX `VehicleAttributes_index_0` ON `VehicleAttributes` (`attribute`);

ALTER TABLE `Inventory` ADD FOREIGN KEY (`vin`) REFERENCES `Vehicles` (`vin`);

ALTER TABLE `Sales` ADD FOREIGN KEY (`stock_id`) REFERENCES `Inventory` (`stock_id`);

ALTER TABLE `Sales` ADD FOREIGN KEY (`customer_id`) REFERENCES `Customers` (`customer_id`);

ALTER TABLE `Sales` ADD FOREIGN KEY (`sp_id`) REFERENCES `Salesperson` (`sp_id`);

ALTER TABLE `VehicleAttributes` ADD FOREIGN KEY (`vin`) REFERENCES `Vehicles` (`vin`);

ALTER TABLE `Vehicle_Packages` ADD FOREIGN KEY (`vin`) REFERENCES `Vehicles` (`vin`);

ALTER TABLE `Vehicle_Packages` ADD FOREIGN KEY (`package_id`) REFERENCES `Packages` (`pkg_id`);
