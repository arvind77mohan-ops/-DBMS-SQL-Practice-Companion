INSERT OR IGNORE INTO Authors VALUES
(1,'R. K. Narayan'),(2,'Jane Austen'),(3,'George Orwell'),(4,'A. P. J. Abdul Kalam'),(5,'Agatha Christie');
INSERT OR IGNORE INTO Members VALUES
(1,'Ananya Rao','ananya@example.test','2026-01-10'),
(2,'Kavin Kumar','kavin@example.test','2026-02-15'),
(3,'Meera Iyer','meera@example.test','2026-03-01'),
(4,'Arjun Das','arjun@example.test','2026-04-12'),
(5,'Sara Thomas','sara@example.test','2026-05-05');
INSERT OR IGNORE INTO Books VALUES
(1,'Malgudi Days',1,'Fiction',350,1943),
(2,'The Guide',1,'Fiction',420,1958),
(3,'Pride and Prejudice',2,'Romance',500,1813),
(4,'1984',3,'Dystopian',450,1949),
(5,'Wings of Fire',4,'Biography',300,1999),
(6,'Murder on the Orient Express',5,'Mystery',550,1934),
(7,'Animal Farm',3,'Political Fiction',280,1945),
(8,'Sense and Sensibility',2,'Romance',480,1811);
INSERT OR IGNORE INTO Loans VALUES
(101,1,'2026-10-01','Returned'),(102,2,'2026-10-05','Borrowed'),
(103,1,'2026-10-12','Borrowed'),(104,3,'2026-10-15','Overdue'),
(105,4,'2026-10-20','Returned'),(106,5,'2026-10-22','Borrowed');
INSERT OR IGNORE INTO LoanItems VALUES
(101,1,'2026-10-15','2026-10-12'),(102,4,'2026-10-19',NULL),
(103,3,'2026-10-26',NULL),(104,6,'2026-10-29',NULL),
(105,5,'2026-11-03','2026-10-30'),(106,7,'2026-11-05',NULL);
