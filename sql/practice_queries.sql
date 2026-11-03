-- 01. Display all books
SELECT * FROM Books;
-- 02. Display member names and emails
SELECT member_name, email FROM Members;
-- 03. Find books priced above 400
SELECT title, price FROM Books WHERE price > 400;
-- 04. Sort books by title
SELECT title FROM Books ORDER BY title;
-- 05. Show distinct book categories
SELECT DISTINCT category FROM Books;
-- 06. Count books
SELECT COUNT(*) AS total_books FROM Books;
-- 07. Find books in the Romance category
SELECT title FROM Books WHERE category = 'Romance';
-- 08. Find books with prices from 300 to 500
SELECT title, price FROM Books WHERE price BETWEEN 300 AND 500;
-- 09. Find titles containing 'the' (case-insensitive in SQLite LIKE)
SELECT title FROM Books WHERE title LIKE '%the%';
-- 10. Show the three most expensive books
SELECT title, price FROM Books ORDER BY price DESC LIMIT 3;
-- 11. Join books to authors
SELECT b.title, a.author_name FROM Books b JOIN Authors a ON b.author_id=a.author_id;
-- 12. List each loan with member name
SELECT l.loan_id, m.member_name, l.status FROM Loans l JOIN Members m ON l.member_id=m.member_id;
-- 13. List loaned book titles
SELECT l.loan_id, b.title FROM LoanItems li JOIN Loans l ON li.loan_id=l.loan_id JOIN Books b ON li.book_id=b.book_id;
-- 14. Count books by category
SELECT category, COUNT(*) AS book_count FROM Books GROUP BY category;
-- 15. Categories containing more than one book
SELECT category, COUNT(*) AS book_count FROM Books GROUP BY category HAVING COUNT(*) > 1;
-- 16. Average book price
SELECT ROUND(AVG(price),2) AS average_price FROM Books;
-- 17. Members with no loans
SELECT m.member_name FROM Members m LEFT JOIN Loans l ON m.member_id=l.member_id WHERE l.loan_id IS NULL;
-- 18. Number of loans per member
SELECT m.member_name, COUNT(l.loan_id) AS loan_count FROM Members m LEFT JOIN Loans l ON m.member_id=l.member_id GROUP BY m.member_id,m.member_name;
-- 19. Books that have never been loaned
SELECT b.title FROM Books b LEFT JOIN LoanItems li ON b.book_id=li.book_id WHERE li.book_id IS NULL;
-- 20. Find overdue loans
SELECT l.loan_id,m.member_name,b.title,li.due_date FROM Loans l JOIN Members m ON l.member_id=m.member_id JOIN LoanItems li ON l.loan_id=li.loan_id JOIN Books b ON li.book_id=b.book_id WHERE l.status='Overdue';
-- 21. Subquery: books priced above average
SELECT title,price FROM Books WHERE price > (SELECT AVG(price) FROM Books);
-- 22. Authors with at least two books
SELECT a.author_name,COUNT(b.book_id) AS titles FROM Authors a JOIN Books b ON a.author_id=b.author_id GROUP BY a.author_id,a.author_name HAVING COUNT(b.book_id)>=2;
-- 23. CASE expression for price bands
SELECT title,price,CASE WHEN price>=500 THEN 'Premium' WHEN price>=350 THEN 'Standard' ELSE 'Budget' END AS price_band FROM Books;
-- 24. Common table expression for active loans
WITH ActiveLoans AS (SELECT * FROM Loans WHERE status IN ('Borrowed','Overdue')) SELECT member_id,COUNT(*) AS active_count FROM ActiveLoans GROUP BY member_id;
-- 25. Query plan: inspect index strategy
EXPLAIN QUERY PLAN SELECT * FROM Books WHERE category='Romance';
