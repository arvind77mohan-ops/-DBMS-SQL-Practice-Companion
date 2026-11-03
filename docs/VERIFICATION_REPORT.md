# Verification report

## Test environment
Python 3.10+ recommended; Flask 3.x; SQLite supplied with Python. The test database is created from `sql/schema.sql` and `sql/seed.sql`.

## Checks performed by the project setup
1. Schema creation with primary keys, foreign keys, UNIQUE and CHECK constraints.
2. Seed insertion with fictional data.
3. Execution of all 25 statements in `sql/practice_queries.sql`.
4. Confirmation that each statement is a SELECT or EXPLAIN QUERY PLAN.
5. Web routes for home, query runner, normalization guide, quiz and about page.

## Expected smoke-test outputs
- `SELECT COUNT(*) AS total_books FROM Books;` → `8`
- `SELECT COUNT(*) AS total_members FROM Members;` → `5`
- `SELECT category, COUNT(*) FROM Books GROUP BY category HAVING COUNT(*) > 1;` → Romance: 2; Fiction: 2
- `SELECT title FROM Books WHERE price > 500;` → Murder on the Orient Express
- Overdue loan join → loan 104, Meera Iyer, Murder on the Orient Express

## Known limitations
This is an educational prototype, not a production database platform. The browser console only runs one read-only SELECT statement. Error explanations are heuristic. The sample schema is intentionally small. The quiz is introductory and does not replace instructor assessment.
