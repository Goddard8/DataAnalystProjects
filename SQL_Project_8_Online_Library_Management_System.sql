/* 
=============================================================
PHASE 1 - TASK 1 - Define the Database Schema 
=============================================================
Project Phases and Tasks:
Phase 1: Database Design (DDL)
	Task 1: Define the Database Schema
Description: Create the database schema for the library management system, defining tables and relationships.
Example using AdventureWorksDW2022: Create a 'Library' database and design tables for 'Books,' 'Users,' 'Transactions,' 
'Genres,' etc.
*/


-- CREATING THE LIBRARY DATABASE
-- Check if the 'Library' database exists and drop it if it does
DROP DATABASE IF EXISTS Library; -- Added IF EXISTS to prevent an error if the database doesn't exist

-- Create a new 'Library' database
CREATE DATABASE Library; 

-- Switch to using the 'Library' database for subsequent operations
USE Library;

-- Create the 'GENRES' table
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,         -- Unique identifier for genres
    GenreName NVARCHAR(100) NOT NULL -- Name of the genre, (NOT NULL means cannot be empty)
);

-- Create the 'BOOKS' table
CREATE TABLE Books (
    BookID INT PRIMARY KEY,             -- Unique identifier for books
    Title NVARCHAR(255),               -- Title of the book (NVARCHAR = 255 since book titles can be long)
    Author NVARCHAR(255),              -- Author of the book (NVARCHAR = 255 since book author names can be long)
    PublicationDate NVARCHAR(255),     -- Publication date of the book ( I made this NVARCHAR since there are books with no specific date)
    GenreID INT,                       -- Foreign key referencing the genre of the book
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID) -- Ensure GenreID exists in Genres table
);

-- Create the 'USERS' table 
CREATE TABLE Users (
    UserID INT PRIMARY KEY,            -- Unique identifier for users
    Firstname NVARCHAR(50) NOT NULL,   -- User's first name, shouldnt be empty
    Lastname NVARCHAR(50) NOT NULL,    -- User's last name, should not be empty
    Email NVARCHAR(255),              -- User's email address 
    MembershipDate DATE                -- Date when the user became a member
);

-- Create the 'BorrowedTransaction' table 
CREATE TABLE Borrowed (
    TransactionID INT PRIMARY KEY,     -- Unique identifier for transactions
    UserID INT,                        -- Foreign key referencing the user involved in the transaction
    BookID INT,                        -- Foreign key referencing the book involved in the transaction
    TransactionDate DATETIME,         -- Date and time of the transaction
    DueDate DATETIME,                  -- Due date for returning the book
    TransactionType NVARCHAR(20)       -- Type of transaction (For this table its "borrowing" or "borrowed")
);

-- Create the 'ReturnedTransaction' table 
CREATE TABLE Returned (
    TransactionID INT PRIMARY KEY,     -- Unique identifier for transactions
    UserID INT,                        -- Foreign key referencing the user involved in the transaction
    BookID INT,                        -- Foreign key referencing the book involved in the transaction
    TransactionDate DATETIME,         -- Date and time of the transaction
    TransactionType NVARCHAR(20)       -- Type of transaction (For this table its "returning" or "Returned")
);


/* 
=============================================================
PHASE 1 - TASK 2 - Specify Keys and Constraints
=============================================================
Description: Define primary keys, foreign keys, constraints, and 
relationships between tables.
*/

-- Set up some connections between our tables

-- This part connects the 'Books' table to 'Genres' table using GenreID
ALTER TABLE Books
ADD CONSTRAINT FK_Books_Genres FOREIGN KEY (GenreID)
REFERENCES Genres(GenreID);

-- linking 'Borrowed' table with 'Users' table through UserID
ALTER TABLE Borrowed
ADD CONSTRAINT FK_Borrowed_Users FOREIGN KEY (UserID)
REFERENCES Users(UserID);

-- connecting 'Returned' table with 'Users' table using UserID
ALTER TABLE Returned
ADD CONSTRAINT FK_Returned_Users FOREIGN KEY (UserID)
REFERENCES Users(UserID);

-- linking 'Borrowed' table to 'Books' table through BookID
ALTER TABLE Borrowed
ADD CONSTRAINT FK_Borrowed_Books FOREIGN KEY (BookID)
REFERENCES Books(BookID);

-- linking 'Returned' table to 'Books' table using BookID
ALTER TABLE Returned
ADD CONSTRAINT FK_Returned_Books FOREIGN KEY (BookID)
REFERENCES Books(BookID);





/*========================================================= 
Phase 2: Data Population (DML)
Task 3: Populate the Database with Sample Data
Description: Insert sample data into the database, including books, 
user information, and transactions.

=========================================================*/

--Inserting Genres
INSERT INTO Genres(GenreID,GenreName)
VALUES
    (1, 'Classic Literature'),
    (2, 'Southern Gothic'),
    (3, 'Adventure'),
    (4, 'Fantasy'),
    (5, 'Dystopian'),
    (6, 'Horror'),
    (7, 'Mystery'),
    (8, 'Science Fiction'),
    (9, 'Fiction'),
    (10, 'Historical Fiction'),
    (11, 'Epic Poetry'),
    (12, 'Diary'),
    (13, 'Self-Help'),
    (14, 'Finance'),
    (15, 'Military Strategy');


-- Inserting Book Records
INSERT INTO Books (BookID, Title, Author, GenreID, PublicationDate)
VALUES
    (1, 'The Great Gatsby', 'F. Scott Fitzgerald', 1, '1925-04-10'),
    (2, 'To Kill A Mockingbird', 'Harper Lee', 2, '1960-07-11'),
    (3, 'Moby-Dick', 'Herman Melville', 3, '1851-10-18'),
    (4, 'The Hobbit', 'J.R.R. Tolkien', 4, '1937-09-21'),
    (5, 'The Hunger Games', 'Suzanne Collins', 5, '2008-09-14'),
    (6, 'Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 4, '1997-06-26'),
    (7, 'The Lord of the Rings', 'J.R.R. Tolkien', 4, '1954-10-29'),
    (8, 'The Shining', 'Stephen King', 6, '1977-01-28'),
    (9, 'The Da Vinci Code', 'Dan Brown', 7, '2003-04-18'),
    (10, 'The Hitchhiker''s Guide to the Galaxy', 'Douglas Adams', 8, '1979-10-12'),
    (11, 'The Alchemist', 'Paulo Coelho', 9, '1988-06-16'),
    (12, 'War and Peace', 'Leo Tolstoy', 10, '1869-12-11'),
    (13, 'The Odyssey', 'Homer', 11, '8th century BC'),
    (14, 'The Diary of Anne Frank', 'Anne Frank', 12, '1947-06-25'),
    (15, '12 Rules for Life', 'Jordan Peterson', 13, '2018-01-23'),
    (16, 'The Power of Now', 'Eckhart Tolle', 13, '1997-10-10'),
    (17, 'Becoming Supernatural', 'Dr. Joe Dispenza', 13, '2017-09-26'),
    (18, 'Trade Like a Stock Market Wizard', 'Mark Minervini', 14, '2013-11-12'),
    (19, 'Awaken the Giant Within', 'Tony Robbins', 13, '1991-10-14'),
    (20, 'You are the Placebo', 'Dr. Joe Dispenza', 13, '2014-09-23'),
    (21, 'The Art of War', 'Sun Tzu', 15, '5th century BC');


-- Inserting User Records
INSERT INTO Users (UserID, Firstname, Lastname, Email, MembershipDate)
VALUES
    (1, 'Abraham Jr.', 'Avila', 'absavila@DSA.com', '2023-05-05'),
    (2, 'Jason', 'Peñalosa', 'PhBI@DSA.com', '2023-06-20'),
    (3, 'Lebron', 'James', 'kingjames@DSA.com', '2023-07-15'),
    (4, 'Liza', 'Soberano', 'Liza.Soberano@DSA.com', '2023-08-10'),
    (5, 'Daniel', 'Padilla', 'Daniel.Padilla@DSA.com', '2023-09-05'),
    (6, 'Manny', 'Pacquiao', 'mannypac@DSA.com', '2023-09-10'), 
    (7, 'Sarah', 'Geronimo', 'sarahg@DSA.com', '2023-09-15'),   
    (8, 'Alden', 'Richards', 'alden@DSA.com', '2023-09-20'),   
    (9, 'Kathryn', 'Bernardo', 'kathryn@DSA.com', '2023-09-25'), 
    (10, 'Coco', 'Martin', 'coco@DSA.com', '2023-09-30');      


-- Inserting "Borrowed" transaction records
INSERT INTO Borrowed(TransactionID, UserID, BookID, TransactionDate, DueDate, TransactionType)
VALUES
    (1, 1, 3, '2023-04-05 09:30:00', DATEADD(DAY, 7, '2023-04-05 09:30:00'), 'Borrow'),
    (2, 2, 17, '2023-04-10 14:15:00', DATEADD(DAY, 7, '2023-04-10 14:15:00'), 'Borrow'),
    (3, 1, 9, '2023-04-12 11:45:00', DATEADD(DAY, 7, '2023-04-12 11:45:00'), 'Borrow'),
    (4, 3, 2, '2023-04-15 10:30:00', DATEADD(DAY, 7, '2023-04-15 10:30:00'), 'Borrow'),
    (5, 4, 6, '2023-04-20 16:45:00', DATEADD(DAY, 7, '2023-04-20 16:45:00'), 'Borrow'),
    (6, 3, 14, '2023-04-22 09:15:00', DATEADD(DAY, 7, '2023-04-22 09:15:00'), 'Borrow'),
    (7, 1, 19, '2023-04-25 13:00:00', DATEADD(DAY, 7, '2023-04-25 13:00:00'), 'Borrow'),
    (8, 2, 5, '2023-04-30 11:00:00', DATEADD(DAY, 7, '2023-04-30 11:00:00'), 'Borrow'),
    (9, 3, 12, '2023-05-05 14:30:00', DATEADD(DAY, 7, '2023-05-05 14:30:00'), 'Borrow'),
    (10, 4, 20, '2023-05-10 09:45:00', DATEADD(DAY, 7, '2023-05-10 09:45:00'), 'Borrow'),
    (11, 5, 7, '2023-05-15 16:20:00', DATEADD(DAY, 7, '2023-05-15 16:20:00'), 'Borrow'),
    (12, 6, 16, '2023-05-20 10:15:00', DATEADD(DAY, 7, '2023-05-20 10:15:00'), 'Borrow'),
    (13, 7, 1, '2023-05-25 12:45:00', DATEADD(DAY, 7, '2023-05-25 12:45:00'), 'Borrow'),
    (14, 8, 10, '2023-05-30 08:00:00', DATEADD(DAY, 7, '2023-05-30 08:00:00'), 'Borrow'),
    (15, 9, 8, '2023-06-05 15:30:00', DATEADD(DAY, 7, '2023-06-05 15:30:00'), 'Borrow'),
    (16, 10, 11, '2023-06-10 10:00:00', DATEADD(DAY, 7, '2023-06-10 10:00:00'), 'Borrow'),
    (17, 1, 13, '2023-06-15 09:30:00', DATEADD(DAY, 7, '2023-06-15 09:30:00'), 'Borrow'),
    (18, 2, 18, '2023-06-20 14:15:00', DATEADD(DAY, 7, '2023-06-20 14:15:00'), 'Borrow'),
    (19, 4, 4, '2023-06-25 11:45:00', DATEADD(DAY, 7, '2023-06-25 11:45:00'), 'Borrow'),
    (20, 6, 15, '2023-07-01 10:30:00', DATEADD(DAY, 7, '2023-07-01 10:30:00'), 'Borrow'),
    (21, 7, 20, '2023-07-05 16:45:00', DATEADD(DAY, 7, '2023-07-05 16:45:00'), 'Borrow'),
    (22, 8, 3, '2023-07-10 09:15:00', DATEADD(DAY, 7, '2023-07-10 09:15:00'), 'Borrow'),
    (23, 9, 14, '2023-07-15 13:00:00', DATEADD(DAY, 7, '2023-07-15 13:00:00'), 'Borrow'),
    (24, 10, 19, '2023-07-20 11:00:00', DATEADD(DAY, 7, '2023-07-20 11:00:00'), 'Borrow'),
    (25, 1, 5, '2023-07-25 09:30:00', DATEADD(DAY, 7, '2023-07-25 09:30:00'), 'Borrow'),
    (26, 2, 9, '2023-07-30 14:15:00', DATEADD(DAY, 7, '2023-07-30 14:15:00'), 'Borrow'),
    (27, 4, 12, '2023-08-05 11:45:00', DATEADD(DAY, 7, '2023-08-05 11:45:00'), 'Borrow'),
    (28, 6, 16, '2023-08-10 10:30:00', DATEADD(DAY, 7, '2023-08-10 10:30:00'), 'Borrow'),
    (29, 7, 2, '2023-08-15 16:45:00', DATEADD(DAY, 7, '2023-08-15 16:45:00'), 'Borrow'),
    (30, 8, 6, '2023-08-20 09:15:00', DATEADD(DAY, 7, '2023-08-20 09:15:00'), 'Borrow'),
    (31, 9, 11, '2023-08-25 13:00:00', DATEADD(DAY, 7, '2023-08-25 13:00:00'), 'Borrow'),
    (32, 10, 19, '2023-08-30 11:00:00', DATEADD(DAY, 7, '2023-08-30 11:00:00'), 'Borrow'),
    (33, 1, 4, '2023-09-05 14:30:00', DATEADD(DAY, 7, '2023-09-05 14:30:00'), 'Borrow'),
    (34, 2, 14, '2023-09-10 09:45:00', DATEADD(DAY, 7, '2023-09-10 09:45:00'), 'Borrow'),
    (35, 4, 18, '2023-09-15 16:20:00', DATEADD(DAY, 7, '2023-09-15 16:20:00'), 'Borrow'),
    (36, 6, 7, '2023-09-20 10:15:00', DATEADD(DAY, 7, '2023-09-20 10:15:00'), 'Borrow'),
    (37, 7, 10, '2023-09-25 12:45:00', DATEADD(DAY, 7, '2023-09-25 12:45:00'), 'Borrow'),
    (38, 8, 1, '2023-09-30 08:00:00', DATEADD(DAY, 7, '2023-09-30 08:00:00'), 'Borrow'),
    (39, 9, 5, '2023-10-05 15:30:00', DATEADD(DAY, 7, '2023-10-05 15:30:00'), 'Borrow'),
    (40, 10, 9, '2023-10-10 10:00:00', DATEADD(DAY, 7, '2023-10-10 10:00:00'), 'Borrow'),
    (41, 1, 17, '2023-10-15 09:30:00', DATEADD(DAY, 7, '2023-10-15 09:30:00'), 'Borrow'),
    (42, 2, 12, '2023-10-20 14:15:00', DATEADD(DAY, 7, '2023-10-20 14:15:00'), 'Borrow'),
    (43, 4, 8, '2023-10-25 11:45:00', DATEADD(DAY, 7, '2023-10-25 11:45:00'), 'Borrow'),
    (44, 6, 20, '2023-10-30 10:30:00', DATEADD(DAY, 7, '2023-10-30 10:30:00'), 'Borrow'),
    (45, 7, 16, '2023-11-05 16:45:00', DATEADD(DAY, 7, '2023-11-05 16:45:00'), 'Borrow'),
    (46, 8, 5, '2023-11-10 09:30:00', DATEADD(DAY, 7, '2023-11-10 09:30:00'), 'Borrow'),
    (47, 9, 18, '2023-11-15 14:15:00', DATEADD(DAY, 7, '2023-11-15 14:15:00'), 'Borrow'),
    (48, 10, 3, '2023-11-20 11:45:00', DATEADD(DAY, 7, '2023-11-20 11:45:00'), 'Borrow'),
    (49, 1, 7, '2023-11-25 10:30:00', DATEADD(DAY, 7, '2023-11-25 10:30:00'), 'Borrow'),
    (50, 2, 19, '2023-12-01 16:45:00', DATEADD(DAY, 7, '2023-12-01 16:45:00'), 'Borrow');


	
-- Inserting Returned Records for the Borrowed transactions
INSERT INTO Returned(TransactionID, UserID, BookID, TransactionDate, TransactionType)
VALUES
    (1, 1, 3, '2023-04-15 09:30:00', 'Returned'), 
    (2, 2, 17, '2023-04-17 14:15:00', 'Returned'), 
    (3, 1, 9, '2023-04-22 11:45:00', 'Returned'), 
    (4, 3, 2, '2023-04-22 10:30:00', 'Returned'), 
    (5, 4, 6, '2023-04-30 16:45:00', 'Returned'), 
    (6, 3, 14, '2023-04-29 09:15:00', 'Returned'), 
    (7, 1, 19, '2023-05-02 13:00:00', 'Returned'),
    (8, 2, 5, '2023-05-07 11:00:00', 'Returned'),
    (9, 3, 12, '2023-05-12 14:30:00', 'Returned'), 
    (10, 4, 20, '2023-05-17 09:45:00', 'Returned'), 
    (11, 5, 7, '2023-05-22 16:20:00', 'Returned'), 
    (12, 6, 16, '2023-05-27 10:15:00', 'Returned'), 
    (13, 7, 1, '2023-06-01 12:45:00', 'Returned'), 
    (14, 8, 10, '2023-06-05 08:00:00', 'Returned'), 
    (15, 9, 8, '2023-06-12 15:30:00', 'Returned'), 
    (16, 10, 11, '2023-06-17 10:00:00', 'Returned'), 
    (17, 1, 13, '2023-06-22 09:30:00', 'Returned'), 
    (18, 2, 18, '2023-06-27 14:15:00', 'Returned'), 
    (19, 4, 4, '2023-07-02 11:45:00', 'Returned'), 
    (20, 6, 15, '2023-07-08 10:30:00', 'Returned'), 
    (21, 7, 20, '2023-07-12 16:45:00', 'Returned'), 
    (22, 8, 3, '2023-07-17 09:15:00', 'Returned'), 
    (23, 9, 14, '2023-07-22 13:00:00', 'Returned'), 
    (24, 10, 19, '2023-07-27 11:00:00', 'Returned'), 
    (25, 1, 5, '2023-08-01 09:30:00', 'Returned'), 
    (26, 2, 9, '2023-08-06 14:15:00', 'Returned'), 
    (27, 4, 12, '2023-08-12 11:45:00', 'Returned'), 
    (28, 6, 16, '2023-08-17 10:30:00', 'Returned'), 
    (29, 7, 2, '2023-08-22 16:45:00', 'Returned'), 
    (30, 8, 6, '2023-08-27 09:15:00', 'Returned'), 
    (31, 9, 11, '2023-09-01 13:00:00', 'Returned'), 
    (32, 10, 19, '2023-09-05 11:00:00', 'Returned'), 
    (33, 1, 4, '2023-09-12 14:30:00', 'Returned'), 
    (34, 2, 14, '2023-09-17 09:45:00', 'Returned'), 
    (35, 4, 18, '2023-09-22 16:20:00', 'Returned'), 
    (36, 6, 7, '2023-09-27 10:15:00', 'Returned'), 
    (37, 7, 10, '2023-10-02 12:45:00', 'Returned'), 
    (38, 8, 1, '2023-10-07 08:00:00', 'Returned'), 
    (39, 9, 5, '2023-10-12 15:30:00', 'Returned'),
    (40, 10, 9, '2023-10-10 10:00:00', 'Returned'), 
    (41, 1, 17, '2023-10-15 09:30:00', 'Returned'), 
    (42, 2, 12, '2023-10-20 14:15:00', 'Returned'), 
    (43, 4, 8, '2023-10-25 11:45:00', 'Returned'), 
    (44, 6, 20, '2023-10-30 10:30:00', 'Returned'), 
    (45, 7, 16, '2023-11-05 16:45:00', 'Returned'), 
    (46, 8, 5, '2023-11-10 09:30:00', 'Returned'), 
    (47, 9, 18, '2023-11-15 14:15:00', 'Returned'), 
    (48, 10, 3, '2023-11-20 11:45:00', 'Returned'),
    (49, 1, 7, '2023-11-25 10:30:00', 'Returned'), 
    (50, 2, 19, '2023-12-01 16:45:00', 'Returned'); 



/*====================================================================== 
Phase 2, Task 4: Implement Data Modification 

Description: Create SQL scripts for updating, deleting, and modifying 
data as needed.
======================================================================*/

-- Updating the email of the user with UserID 1
UPDATE Users
SET Email = 'iloveDSA@DSA.com'
WHERE UserID = 1;

-- Delete the Book with BookID 21
DELETE FROM Books
WHERE BookID = 21;

-- Insert a New book
INSERT INTO Books (BookID, Title, Author, GenreID,PublicationDate)
VALUES (22, 'Think and Trade Like A Champion', 'Mark Minervini', 14,'2013-11-12');


/*=====================================================================
Phase 3: Data Retrieval (DQL)
Task 5: Create SQL Queries for Common Tasks
Description: Develop SQL queries to perform common library-related tasks, 
such as searching for books by title, author, or genre.

=====================================================================*/
--Search for books By Author
SELECT Title,Author,GenreID
FROM Books
WHERE Author LIKE '%Dr. Joe Dispenza%';

--Search for books by Title
SELECT Title, Author, GenreID
FROM Books
WHERE Title LIKE '%Awaken the Giant Within%';

--Search for books by Genre
SELECT Title, Author, GenreID
FROM Books
WHERE GenreID = 13;

--Searching for All Users
SELECT FirstName, LastName,Email,MembershipDate
FROM Users;

-- List books borrowed by a specific user (UserID = 3) and include both book and user details
SELECT u.Firstname AS UserFirstname, u.Lastname AS UserLastname,b.Title AS BookTitle, b.Author AS BookAuthor, t.TransactionDate 
FROM Books AS b
INNER JOIN Borrowed AS t ON b.BookID = t.BookID
INNER JOIN Users AS u ON t.UserID = u.UserID
WHERE t.UserID = 3;

-- Count the number of  books by genre
SELECT g.GenreName AS [Genre Name], 
       COUNT(b.BookID) AS [Number of Books]
FROM Genres AS g
LEFT JOIN Books AS b ON g.GenreID = b.GenreID
GROUP BY g.GenreName
ORDER BY [Number of Books] DESC;


/*=========================================================================================
PHASE 3 TASK 6: Implement Advanced Queries Description: Construct more advanced SQL queries 
for generating reports on borrowed books, overdue books, and popular book genres.
==========================================================================================*/
-- List the most popular books by genre based on the number of times borrowed
SELECT G.GenreName AS 'Genre', COUNT(B.BookID) AS 'Borrowed Count'
FROM Genres AS G
LEFT JOIN Books AS B ON G.GenreID = B.GenreID
LEFT JOIN Borrowed AS T ON B.BookID = T.BookID
WHERE T.TransactionType = 'Borrow'
GROUP BY GenreName
ORDER BY COUNT(B.BookID) DESC;


-- List all borrowed books along with user information
SELECT B.Title AS 'Book Title', U.Firstname AS 'User First Name', U.Lastname AS 'User Last Name', T.TransactionDate AS 'Borrow Date'
FROM Books AS B
INNER JOIN Borrowed AS T ON B.BookID = T.BookID
INNER JOIN Users AS U ON T.UserID = U.UserID
WHERE T.TransactionType = 'Borrow';

-- List overdue books with book title, user name, and due date
SELECT B.Title AS BookTitle, U.Firstname, U.Lastname, T.DueDate
FROM Borrowed AS T
JOIN Books AS B ON T.BookID = B.BookID
JOIN Users AS U ON T.UserID = U.UserID
LEFT JOIN Returned AS R ON T.TransactionID = R.TransactionID
WHERE R.TransactionDate IS NULL OR R.TransactionDate > T.DueDate;




/*=====================================================================
Phase 4: Access Control (DCL)
Task 7: Define User Roles and Permissions
Description: Define user roles (e.g., librarian, member) and set 
appropriate permissions.
======================================================================*/

-- Create roles
CREATE ROLE Librarian;
CREATE ROLE Members;
-- Grant permissions to roles
GRANT SELECT, INSERT, UPDATE, DELETE ON Genres TO Librarian; -- permission for librarian
GRANT SELECT, INSERT, UPDATE, DELETE ON Books TO Librarian;-- permission for librarian
GRANT SELECT, INSERT, UPDATE, DELETE ON Users TO Librarian;-- permission for librarian
GRANT SELECT, INSERT, UPDATE, DELETE ON Borrowed TO Librarian;-- permission for librarian
GRANT SELECT, INSERT, UPDATE, DELETE ON Returned TO Librarian;-- permission for librarian

GRANT SELECT ON Books TO Members; --permission for members
GRANT SELECT ON Genres TO Members; --permission for members
-- Create logins
CREATE LOGIN Librarian WITH PASSWORD = '1234';
CREATE LOGIN member1 WITH PASSWORD = 'ABS';
CREATE LOGIN member2 WITH PASSWORD = 'JASON';
CREATE LOGIN member3 WITH PASSWORD = 'IHEARTUSA';
CREATE LOGIN member4 WITH PASSWORD = 'KATHRYN4EV';
CREATE LOGIN member5 WITH PASSWORD = '8W8DIVCHAMP';
CREATE LOGIN member6 WITH PASSWORD = 'SARAHG';
CREATE LOGIN member7 WITH PASSWORD = 'ALDUB4EVER';
CREATE LOGIN member8 WITH PASSWORD = 'IHEARDJ';
CREATE LOGIN member9 WITH PASSWORD = 'BATANGQUIAPO';
CREATE LOGIN member10 WITH PASSWORD = 'Lakers23';
-- Create users
CREATE USER christiandolor FOR LOGIN Librarian;
CREATE USER absavila FOR LOGIN member1;
CREATE USER PhBI FOR LOGIN member2;
CREATE USER lizasoberano FOR LOGIN member3;
CREATE USER danielpadilla FOR LOGIN member4;
CREATE USER mannypacquiao FOR LOGIN member5;
CREATE USER sarahgeronimo FOR LOGIN member6;
CREATE USER aldenrichards FOR LOGIN member7;
CREATE USER kathrynbernardo FOR LOGIN member8;
CREATE USER cocomartin FOR LOGIN member9;
CREATE USER LBJKing FOR LOGIN member10;

/*================================================================
Phase 4, Task 8: Implement Access Control Statements
Description: Implement DCL statements to control access to the 
database based on user.

Phase 4 TASK 9 :Simulate user interactions with the system, demonstrating how 
access control works based on user roles.
================================================================*/

-- Add users to roles
EXEC sp_addrolemember 'Librarian', 'christiandolor';
EXEC sp_addrolemember 'Members', 'absavila';
EXEC sp_addrolemember 'Members', 'PhBI';
EXEC sp_addrolemember 'Members', 'lizasoberano';
EXEC sp_addrolemember 'Members', 'danielpadilla';
EXEC sp_addrolemember 'Members', 'mannypacquiao';
EXEC sp_addrolemember 'Members', 'sarahgeronimo';
EXEC sp_addrolemember 'Members', 'aldenrichards';
EXEC sp_addrolemember 'Members', 'kathrynbernardo';
EXEC sp_addrolemember 'Members', 'cocomartin';

/*=================================================================

TASK 9 :Simulate user interactions with the system, demonstrating how 
access control works based on user roles.
==================================================================*/



--END OF SQL SCRIPT--



