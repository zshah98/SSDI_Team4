CREATE TABLE hotel
(
 hotel_name VARCHAR (25),
 hotel_id INT (4) PRIMARY KEY,
 hotel_address VARCHAR(25),
 Event_id VARCHAR(25),
 room_id VARCHAR(25)
 );

INSERT INTO hotel 
VALUES
( 'Hilton', 2001, '123 UNCC BLD Charlotte NC', '0006','01,02,03'),
( 'Days Inn', 2002, '124 UNCC BLD Charlotte NC', '0001','04,05,06'),
('Stay In', 2003, '123 UNCC BLD Charlotte NC', '0007','07,08,09');
CREATE TABLE event
(
 event_name VARCHAR (25),
 event_id VARCHAR (4) PRIMARY KEY,
 event_times VARCHAR(25),
 hotel_id int(25)
 );
 VALUES
( 'Ladies Night','0006', '10 am to 12pm MWF ',2001),
( 'Karaoke Night', '0001', '10 am to 12pm MWF',2002),
('Cookout','0007', 'TF 7:00pm to 12:00am',2003);
 CREATE TABLE room
 (
 hotel_id int(25),
 room_id VARCHAR(25) PRIMARY KEY,
 room_floor int(25),
 room_type VARCHAR (25),
 roomAvailableFlag VARCHAR (25),
 roomPrice VARCHAR(25);
 no_of_beds int(25)
 );



CREATE TABLE book(
booking_id int(25) PRIMARY KEY,
room_id VARCHAR(25) ,
users_nameFirst VARCHAR (25),
users_email VARCHAR (25)

);
CREATE TABLE Payment(
booking_id int(25),
payment_id int(25) PRIMARY KEY,
payment_date DATETIME

);

create table Billing_details (
user_id int primary key auto_increment,
add_line1 varchar(25),
add_line2 varchar(25),
city varchar(25),
pincode int,
state varchar(25)
);

create table Payment_details(
user_id INT primary key auto_increment,
user_name varchar(25),
card_no double NOT NULL,
ccv int NOT NULL
);