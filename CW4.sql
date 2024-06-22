CREATE DATABASE HotelManagementSystem;

CREATE TABLE Rooms(
RoomID INT PRIMARY KEY,
RoomType VARCHAR(50) NOT NULL,
Capacity INT NOT NULL CHECK(Capacity>0),
Price DECIMAL(10,2) NOT NULL
);


CREATE TABLE Customers(
CustomerID INT PRIMARY KEY,
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
Email VARCHAR(100) NOT NULL UNIQUE,
Phone VARCHAR(20) NOT NULL
);

CREATE TABLE Bookings(
BookingID INT PRIMARY KEY,
RoomID INT,
CustomerID INT,
CheckINDate DATE NOT NULL,
CheckOutDate DATE NOT NULL,
FOREIGN KEY(RoomID)REFERENCES Rooms(RoomID),
FOREIGN KEY(CustomerID)REFERENCES Customers(CustomerID)
);


CREATE TABLE Service(
ServiceID INT PRIMARY KEY,
ServiceName VARCHAR(100) NOT NULL,
Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Payments(
PaymentID INT PRIMARY KEY,
BookingID INT,
Amount DECIMAL(10,2) NOT NULL,
PaymentDate DATE NOT NULL,
FOREIGN KEY(BookingID)REFERENCES Bookings(BookingID)
);


INSERT INTO Rooms(RoomID,RoomType,Capacity,Price) VALUES
(1,'Single',1,15000.00),
(2,'Double',2,35000.00),
(3,'Suite',4,65000.00),
(4,'Twin',2,55000.00),
(5,'Single',1,15000.00),
(6,'Double',2,35000.00),
(7,'Suite',4,65000.00),
(8,'Twin',2,55000.00),
(9,'Single',1,15000.00),
(10,'Double',2,35000.00);

INSERT INTO Customers(CustomerID,FirstName,LastName,Email,Phone)VALUES
(1,'John','Doe','john@gmail.com','0124567891'),
(2,'Jane','Smith','jane@gmail.com','3214567892'),
(3,'Alice','Johnson','alice@gmail.com','2546378924'),
(4,'Bob','Brown','bob@gmail.com','4867952346'),
(5,'Emma','Davis','emma@gmai.com','3456287654'),
(6,'Michael','Wilson','michael@gmail.com','9542367854'),
(7,'Olivia','Martinez','olivia@gmail.com','5648246357'),
(8,'James','Taylor','james@gmail.com','6435216785'),
(9,'Sophia','Lee','sophia@gmail.com','3462578621'),
(10,'William','Clark','william@gmail.com','7624358961');


INSERT INTO Bookings(BookingID,RoomID,CustomerID,CheckINDate,CheckOutDate) VALUES
(1,1,1,'2024-03-01','2024-03-05'),
(2,2,2,'2024-03-02','2024-03-06'),
(3,3,3,'2024-03-03','2024-03-07'),
(4,4,4,'2024-03-04','2024-03-08'),
(5,5,5,'2024-03-05','2024-03-09'),
(6,6,6,'2024-03-06','2024-03-10'),
(7,7,7,'2024-03-07','2024-03-11'),
(8,8,8,'2024-03-08','2024-03-12'),
(9,9,9,'2024-03-09','2024-03-13'),
(10,10,10,'2024-03-10','2024-03-14');


INSERT INTO Service(ServiceID,ServiceName,Price) VALUES
(1,'Breakfast',15000.00),
(2,'WiFi',5000.00),
(3,'Laundry',2000.00),
(4,'Room Cleaning',5500.00),
(5,'Parking',500.00),
(6,'Gym Access',500.00),
(7,'Dinner',15000.00),
(8,'Mini bar',1000.00),
(9,'Spa',15000.00),
(10,'Lunch',15000.00);

INSERT INTO Payments(PaymentID,BookingID,Amount,PaymentDate)VALUES
(1,1,50000.00,'2024-03-05'),
(2,2,45000.00,'2024-03-06'),
(3,3,58000.00,'2024-03-07'),
(4,4,44000.00,'2024-03-08'),
(5,5,62000.00,'2024-03-09'),
(6,6,48000.00,'2024-03-10'),
(7,7,54000.00,'2024-03-11'),
(8,8,65000.00,'2024-03-12'),
(9,9,63000.00,'2024-03-13'),
(10,10,49000.00,'2024-03-14');


--1) Retrive all bookings where check-in-date is after march 1 2024--
SELECT * FROM Bookings WHERE CheckINDate >'2024-03-01';

--2)Retrieve all customers with email address endig in '.com'
SELECT * FROM Customers WHERE Email LIKE '%.com';

--3)Retrieve all rooms with a capacity greater than 2--
SELECT * FROM Rooms WHERE Capacity>2;

--4)Retrieve all payments where the amount is greater than or equal to 1000
SELECT * FROM Payments WHERE Amount>=1000;

--5)Count the number of bookings for each room--
SELECT RoomID,COUNT(*) AS Numbookings 
FROM Bookings GROUP BY RoomID; 

--6)Calculate the total amount paid for each booking--
SELECT BookingID, SUM(Amount) AS TotalAmount
FROM Payments GROUP BY BookingID;

--7)Count the number of bookings for each room and display those with more than 3 bookings--
SELECT RoomID,COUNT(*) as NumBookings FROM Bookings
GROUP BY RoomID HAVING COUNT(*)>3;

--8)Calculate the total amount paid for booking and display only with total amount greater than 500--
SELECT BookingID, SUM(Amount) AS TotalAmount 
FROM Payments GROUP BY BookingID HAVING SUM(Amount)>500;

--9)Retrieve all rooms ordered by price in descending order--
SELECT * FROM Rooms ORDER BY Price DESC;

--10)Retrieve allcustomers ordered by last name in ascending order--
SELECT * FROM Customers ORDER BY LastName ASC;

--11)Retrieve all bookings for rooms with a capacity greater than 2, ordered by checkindate
SELECT*FROM Bookings b
INNER JOIN Rooms r ON b.RoomID=r.RoomID
WHERE r.Capacity>2
ORDER BY b.CheckINDate;

--12)Count the number of bookings for each room,display only those with more than 1 booking and order by the number bookings in descending order 
SELECT RoomID,COUNT(*) AS NumBookings
FROM Bookings
GROUP BY RoomID
HAVING COUNT(*)>1
ORDER BY NumBookings DESC;

--13)Retrieve all customers whose first name is john
SELECT * FROM Customers WHERE FirstName='John';

--14)Retrieve all bookings where checkoutdate is before march 10 2024
SELECT*FROM Bookings WHERE CheckOutDate<'2024-03-10';

--15)Count the number of bookings made by each customer
SELECT CustomerID,COUNT(*) AS NumBookings
FROM Bookings GROUP BY CustomerID;

--16)Calculate the total amount paid for each booking and display total amount greater than 2000
SELECT BookingID, SUM(Amount) AS TotalAmount 
FROM Payments GROUP BY BookingID 
HAVING SUM(Amount)>2000;

--17)Count the number of bookings for each room type and display only those with more than 2 bookings
SELECT r.RoomType,COUNT(*) AS Numbookings
FROM Bookings b
JOIN Rooms r ON b.RoomID=r.RoomID
GROUP BY r.RoomType
HAVING COUNT(*)>2;

--18)Calculate the average price of rooms and display with average price greater than 150
SELECT RoomType,AVG(Price) AS AvgPrice FROM Rooms
GROUP BY RoomType HAVING AVG(Price)>150;

--19)Retrieve all payments ordered by payment date is ascending
SELECT*FROM Payments ORDER BY PaymentDate ASC;

--20)Retrieve all customers ordered by length of their last name in descending
SELECT * FROM Customers ORDER BY LEN(LastName) DESC;


--NESTED QUERIES--

--1--
SELECT*FROM Customers
WHERE CustomerID IN
				( SELECT CustomerID 
				FROM Bookings);

--2--
SELECT*FROM Rooms
WHERE RoomID IN 
			( SELECT RoomID FROM Bookings 
			  WHERE BookingID IN 
							(SELECT BookingID FROM Payments));	

--3--
SELECT *FROM Payments 
WHERE BookingID IN 
				(SELECT BookingID FROM Bookings
				 WHERE CustomerID=(SELECT CustomerID FROM Customers 
								   WHERE FirstName='John')); 	

--4--
SELECT * FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Bookings
					 WHERE RoomID IN 
					 (SELECT RoomID FROM Rooms WHERE Capacity=2));


--5--
SELECT DISTINCT RoomType FROM Rooms
WHERE RoomID IN(SELECT RoomID FROM Bookings
				WHERE CustomerID IN
				(SELECT CustomerID FROM Customers 
				WHERE Email LIKE '%.com'));


--6--
SELECT SUM(Amount)AS TotalPayment
FROM Payments WHERE BookingID IN
	(SELECT BookingID FROM Bookings WHERE RoomID IN
	(SELECT RoomID FROM Rooms WHERE RoomType='Suite'));


--7--
SELECT * FROM Bookings 
WHERE CheckINDate>'2024-03-05'AND RoomID IN
		(SELECT RoomID FROM Rooms WHERE Price<25000);


--8--
SELECT * FROM Customers WHERE CustomerID IN
	(SELECT CustomerID FROM Bookings WHERE RoomID IN
		(SELECT RoomID FROM Rooms WHERE Capacity>
			(SELECT AVG(Capacity)FROM Rooms)));


--9--
SELECT * FROM Payments WHERE BookingID IN
	(SELECT BookingID FROM Bookings WHERE RoomID IN
		(SELECT RoomID FROM Rooms WHERE RoomType='Single'));


--10--
SELECT * FROM Customers WHERE CustomerID IN
	(SELECT DISTINCT CustomerID FROM Bookings);



--INNER JOIN--
SELECT Bookings.BookingID,Customers.FirstName,Customers.LastName
FROM Bookings INNER JOIN Customers 
ON Bookings.CustomerID=Customers.CustomerID;


--LEFT JOIN--
SELECT Bookings.BookingID,Customers.FirstName,Customers.LastName
FROM Bookings
LEFT JOIN Customers ON Bookings.CustomerID=Customers.CustomerID;


--RIGHT JOIN--
SELECT Bookings.BookingID,Customers.FirstName,Customers.LastName
FROM Bookings
FULL OUTER JOIN Customers ON Bookings.CustomerID=Customers.CustomerID;


--FULLOUTER JOIN--
SELECT Bookings.BookingID,Customers.FirstName,Customers.LastName
FROM Bookings
FULL OUTER JOIN Customers ON 
Bookings.CustomerID=Customers.CustomerID;


SELECT Bookings.BookingID,Rooms.RoomType,Rooms.Price
FROM Bookings
INNER JOIN Rooms ON Bookings.RoomID=Rooms.RoomID;


---QUE6)---
CREATE PROCEDURE GetCustomerByID
AS
BEGIN
	
	SELECT * FROM Customers
	WHERE CustomerID=CustomerID;
END;

EXEC GetCustomerByID;




CREATE PROCEDURE GetRoomByID
AS
BEGIN

	SELECT * FROM Rooms
	WHERE RoomID=RoomID;

END;
EXEC GetRoomByID;






CREATE PROCEDURE GetBookingsByCustomerID
AS
BEGIN

	SELECT * FROM Bookings
	WHERE CustomerID=CustomerID;

END;
EXEC GetBookingsByCustomerID;




CREATE PROCEDURE GetPaymentsByBookingID
AS
BEGIN

	SELECT * FROM Payments
	WHERE BookingID=BookingID;

END;
EXEC GetPaymentsByBookingID;




CREATE PROCEDURE GetServiceByID
AS
BEGIN

	SELECT * FROM Service
	WHERE ServiceID=ServiceID;

END;
EXEC GetServiceByID;

	


---QUE7)---
CREATE VIEW RoomDetailsView
AS
SELECT RoomID,RoomType,Price
FROM Rooms;

SELECT * FROM RoomDetailsView;




CREATE VIEW CustomerDetailsView
AS
SELECT *
FROM Customers;

SELECT * FROM CustomerDetailsView;



CREATE VIEW BookingDetailsView
AS
SELECT *
FROM Bookings;

SELECT * FROM BookingDetailsView;




CREATE VIEW PaymentsDetailsView
AS
SELECT *
FROM Payments;

SELECT * FROM PaymentsDetailsView;



CREATE VIEW ServiceDetailsView
AS
SELECT *
FROM Service;

SELECT * FROM ServiceDetailsView;















---QUE8---

CREATE LOGIN Managers WITH PASSWORD='manager123';

CREATE LOGIN Director WITH PASSWORD='director123';


---QUE9---
CREATE USER Managers FOR LOGIN Managers;

CREATE USER Director FOR LOGIN Director;

CREATE USER Guest FOR LOGIN Guest;

CREATE USER CoDirector FOR LOGIN CoDirector;




GRANT SELECT ON Customers TO Managers;

DENY INSERT ON Bookings TO Director;

GRANT EXECUTE ON GetAllRooms TO Guest;

DENY UPDATE ON Payments TO CoDirector;


---QUE10---

CREATE ROLE Manager;
CREATE ROLE Director;

GRANT SELECT ON Customers TO Manager;
GRANT INSERT ON Rooms TO Director;

ALTER ROLE Manager ADD MEMBER Managers;
ALTER ROLE Director ADD MEMBER CoDirector;


---QUE11---

CREATE CLUSTERED INDEX IX_Customers_FirstName
ON Customers(FirstName);

CREATE CLUSTERED INDEX IX_Rooms_RoomID 
ON Rooms(RoomID);

CREATE CLUSTERED INDEX IX_Bookings_BookingID
ON Bookings(BookingID);

CREATE CLUSTERED INDEX IX_Payments_PaymentID
ON Payments(PaymentID);

CREATE CLUSTERED INDEX IX_Employees_EmployeeID
ON Employees(EmployeeID);



---QUE12---

CREATE NONCLUSTERED INDEX IX_Customers_Email 
ON Customers(Email);

CREATE NONCLUSTERED INDEX IX_Customers_LastName
ON Customers(LastName);


CREATE NONCLUSTERED INDEX IX_Rooms_RoomType
ON Rooms(RoomType);

CREATE NONCLUSTERED INDEX IX_Rooms_Price
ON Rooms(Price);


CREATE NONCLUSTERED INDEX IX_Bookings_CheckINDate
ON Bookings(CheckINDate);

CREATE NONCLUSTERED INDEX IX_Bookings_CheckOutDate
ON Bookings(CheckOutDate);


CREATE NONCLUSTERED INDEX IX_Payments_PaymentAmount
ON Payments(Amount);

CREATE NONCLUSTERED INDEX IX_Payments_PaymentDate
ON Payments(PaymentDate);


CREATE NONCLUSTERED INDEX IX_Service_ServiceName
ON Service(ServiceName);

CREATE NONCLUSTERED INDEX IX_Service_Price
ON Service(Price);


---QUE13---

--Query1--
SELECT * FROM Customers 
WHERE LastName='Smith';

--Query2--
SELECT * FROM Bookings 
WHERE CheckINDate>='2022-01-01'
AND CheckINDate<'2022-02-01';


/*Example Query 1 Execution Plan:

The query optimizer might decide to use an index seek operation on the LastName column since we're filtering based on that column. It will use the index to quickly locate all rows where LastName is 'Smith'.
If there's an index on the LastName column, the execution plan might consist of an Index Seek operation followed by Key Lookup to retrieve the additional columns not covered by the index (if any).
Example Query 2 Execution Plan:

Similarly, the query optimizer might decide to use an index seek operation on the CheckInDate column since we're filtering based on that column.
If there's an index on the CheckInDate column, the execution plan might consist of an Index Seek operation to quickly locate all rows where the CheckInDate falls within the specified range.*/











	  







