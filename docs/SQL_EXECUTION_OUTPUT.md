# Automated SQL execution results

Executed 25 of 25 statements successfully.

| # | Query | Rows returned |
|---:|---|---:|
| 1 | `SELECT * FROM Books` | 8 |
| 2 | `SELECT member_name, email FROM Members` | 5 |
| 3 | `SELECT title, price FROM Books WHERE price > 400` | 5 |
| 4 | `SELECT title FROM Books ORDER BY title` | 8 |
| 5 | `SELECT DISTINCT category FROM Books` | 6 |
| 6 | `SELECT COUNT(*) AS total_books FROM Books` | 1 |
| 7 | `SELECT title FROM Books WHERE category = 'Romance'` | 2 |
| 8 | `SELECT title, price FROM Books WHERE price BETWEEN 300 AND 500` | 6 |
| 9 | `SELECT title FROM Books WHERE title LIKE '%the%'` | 2 |
| 10 | `SELECT title, price FROM Books ORDER BY price DESC LIMIT 3` | 3 |
| 11 | `SELECT b.title, a.author_name FROM Books b JOIN Authors a ON b.author_id=a.author_id` | 8 |
| 12 | `SELECT l.loan_id, m.member_name, l.status FROM Loans l JOIN Members m ON l.member_id=` | 6 |
| 13 | `SELECT l.loan_id, b.title FROM LoanItems li JOIN Loans l ON li.loan_id=l.loan_id JOIN` | 6 |
| 14 | `SELECT category, COUNT(*) AS book_count FROM Books GROUP BY category` | 6 |
| 15 | `SELECT category, COUNT(*) AS book_count FROM Books GROUP BY category HAVING COUNT(*) ` | 2 |
| 16 | `SELECT ROUND(AVG(price),2) AS average_price FROM Books` | 1 |
| 17 | `SELECT m.member_name FROM Members m LEFT JOIN Loans l ON m.member_id=l.member_id WHER` | 0 |
| 18 | `SELECT m.member_name, COUNT(l.loan_id) AS loan_count FROM Members m LEFT JOIN Loans l` | 5 |
| 19 | `SELECT b.title FROM Books b LEFT JOIN LoanItems li ON b.book_id=li.book_id WHERE li.b` | 2 |
| 20 | `SELECT l.loan_id,m.member_name,b.title,li.due_date FROM Loans l JOIN Members m ON l.m` | 1 |
| 21 | `SELECT title,price FROM Books WHERE price > (SELECT AVG(price) FROM Books)` | 5 |
| 22 | `SELECT a.author_name,COUNT(b.book_id) AS titles FROM Authors a JOIN Books b ON a.auth` | 3 |
| 23 | `SELECT title,price,CASE WHEN price>=500 THEN 'Premium' WHEN price>=350 THEN 'Standard` | 8 |
| 24 | `WITH ActiveLoans AS (SELECT * FROM Loans WHERE status IN ('Borrowed','Overdue')) SELE` | 4 |
| 25 | `EXPLAIN QUERY PLAN SELECT * FROM Books WHERE category='Romance'` | 1 |