PRAGMA foreign_keys = ON;
CREATE TABLE IF NOT EXISTS Authors(
 author_id INTEGER PRIMARY KEY, author_name TEXT NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS Members(
 member_id INTEGER PRIMARY KEY, member_name TEXT NOT NULL,
 email TEXT NOT NULL UNIQUE, joined_on TEXT NOT NULL
);
CREATE TABLE IF NOT EXISTS Books(
 book_id INTEGER PRIMARY KEY, title TEXT NOT NULL,
 author_id INTEGER NOT NULL, category TEXT NOT NULL,
 price REAL NOT NULL CHECK(price >= 0), published_year INTEGER,
 FOREIGN KEY(author_id) REFERENCES Authors(author_id)
);
CREATE TABLE IF NOT EXISTS Loans(
 loan_id INTEGER PRIMARY KEY, member_id INTEGER NOT NULL,
 loan_date TEXT NOT NULL, status TEXT NOT NULL CHECK(status IN ('Borrowed','Returned','Overdue')),
 FOREIGN KEY(member_id) REFERENCES Members(member_id)
);
CREATE TABLE IF NOT EXISTS LoanItems(
 loan_id INTEGER NOT NULL, book_id INTEGER NOT NULL,
 due_date TEXT NOT NULL, returned_date TEXT,
 PRIMARY KEY(loan_id, book_id),
 FOREIGN KEY(loan_id) REFERENCES Loans(loan_id),
 FOREIGN KEY(book_id) REFERENCES Books(book_id)
);
CREATE INDEX IF NOT EXISTS idx_books_category ON Books(category);
CREATE INDEX IF NOT EXISTS idx_loans_member ON Loans(member_id);
CREATE INDEX IF NOT EXISTS idx_loanitems_book ON LoanItems(book_id);
