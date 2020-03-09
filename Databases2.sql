-- ASH16627870 William Ashton

-- Drops database if it remains from script having been executed already

DROP DATABASE IF EXISTS LincolnComputerSurgery;

-- 1.1 i)

-- Creates new SQL database named after the business

CREATE DATABASE LincolnComputerSurgery;

-- Instructs script which database to run queries against

USE LincolnComputerSurgery;

-- 1.1 ii)

-- Creates table to record personal information about employees

CREATE TABLE Staff (
    StaffEmail varchar(255) NOT NULL, -- Creates columns for each table
    StaffFirstName varchar(255),  -- Varchar is a datatype for variable length string; the digit is the max length
    StaffLastName varchar(255) NOT NULL, -- NOT NULL means that the field cannot hold null values
    PRIMARY KEY (StaffEmail) -- Primary key uniquely identifies each record in the table
);

-- Creates table to record qualifications gained by staff

CREATE TABLE StaffQualifications (
    StaffEmail varchar(255) NOT NULL,
    Qualifications varchar(255),
    PRIMARY KEY (StaffEmail, Qualifications)
);

-- Creates table to record personal information about customers

CREATE TABLE Customers (
    CustomerEmail varchar(255) NOT NULL,
    CustomerFirstName varchar(255),
    CustomerLastName varchar(255) NOT NULL,
    DOB date NOT NULL, 							-- Stores dates
    HouseNumber int NOT NULL,					-- Stores integers
    PostCode varchar(9) NOT NULL,
    City varchar(255) NOT NULL,
    County varchar(12) NOT NULL,
    Country varchar(15) NOT NULL,
    PRIMARY KEY (CustomerEmail) 
);

-- Creates table to record information about services provided
    
CREATE TABLE Services (
    ServiceType varchar(255) NOT NULL,
    ServiceName varchar(255) NOT NULL,
    ItemDescription varchar(255) NOT NULL,
    ServicePrice varchar(255) NOT NULL,
    UNIQUE (ItemDescription),				-- Ensures value has no duplicate as there should only be one of each
    UNIQUE (ServiceName),
    PRIMARY KEY (ServiceName)
);

-- Creates table which records information about orders
    
CREATE TABLE CustomerOrders (
    CustomerEmail varchar(255) NOT NULL,
    StaffEmail varchar(255) NOT NULL,
    OrderDate date NOT NULL,
    ServiceName varchar(255) NOT NULL,
    Discount varchar(255),
    Quantity int NOT NULL,
    OrderPrice decimal (10, 2) NOT NULL,			-- Decimal used to store costs
    CONSTRAINT FK_CustomerOrder FOREIGN KEY (ServiceName) REFERENCES Services(ServiceName), -- Foreign key links two tables together by referring to another primary key
    CONSTRAINT PK_CustomerOrder PRIMARY KEY (CustomerEmail, OrderDate) -- Primary key consists of two values together
);

-- 1.1 iii)

-- Removes column from specified table

ALTER TABLE Services
DROP COLUMN ServiceType;

-- Modifies column to have NOT NULL constraint

ALTER TABLE StaffQualifications
MODIFY COLUMN Qualifications varchar(255) NOT NULL;

-- Adds column to specific table

ALTER TABLE Services
ADD COLUMN ServiceType varchar(255);

-- 1.2 i)

-- Sets default value for County and Country Columns

ALTER TABLE Customers
MODIFY COLUMN County varchar(12) DEFAULT 'Lincolnshire';

ALTER TABLE Customers
MODIFY COLUMN Country varchar(15) DEFAULT 'United Kingdom';

-- Creates index on the customer table, using the CustomerEmail columns

CREATE INDEX idx_Customers
ON Customers (CustomerEmail);

-- Insert valid records into Staff table

INSERT INTO Staff (StaffEmail, StaffFirstName, StaffLastName)
VALUES ('jaydenab@gmail.com', 'Jayden', 'Abbott');
INSERT INTO Staff (StaffEmail, StaffFirstName, StaffLastName)
VALUES ('siennajo@gmail.com', 'Sienna', 'Jordan');
INSERT INTO Staff (StaffEmail, StaffFirstName, StaffLastName)
VALUES ('zarast@gmail.com', 'Zara', 'Stevenson');

-- Insert valid data records into Staff Qualifications table

INSERT INTO StaffQualifications (StaffEmail, Qualifications)
VALUES ('jaydenab@gmail.com', 'A-Level in English Language');
INSERT INTO StaffQualifications (StaffEmail, Qualifications)
VALUES ('jaydenab@gmail.com', 'A-Level in Mathematics');
INSERT INTO StaffQualifications (StaffEmail, Qualifications)
VALUES ('zarast@gmail.com', 'Degree in Computer Science');

-- Insert valid data records into Services table

INSERT INTO Services (ServiceType, ServiceName, ItemDescription, ServicePrice)
VALUES ('Maintenance', 'Desktop Clean-up', 'Involves strip down of all major components, all surfaces cleaned, thermal paste replaced, bearings checked and lubricated, as well as rerouting of cables.', '45.00');
INSERT INTO Services (ServiceType, ServiceName, ItemDescription, ServicePrice)
VALUES ('Maintenance', 'Virus Removal', 'Removal of viruses, malware, spyware, adware, worms and trojans.', '£55.00');
INSERT INTO Services (ServiceType, ServiceName, ItemDescription, ServicePrice)
VALUES ('Repair', 'Data Recovery', 'Recovery of all documents, photos, music and videos onto a selection of media, or into a new hard drive.', '£50.00');
INSERT INTO Services (ServiceType, ServiceName, ItemDescription, ServicePrice)
VALUES ('Upgrade', 'Hardware Upgrade', 'Includes RAM, CPU, hard drives, solid state drives, PSU, GPU, and cooling fans.', '£30.00 per hour');

-- Insert valid data records into Customers table

INSERT INTO Customers (CustomerEmail, CustomerFirstName, CustomerLastName, DOB, HouseNumber, PostCode, City)
VALUES ('isobelzl@gmail.com', 'Isobel', 'Lyons', '1996-05-11', '35', 'LN11 9ET', 'Louth');
INSERT INTO Customers (CustomerEmail, CustomerFirstName, CustomerLastName, DOB, HouseNumber, PostCode, City)
VALUES ('lucaseb@gmail.com', 'Lucas', 'Bennett', '1987-04-01', '99', 'PE23 4EY', 'Spilsby');
INSERT INTO Customers (CustomerEmail, CustomerFirstName, CustomerLastName, DOB, HouseNumber, PostCode, City)
VALUES ('jessicag@hotmail.co.uk', 'Jessica', 'Nixon', '1981-05-07', '31', 'LN4 4NP', 'Lincoln');

-- Insert valid data records into Customer Orders table

INSERT INTO CustomerOrders (CustomerEmail, StaffEmail, OrderDate, ServiceName, Discount, Quantity, OrderPrice)
VALUES ('lucaseb@gmail.com', 'siennajo@gmail.com', '2018-12-09', 'Desktop Clean-up', '15%', '2', '76.50');
INSERT INTO CustomerOrders (CustomerEmail, StaffEmail, OrderDate, ServiceName, Discount, Quantity, OrderPrice)
VALUES ('isobelzl@gmail.com', 'zarast@gmail.com', '2018-12-11', 'Virus Removal', '0%', '3', '165.00');
INSERT INTO CustomerOrders (CustomerEmail, StaffEmail, OrderDate, ServiceName, Discount, Quantity, OrderPrice)
VALUES ('jessicag@hotmail.co.uk', 'jaydenab@gmail.com', '2018-12-13', 'Data Recovery', '10%', '1', '45.00');

-- Deletes a sample of records from the table

DELETE FROM CustomerOrders WHERE CustomerEmail = 'jessicag@hotmail.co.uk';

-- Adds new record to table

INSERT INTO CustomerOrders (CustomerEmail, StaffEmail, OrderDate, ServiceName, Discount, Quantity, OrderPrice)
VALUES ('jessicag@hotmail.co.uk', 'zarast@gmail.com', '2018-12-14', 'Hardware Upgrade', '20%', '2', '48.00');

-- Updates existing record with new data

UPDATE Customers
SET HouseNumber = '270', PostCode = 'LN2 4PX', City = 'Lincoln'
WHERE CustomerEmail = 'isobelzl@gmail.com';

-- 1.2 ii)

-- Inner join statement which displays customer orders by order date, along with the last name of the customer and their e-mail address

SELECT CustomerOrders.OrderDate, Customers.CustomerLastName
FROM CustomerOrders
INNER JOIN Customers ON CustomerOrders.CustomerEmail = Customers.CustomerEmail;

-- Right join statement which displays customer orders by order date and customer email, along with details of the member of staff responsible for the order

SELECT CustomerOrders.CustomerEmail, CustomerOrders.OrderDate, Staff.StaffFirstName, Staff.StaffLastName
FROM CustomerOrders
RIGHT JOIN Staff ON CustomerOrders.StaffEmail = Staff.StaffEmail
ORDER BY CustomerOrders.CustomerEmail, CustomerOrders.OrderDate;

-- Left join statement which displays the different service types and names, along with any corresponding customer orders, with the customer email

SELECT Services.ServiceType, Services.ServiceName, CustomerOrders.OrderDate, CustomerOrders.CustomerEmail
FROM Services
LEFT JOIN CustomerOrders ON Services.ServiceName = CustomerOrders.ServiceName
ORDER BY Services.ServiceType;

-- 1.2 iii)

-- Union statement which displays email contact info for both customers, and staff

SELECT StaffEmail FROM Staff
UNION
SELECT CustomerEmail FROM Customers
ORDER BY StaffEmail;

-- 1.2 iv)

-- Creates a copy of the staff table, along with its constraints

CREATE TABLE copy_of_Staff LIKE Staff;
    
-- Creates a copy of the staff qualifications table    

CREATE TABLE copy_of_StaffQualifications LIKE StaffQualifications;

-- Creates a copy of the customer table

CREATE TABLE copy_of_Customers LIKE Customers;
    
-- Creates a copy of the services table

CREATE TABLE copy_of_Services LIKE Services;

-- Creates a copy of the customer orders table
    
CREATE TABLE copy_of_CustomerOrders LIKE CustomerOrders;

-- Copies data from staff table into copy

INSERT INTO copy_of_Staff
SELECT * FROM Staff;

-- Copies data from staff qualifications table into copy

INSERT INTO copy_of_StaffQualifications
SELECT * FROM StaffQualifications;

-- Copies data from customers table into copy

INSERT INTO copy_of_Customers
SELECT * FROM Customers;

-- Copies data from staff services table into copy

INSERT INTO copy_of_Services
SELECT * FROM Services;

-- Copies data from customer orders table into copy

INSERT INTO copy_of_CustomerOrders
SELECT * FROM CustomerOrders;

-- 1.2 v)

-- Creates new user with read permissions

DROP USER 'new_user'@'localhost';
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
GRANT SELECT ON LincolnComputerSurgery.* TO 'new_user'@'localhost';
