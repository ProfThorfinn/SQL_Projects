CREATE DATABASE Smart_Library_System;
USE Smart_Library_System;

CREATE TABLE Genre (
    Genre_ID INT PRIMARY KEY,
    Genre_Name VARCHAR(100) NOT NULL
);
INSERT INTO Genre (Genre_ID, Genre_Name) VALUES
(1, 'Fiction'),
(2, 'Non-Fiction'),
(3, 'Science'),
(4, 'History'),
(5, 'Fantasy'),
(6, 'Biography'),
(7, 'Mystery'),
(8, 'Poetry'),
(9, 'Technology'),
(10, 'Children');

CREATE TABLE Writer (
    Unique_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL
);
INSERT INTO Writer (Unique_ID, Full_Name) VALUES
(1, 'John Smith'),
(2, 'Jane Doe'),
(3, 'Robert Johnson'),
(4, 'Mary Williams'),
(5, 'Michael Brown'),
(6, 'Sarah Davis'),
(7, 'James Wilson'),
(8, 'Patricia Moore'),
(9, 'William Taylor'),
(10, 'Elizabeth Anderson');

CREATE TABLE Distributor (
    Unique_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL
);
INSERT INTO Distributor (Unique_ID, Full_Name) VALUES
(1, 'BookWorld Distributors'),
(2, 'PageTurner Supplies'),
(3, 'ReadEasy Co.'),
(4, 'LitHub Distribution'),
(5, 'NovelNet Inc.'),
(6, 'PaperBack Partners'),
(7, 'InkFlow Distributors'),
(8, 'StoryLine Supplies'),
(9, 'TextTrove Ltd.'),
(10, 'LeafPress Distribution');

CREATE TABLE Level (
    Level_ID INT PRIMARY KEY,
    Total_Sections INT NOT NULL
);
INSERT INTO Level (Level_ID, Total_Sections) VALUES
(1, 5),
(2, 4),
(3, 6),
(4, 3),
(5, 5),
(6, 4),
(7, 5),
(8, 3),
(9, 6),
(10, 4);


CREATE TABLE Rack (
    Rack_Code VARCHAR(20) PRIMARY KEY,
    Level_ID INT NOT NULL,
    FOREIGN KEY (Level_ID) REFERENCES Level(Level_ID)
);
INSERT INTO Rack (Rack_Code, Level_ID) VALUES
('R001', 1),
('R002', 1),
('R003', 2),
('R004', 2),
('R005', 3),
('R006', 3),
('R007', 4),
('R008', 4),
('R009', 5),
('R010', 5);


CREATE TABLE Book (
    Book_Code VARCHAR(20) PRIMARY KEY,
    Book_Title VARCHAR(200) NOT NULL,
    Rack_Code VARCHAR(20) NOT NULL,
    Genre_ID INT NOT NULL,
    Distributor_ID INT NOT NULL,
    FOREIGN KEY (Rack_Code) REFERENCES Rack(Rack_Code),
    FOREIGN KEY (Genre_ID) REFERENCES Genre(Genre_ID),
    FOREIGN KEY (Distributor_ID) REFERENCES Distributor(Unique_ID)
);
INSERT INTO Book (Book_Code, Book_Title, Rack_Code, Genre_ID, Distributor_ID) VALUES
('B001', 'The Great Gatsby', 'R001', 1, 1),
('B002', 'To Kill a Mockingbird', 'R002', 1, 2),
('B003', '1984', 'R003', 3, 3),
('B004', 'Pride and Prejudice', 'R004', 1, 4),
('B005', 'The Hobbit', 'R005', 5, 5),
('B006', 'Sapiens', 'R006', 2, 6),
('B007', 'Harry Potter', 'R007', 5, 7),
('B008', 'The Da Vinci Code', 'R008', 7, 8),
('B009', 'A Brief History of Time', 'R009', 3, 9),
('B010', 'Goodnight Moon', 'R010', 10, 10);

-- Book_Writer junction table (for M:N relationship between Book and Writer)
CREATE TABLE Book_Writer (
    Book_Code VARCHAR(20) NOT NULL,
    Writer_ID INT NOT NULL,
    PRIMARY KEY (Book_Code, Writer_ID),
    FOREIGN KEY (Book_Code) REFERENCES Book(Book_Code),
    FOREIGN KEY (Writer_ID) REFERENCES Writer(Unique_ID)
);
INSERT INTO Book_Writer (Book_Code, Writer_ID) VALUES
('B001', 1), ('B001', 2), 
('B002', 3),               
('B003', 4),               
('B004', 5),               
('B005', 6),               
('B006', 7),               
('B007', 8),               
('B008', 9),               
('B009', 10),              
('B010', 1);


CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Contact_Email VARCHAR(100) NOT NULL,
    Monthly_Salary DECIMAL(10, 2) NOT NULL,
    Birth_Date DATE NOT NULL,
    Incentive DECIMAL(10, 2),
    Home_Address VARCHAR(200) NOT NULL,
    Mobile_Number VARCHAR(20) NOT NULL,
    Team_Leader_Staff_ID INT,
    Level_ID INT NOT NULL,
    Start_Date DATE NOT NULL,
    FOREIGN KEY (Level_ID) REFERENCES Level(Level_ID),
    FOREIGN KEY (Team_Leader_Staff_ID) REFERENCES Staff(Staff_ID)
);
INSERT INTO Staff (Staff_ID, Full_Name, First_Name, Last_Name, Contact_Email, Monthly_Salary, Birth_Date, Incentive, Home_Address, Mobile_Number, Team_Leader_Staff_ID, Level_ID, Start_Date) VALUES
(1, 'Alice Johnson', 'Alice', 'Johnson', 'alice.johnson@email.com', 5000.00, '1990-05-15', 500.00, '123 Main St, City', '555-0101', NULL, 1, '2020-01-01'), -- Team Leader (no Team_Leader_Staff_ID)
(2, 'Bob Smith', 'Bob', 'Smith', 'bob.smith@email.com', 4500.00, '1988-08-20', 400.00, '456 Oak Rd, City', '555-0102', 1, 1, '2020-02-01'),
(3, 'Carol Williams', 'Carol', 'Williams', 'carol.williams@email.com', 4800.00, '1992-03-10', 450.00, '789 Pine Ave, City', '555-0103', 1, 2, '2020-03-01'),
(4, 'David Brown', 'David', 'Brown', 'david.brown@email.com', 4200.00, '1985-11-25', 350.00, '321 Elm St, City', '555-0104', 1, 2, '2020-04-01'),
(5, 'Eve Davis', 'Eve', 'Davis', 'eve.davis@email.com', 4600.00, '1991-07-30', 420.00, '654 Birch Ln, City', '555-0105', 1, 3, '2020-05-01'),
(6, 'Frank Wilson', 'Frank', 'Wilson', 'frank.wilson@email.com', 4400.00, '1987-09-12', 380.00, '987 Cedar Dr, City', '555-0106', 1, 3, '2020-06-01'),
(7, 'Grace Moore', 'Grace', 'Moore', 'grace.moore@email.com', 4700.00, '1993-04-18', 430.00, '147 Maple St, City', '555-0107', 1, 4, '2020-07-01'),
(8, 'Henry Taylor', 'Henry', 'Taylor', 'henry.taylor@email.com', 4100.00, '1986-12-05', 340.00, '258 Willow Rd, City', '555-0108', 1, 4, '2020-08-01'),
(9, 'Ivy Anderson', 'Ivy', 'Anderson', 'ivy.anderson@email.com', 4900.00, '1994-06-22', 460.00, '369 Spruce Ave, City', '555-0109', 1, 5, '2020-09-01'),
(10, 'Jack Parker', 'Jack', 'Parker', 'jack.parker@email.com', 4300.00, '1989-10-14', 370.00, '741 Poplar Ln, City', '555-0110', 1, 5, '2020-10-01');

CREATE TABLE Visitor (
    National_ID VARCHAR(20) PRIMARY KEY,
    Full_Name VARCHAR(100) NOT NULL,
    Personal_Email VARCHAR(100) NOT NULL,
    Phone_Contacts VARCHAR(20) NOT NULL,
    Staff_ID INT NOT NULL,
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID)
);
INSERT INTO Visitor (National_ID, Full_Name, Personal_Email, Phone_Contacts, Staff_ID) VALUES
('V001', 'Emily Stone', 'emily.stone@email.com', '555-0201', 1),
('V002', 'Liam Carter', 'liam.carter@email.com', '555-0202', 2),
('V003', 'Olivia Green', 'olivia.green@email.com', '555-0203', 3),
('V004', 'Noah King', 'noah.king@email.com', '555-0204', 4),
('V005', 'Sophia Lee', 'sophia.lee@email.com', '555-0205', 5),
('V006', 'Mason Wright', 'mason.wright@email.com', '555-0206', 6),
('V007', 'Isabella Hall', 'isabella.hall@email.com', '555-0207', 7),
('V008', 'Ethan Scott', 'ethan.scott@email.com', '555-0208', 8),
('V009', 'Ava Turner', 'ava.turner@email.com', '555-0209', 9),
('V010', 'James Walker', 'james.walker@email.com', '555-0210', 10);

CREATE TABLE Borrowings (
    Borrowing_ID INT PRIMARY KEY AUTO_INCREMENT,
    Borrow_Date DATE NOT NULL,
    Return_Date DATE,
    Fee_Paid DECIMAL(10, 2) NOT NULL,
    Book_Code VARCHAR(20) NOT NULL,
    National_ID VARCHAR(20) NOT NULL,
    FOREIGN KEY (Book_Code) REFERENCES Book(Book_Code),
    FOREIGN KEY (National_ID) REFERENCES Visitor(National_ID)
);
INSERT INTO Borrowings (Borrow_Date, Return_Date, Fee_Paid, Book_Code, National_ID) VALUES
('2025-03-01', '2025-03-15', 5.00, 'B001', 'V001'),
('2025-03-02', '2025-03-16', 5.00, 'B002', 'V002'),
('2025-03-03', '2025-03-17', 5.00, 'B003', 'V003'),
('2025-03-04', '2025-03-18', 5.00, 'B004', 'V004'),
('2025-03-05', '2025-03-19', 5.00, 'B005', 'V005'),
('2025-03-06', NULL, 5.00, 'B006', 'V006'),
('2025-03-07', '2025-03-21', 5.00, 'B007', 'V007'),
('2025-03-08', '2025-03-22', 5.00, 'B008', 'V008'),
('2025-03-09', '2025-03-23', 5.00, 'B009', 'V009'),
('2025-03-10', '2025-03-24', 5.00, 'B010', 'V010');

-- Queries : 1- Identify books written by a specific writer.
SELECT 
    b.Book_Code, 
    b.Book_Title, 
    w.Full_Name AS Writer_Name
FROM Book b
JOIN Book_Writer bw ON b.Book_Code = bw.Book_Code
JOIN Writer w ON bw.Writer_ID = w.Unique_ID
WHERE w.Unique_ID = 1;

-- 2: List all books with their genres and distributors.
SELECT 
    b.Book_Code, 
    b.Book_Title, 
    g.Genre_Name, 
    d.Full_Name AS Distributor_Name
FROM Book b
JOIN Genre g ON b.Genre_ID = g.Genre_ID
JOIN Distributor d ON b.Distributor_ID = d.Unique_ID;

-- 3: Find all staff members and their assigned levels and team leaders
SELECT 
    s.Staff_ID, 
    s.Full_Name, 
    l.Level_ID, 
    l.Total_Sections,
    tl.Full_Name AS Team_Leader_Name
FROM Staff s
LEFT JOIN Level l ON s.Level_ID = l.Level_ID
LEFT JOIN Staff tl ON s.Team_Leader_Staff_ID = tl.Staff_ID;

-- 4: List all visitors and the books they have borrowed.
SELECT 
    v.National_ID, 
    v.Full_Name, 
    b.Book_Title, 
    br.Borrow_Date, 
    br.Return_Date, 
    br.Fee_Paid
FROM Visitor v
JOIN Borrowings br ON v.National_ID = br.National_ID
JOIN Book b ON br.Book_Code = b.Book_Code
ORDER BY v.National_ID, br.Borrow_Date;

-- 5: Find the total fees paid by each visitor.
SELECT 
    v.National_ID, 
    v.Full_Name, 
    SUM(br.Fee_Paid) AS Total_Fees_Paid
FROM Visitor v
LEFT JOIN Borrowings br ON v.National_ID = br.National_ID
GROUP BY v.National_ID, v.Full_Name
ORDER BY Total_Fees_Paid DESC;

-- متكررة 3 مرات لاني شغلتها 3 مرات 
