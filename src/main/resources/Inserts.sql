insert into book(booking_id, hotel_id, room_id,users_id)
values('C13', 2005, 'F3', 1000),
('C14', 2005, 'S3', 1001),
('C15', 2004, 'F1', 1002),
('C16', 2004, 'S1', 1002);

insert into hotel
values(2004, "Mariott", "125 UNCC BLD Charlotte NC"),
(2005, "Candelwood", "Charlotte NC");

insert into room
values(2004, 'F1', 1, 'AC', 1, '$500', 2),
(2004, 'S1', 2, 'AC', 1, '$550', 2),
(2005, 'F3', 1, 'AC', 1, '$400', 2),
(2005, 'S3', 2, 'Non-AC', 1, '$350', 2);

insert into payment
values('C13', 125, now()),
('C14', 126, now()),
('C15', 127, now()),
('C16', 128, now());