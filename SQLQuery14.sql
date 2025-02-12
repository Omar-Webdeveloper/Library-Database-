--Step 2: Create the database and the tables using SQL-Server and after that insert  
--             at least 5 records in each table.

Create DataBase Library_Mangment_System;

USE Library_Mangment_System;
Create table Books(
ID int Primary Key IDENTITY(1,1),
Title varchar(255),
Author varchar(255),
Genre varchar(255),
Publication_Year datetime,
Availability_Status varchar(255),
Category_ID int,
CONSTRAINT FK_Books_Categories FOREIGN KEY (Category_ID) REFERENCES Categories(ID)
);

Create table Members(
ID int Primary Key IDENTITY(1,1),
Member_Name varchar(255),
Contact_Information varchar(255),
Membership_Type varchar(255),
Registration_Date datetime,
Staff_ID int,
CONSTRAINT FK_Members_Library_staff FOREIGN KEY (Staff_ID) REFERENCES Library_staff(ID)
);

Create table Library_staff(
ID int Primary Key IDENTITY(1,1),
staff_Name varchar(255),
Contact_Info varchar(255),
Assigned_Section varchar(255)
);

Create table Members_Booking(
ID int Primary Key IDENTITY(1,1),
Borrowing_date datetime,
due_date datetime,
return_date datetime,
Books_ID int,
Members_ID int,
CONSTRAINT FK_1_Members_Booking FOREIGN KEY (Books_ID) REFERENCES Books(ID) on delete set null,
CONSTRAINT FK_2_Members_Booking FOREIGN KEY (Members_ID) REFERENCES Members(ID) on delete set null
);

Create table Resevations(
ID int Primary Key IDENTITY(1,1),
Reservation_Date datetime,
Resevations_Status  varchar(255),
Books_ID int,
Members_ID int,
CONSTRAINT FK_1_Resevations FOREIGN KEY (Books_ID) REFERENCES Books(ID) on delete set null,
CONSTRAINT FK_2_Resevations FOREIGN KEY (Members_ID) REFERENCES Members(ID) on delete set null
);

Create table Categories(
ID int Primary Key IDENTITY(1,1),
Category_Name  varchar(255),
Category_Description  varchar(255)
);

Create table Financial_fines (
ID int Primary Key IDENTITY(1,1),
Amount decimal,
Payment_Status  varchar(255),
Borrowing_ID int,
CONSTRAINT FK_Financial_fines FOREIGN KEY (Borrowing_ID) REFERENCES Members_Booking(ID) on delete set null,
);

SELECT * FROM Books;
SELECT * FROM Members;
SELECT * FROM Library_staff;
SELECT * FROM Members_Booking;
SELECT * FROM Resevations;
SELECT * FROM Categories;
SELECT * FROM Financial_fines;



-- Insert into Books table
INSERT INTO Books (Title, Author, Genre, Publication_Year, Availability_Status, Category_ID) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 'Classic', '1925-04-10', 'Available', 1),
('1984', 'George Orwell', 'Dystopian', '1949-06-08', 'Checked Out', 2),
('To Kill a Mockingbird', 'Harper Lee', 'Historical Fiction', '1960-07-11', 'Available', 3),
('The Catcher in the Rye', 'J.D. Salinger', 'Classic', '1951-07-16', 'Available', NULL),
('Pride and Prejudice', 'Jane Austen', 'Romance', '1813-01-28', 'Checked Out', 2),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', '1937-09-21', 'Available', 4);

-- Insert into Members table
INSERT INTO Members (Member_Name, Contact_Information, Membership_Type, Registration_Date, Staff_ID) VALUES
('John Doe', 'john.doe@example.com', 'Regular', '2023-01-15', 1),
('Jane Smith', 'jane.smith@example.com', 'Premium', '2022-11-25', 2),
('Alice Johnson', 'alice.johnson@example.com', 'Regular', '2021-06-30', 3),
('Bob Brown', 'bob.brown@example.com', 'Premium', '2023-02-05', NULL),
('Charlie White', 'charlie.white@example.com', 'Regular', '2023-03-10', 1),
('Diana Green', 'diana.green@example.com', 'Regular', '2021-09-20', 2);

-- Insert into Library_staff table
INSERT INTO Library_staff (staff_Name, Contact_Info, Assigned_Section) VALUES
('Emma Wilson', 'emma.wilson@example.com', 'Fiction'),
('Liam Thompson', 'liam.thompson@example.com', 'Non-Fiction'),
('Olivia Martinez', 'olivia.martinez@example.com', 'Childrens Books'),
('Noah Anderson', 'noah.anderson@example.com', 'Reference'),
('Ava Thomas', 'ava.thomas@example.com', 'Archives'),
('Mason Lewis', 'mason.lewis@example.com', 'Technology');

-- Insert into Members_Booking table
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2023-01-10', '2023-02-10', '2023-02-08', 1, 1),
('2023-02-15', '2023-03-15', '2023-03-10', 2, 2),
('2023-03-01', '2023-04-01', NULL, 3, 3),
('2023-01-20', '2023-02-20', '2023-02-18', 4, 4),
('2023-03-05', '2023-04-05', NULL, 5, 5),
('2023-01-25', '2023-02-25', NULL, 6, 6);
-- Insert borrowings for a book with ID 1
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2023-01-10', '2023-02-10', '2023-02-08', 1, 1),
('2023-02-15', '2023-03-15', '2023-03-10', 1, 2),
('2023-03-01', '2023-04-01', '2023-03-30', 1, 3),
('2023-04-05', '2023-05-05', '2023-05-03', 1, 4);
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2023-01-10', '2023-02-10', '2023-02-20', 1, 1);
-- Insert borrowings for books between January 1, 2024, and January 10, 2024
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2024-01-05', '2024-02-05', '2024-02-03', 2, 3),
('2024-01-08', '2024-02-08', '2024-02-06', 4, 5);

-- Insert into Resevations table
INSERT INTO Resevations (Reservation_Date, Resevations_Status, Books_ID, Members_ID) VALUES
('2023-01-12', 'Pending', 1, 2),
('2023-02-18', 'Confirmed', 3, 4),
('2023-03-06', 'Cancelled', 5, 1),
('2023-01-30', 'Pending', 2, 5),
('2023-03-07', 'Confirmed', 4, 3),
('2023-01-22', 'Pending', 6, 6);

-- Insert into Categories table
INSERT INTO Categories (Category_Name, Category_Description) VALUES
('Classic', 'Classic literature from various periods'),
('Dystopian', 'Stories set in a dystopian future'),
('Historical Fiction', 'Fictional stories set in historical times'),
('Romance', 'Love stories with emotional and dramatic content'),
('Fantasy', 'Fantasy novels with magical elements'),
('Science Fiction', 'Stories exploring futuristic technology and space exploration');

-- Insert into Financial_fines table
INSERT INTO Financial_fines (Amount, Payment_Status, Borrowing_ID) VALUES
(5.00, 'Unpaid', 1),
(10.00, 'Paid', 2),
(3.00, 'Unpaid', 3),
(7.50, 'Paid', 4),
(2.50, 'Unpaid', 5),
(6.00, 'Paid', 6);
INSERT INTO Members (Member_Name, Contact_Information, Membership_Type, Registration_Date, Staff_ID) VALUES
('New Member', 'new.member@example.com', 'Regular', '2025-01-01', 1);
INSERT INTO Books (Title, Author, Genre, Publication_Year, Availability_Status, Category_ID) VALUES
('Database Fundamentals', 'John Smith', 'Technology', '2021-05-15', 'Available', 5);
-- Insert borrowing for the book "SQL for Beginners"
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2024-01-12', '2024-02-12', '2024-02-10', 8, 2);
INSERT INTO Books (Title, Author, Genre, Publication_Year, Availability_Status, Category_ID) VALUES
('SQL for Beginners', 'Jane Doe', 'Technology', '2023-08-10', 'Available', 5);
INSERT INTO Books (Title, Author, Genre, Publication_Year, Availability_Status, Category_ID) VALUES
('C# Programming', 'Alex Johnson', 'Technology', '2022-09-15', 'Available', 5);

-- Insert borrowing for the book "C# Programming"
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2024-01-15', '2024-02-15', '2024-02-13', 9, 2);
INSERT INTO Books (Title, Author, Genre, Publication_Year, Availability_Status, Category_ID) VALUES
('Dune', 'Frank Herbert', 'Science Fiction', '1965-08-01', 'Available', 6);
-- Insert borrowing for the book "Dune"
INSERT INTO Members_Booking (Borrowing_date, due_date, return_date, Books_ID, Members_ID) VALUES
('2024-01-18', '2024-02-18', '2024-02-16', 10, 3);  -- Assuming the ID for "Dune" is 10

--Step 3: Write the following queries:

--1. Select members who registered on a specific date
--👉 Question:
--Write an SQL query to find all members who registered on 1-1-2025.

select * from Members where Registration_Date ='1-1-2025';

--2. Select details of a book by its title
--👉 Question:
--Write an SQL query to retrieve all details of a book titled "Database Fundamentals".
select * from Books Where Title = 'Database Fundamentals'; 

--3. Add a new column ‘Email’ to the Members table
--👉 Question:
--The Members table is missing an Email column. Write an SQL query to add an Email column with a data type suitable for storing email addresses.
Alter table Members Add Email varchar(255);


--4. Insert a new member record
--👉 Question:
--Write an SQL query to insert a new member with the following details:

--Name: Omar
--Contact: 9876543210
--Membership Type: Student
--Registration Date: 5-6-2024
--Email: Omar@gmail.com

insert into Members (Member_Name, Contact_Information, Membership_Type, Registration_Date, Staff_ID, Email ) 
VALUES ('Omar Abo Jolban','9876543210','Student','2024-06-05',null,'Omar@gmail.com');
 

--5. Select members who have reservations in the system
--👉 Question:
--Write an SQL query to find all members who have made a book reservation.

Select * 
From Members 
INNER JOIN Resevations on Members.ID = Resevations.Members_ID
INNER JOIN Books on Resevations.Books_ID = Books.ID
where Resevations.Members_ID  IS NOT NULL and Resevations.Books_ID  IS NOT NULL ;

--6. Select members who have borrowed a specific book
--👉 Question:
--Write an SQL query to find members who have borrowed the book titled "SQL for Beginners".

Select * 
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
Where Books.Title = 'SQL for Beginners';



--7. Select members who have borrowed and returned a specific book
--👉 Question:
--Write an SQL query to find all members who have borrowed and returned the book titled "C# Programming".
Select * 
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
Where Books.Title = 'C# Programming' and Members_Booking.Members_ID  IS NOT NULL and Members_Booking.Books_ID  IS NOT NULL 
and Members_Booking.Borrowing_date  IS NOT NULL and Members_Booking.return_date  IS NOT NULL and Members_Booking.due_date  IS NOT NULL ;



--8. Find members who made a late return
--👉 Question:
--Write an SQL query to find members who have returned books after the due date.
Select * 
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
Where Members_Booking.Members_ID  IS NOT NULL and Members_Booking.Books_ID  IS NOT NULL 
and Members_Booking.Borrowing_date  IS NOT NULL and Members_Booking.return_date  IS NOT NULL and Members_Booking.due_date  IS NOT NULL 
and Members_Booking.return_date > Members_Booking.due_date;



--9. Select books borrowed more than 3 times
--👉 Question:
--Write an SQL query to find books that have been borrowed more than 3 times.
select Books.Title ,count(*) as three_Books
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
group by Books.Title 
having  count(*) > 3;


--10. Find members who have borrowed books between two dates
--👉 Question:
--Write an SQL query to find members who have borrowed a book between January 1, 2024, and January 10, 2024.
Select * 
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
where Members_Booking.Borrowing_date between '2024-01-01'and '2024-01-10';

--11. Count the total number of books in the library
--👉 Question:
--Write an SQL query to count the total number of books available in the library.
Select Count(*) AS books_available_in_the_library
From Books 
where Books.Availability_Status = 'Available';

--12. (Optional)Find members who have borrowed books but not returned them
--👉 Question:
--Write an SQL query to find members who have borrowed books but not returned them yet.
Select * 
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
where Members_Booking.return_date is null and Members_Booking.Borrowing_date is not null;



--13. (Optional)Find members who have borrowed books in a specific category
--👉 Question:
--Write an SQL query to find members who have borrowed a book from the "Science Fiction" category.
Select * 
From Members 
INNER JOIN Members_Booking on Members.ID = Members_Booking.Members_ID
INNER JOIN Books on Members_Booking.Books_ID = Books.ID
INNER JOIN Categories on Categories.ID = Books.Category_ID
where Categories.Category_Name ='Science Fiction';
