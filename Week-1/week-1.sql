DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS bank_details;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS hotels;


CREATE TABLE customers (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  email     VARCHAR(120) NOT NULL,
  address   VARCHAR(120),
  city      VARCHAR(30),
  postcode  VARCHAR(12),
  country   VARCHAR(20)
);

    
CREATE TABLE hotels (
  id        	SERIAL PRIMARY KEY,
  name      	VARCHAR(30) NOT NULL,
  rooms    		INT NOT NULL,
  postcode      VARCHAR(30) NOT NULL
);

    
 CREATE TABLE rooms (
  id        		SERIAL PRIMARY KEY,
  hotel_id 			INT REFERENCES hotels(id),
  is_available		boolean NOT null,
  price_per_night 	INT NOT NULL
);

 CREATE TABLE bank_details (
  id        	SERIAL PRIMARY KEY,
  customer_id 	INT REFERENCES customers(id),
  bank_name  	VARCHAR(30) NOT null,
  iban_code  	VARCHAR(30) NOT null
);


 CREATE TABLE bookings (
  id        	SERIAL PRIMARY KEY,
  customer_id 	INT REFERENCES customers(id),
  hotel_id		INT REFERENCES hotels(id),
  check_in_date DATE NOT null,
  nights 		INT NOT null
);

-- inserting the customer table
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('John Smith','j.smith@johnsmith.org','11 New Road','Liverpool','L10 2AB','UK');

-- Inserting the hotels table
INSERT INTO hotels (name, rooms, postcode) VALUES ('Triple Point Hotel', 10, 'CM194JS');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Royal Cosmos Hotel', 5, 'TR209AX');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Pacific Petal Motel', 15, 'BN180TG');

-- Inserting the bookings table
INSERT INTO bookings (customer_id, hotel_id, check_in_date, nights) VALUES (1, 1, '2019-10-01', 2);

-- receving all the data from tables
SELECT * FROM customers;
SELECT * FROM hotels;
SELECT * from bookings;

-- retrieve only name and address from coustomers table
SELECT name,address FROM customers;

-- retrieve all hotels having more than 7 rooms
select * from hotels where rooms > 7;

-- retrieve the customer name and address with id 1
select  * from customers where id = 1 ;

-- retrieve all the bookings starting after 2019/10/01
-- retrieve all the bookings starting after 2019/10/01 for a minimum of 2 nights
select  * from bookings where check_in_date > '2019/10/01' and nights >= 2;
