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
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  country     VARCHAR(30) NOT NULL,
  city      VARCHAR(30) NOT NULL
);

    
 CREATE TABLE rooms (
  id        SERIAL PRIMARY KEY,
  hotel_id INT REFERENCES hotels(id),
  is_available boolean NOT null,
  price_per_night INT NOT NULL
);

 CREATE TABLE bank_details (
  id        SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id),
  bank_name  VARCHAR(30) NOT null,
  iban_code  VARCHAR(30) NOT null
);


 CREATE TABLE bookings (
  id        SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id),
  room_id INT REFERENCES rooms(id),
  check_in_date DATE NOT null,
  number_of_nights INT NOT null
);

insert into hotels ( name, country, city ) values ( 'H Hotel', 'Spain', 'Barcelona' );
insert into hotels ( name, country, city ) values ( 'Eduard Hotels', 'Spain', 'Barcelona' );

