# DBMS and SQL Practice Companion

A local Flask + SQLite capstone prototype for third-semester CSE students.

## Run on Windows
1. Install Python 3.10 or newer.
2. Extract this ZIP file.
3. Open the extracted `dbms_capstone` folder in VS Code.
4. Open Terminal → New Terminal.
5. Run:
   ```powershell
   py -m venv .venv
   .venv\Scripts\activate
   pip install -r requirements.txt
   python app.py
   ```
6. Open **http://127.0.0.1:5000** in your browser.

## Run on macOS/Linux
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
python app.py
```
Then open http://127.0.0.1:5000.

## Features
- SQL practice console (one read-only SELECT statement at a time)
- SQLite error explanation drafts
- 1NF-to-3NF worked example
- 12-question quiz with score and answer key
- Fictional library database with five related tables
- 25 practice SQL statements in `sql/practice_queries.sql`

## Example
Paste this into the home page:
```sql
SELECT title, price
FROM Books
WHERE price > 400
ORDER BY price DESC;
```
Expected output:
| title | price |
|---|---:|
| Murder on the Orient Express | 550 |
| Pride and Prejudice | 500 |
| Sense and Sensibility | 480 |
| The Guide | 420 |

## Mobile access
For the same Wi-Fi network, run `python app.py` after changing the final line to:
`app.run(host="0.0.0.0", port=5000, debug=True)`
Find your laptop's local IPv4 address with `ipconfig` (Windows) or `ip addr` (Linux), then open `http://LAPTOP-IP:5000` on your phone. Do this only on a trusted private network; do not expose the development server to the public internet.

## Project structure
- `app.py` — Flask application
- `templates/` — HTML pages
- `static/style.css` — styling
- `sql/schema.sql` — normalized schema and indexes
- `sql/seed.sql` — fictional sample records
- `sql/practice_queries.sql` — 25 exercises
- `docs/` — research, ER diagram and verification report
- `presentation.pptx` — 6-slide overview
- `quiz_answer_key.md` — questions and answers

## Safety
The sample data is fictional. The web console blocks write/DDL commands. The app is for local educational use only.
