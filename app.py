from flask import Flask, render_template, request
import sqlite3, re
from pathlib import Path

APP_DIR = Path(__file__).parent
DB_PATH = APP_DIR / "dbms_practice.db"
app = Flask(__name__)

def connect():
    con = sqlite3.connect(DB_PATH)
    con.row_factory = sqlite3.Row
    con.execute("PRAGMA foreign_keys = ON")
    return con

def initialise():
    schema = (APP_DIR / "sql" / "schema.sql").read_text(encoding="utf-8")
    seed = (APP_DIR / "sql" / "seed.sql").read_text(encoding="utf-8")
    with connect() as con:
        con.executescript(schema)
        con.executescript(seed)

def explain_error(message):
    m = message.lower()
    rules = [
        (("no such table",), "SQLite cannot find the table named in your query.",
         "Check the table spelling and confirm that the schema has been created. Try: SELECT name FROM sqlite_master WHERE type='table';"),
        (("no such column",), "A column referenced in the query does not exist in that table or alias.",
         "Check the column spelling and qualify it with the correct table alias. Inspect columns using PRAGMA table_info(table_name);"),
        (("syntax error", "incomplete input"), "The SQL statement is incomplete or does not follow SQLite syntax.",
         "Check commas, parentheses, quotes, clause order, and whether the statement ends before all expressions are complete."),
        (("unique constraint failed",), "A value violates a UNIQUE constraint, so it duplicates an existing value.",
         "Use a new unique value, update the existing row, or use INSERT OR IGNORE only when ignoring duplicates is intentional."),
        (("foreign key constraint failed",), "A row refers to a parent record that does not exist, or a delete would orphan child rows.",
         "Insert the parent row first, use a valid referenced ID, or review the intended ON DELETE rule."),
        (("not null constraint failed",), "A required column received NULL or no value.",
         "Provide a value for the required column or deliberately change the schema if NULL is valid for the domain."),
        (("datatype mismatch",), "A value has a type that is incompatible with the target column or expression.",
         "Check the value and column types. SQLite is flexible, but IDs and numeric calculations should use consistent types.")
    ]
    for patterns, meaning, fix in rules:
        if any(p in m for p in patterns):
            return meaning, fix
    return ("The database rejected the statement. The message alone may not identify the full cause.",
            "Check table and column names, SQL syntax, constraints, data types, and the order of operations. Reproduce the issue with a small query.")

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/run-query", methods=["POST"])
def run_query():
    sql = request.form.get("sql", "").strip()
    if not sql:
        return render_template("result.html", error="Please enter a SQL statement.", meaning="", fix="", sql=sql)
    # This learning app intentionally permits only read-only SELECT statements.
    if not re.match(r"^\s*SELECT\b", sql, re.I) or ";" in sql.rstrip(";"):
        return render_template("result.html", error="For safety, the practice console accepts one SELECT statement only.", meaning="Write a read-only SELECT query.", fix="Use the supplied SQL examples. INSERT, UPDATE, DELETE, DROP and multiple statements are disabled in the browser console.", sql=sql)
    try:
        with connect() as con:
            cur = con.execute(sql)
            rows = cur.fetchall()
            columns = [d[0] for d in cur.description] if cur.description else []
        return render_template("result.html", sql=sql, columns=columns, rows=rows, error=None, meaning="", fix="")
    except sqlite3.Error as e:
        meaning, fix = explain_error(str(e))
        return render_template("result.html", sql=sql, columns=[], rows=[], error=str(e), meaning=meaning, fix=fix)

@app.route("/normalization")
def normalization():
    return render_template("normalization.html")

@app.route("/quiz", methods=["GET", "POST"])
def quiz():
    questions = [
        ("Which normal form removes repeating groups and requires atomic values?", ["1NF", "2NF", "3NF", "BCNF"], "1NF", "1NF requires each attribute value to be atomic and removes repeating groups."),
        ("A partial dependency violates which normal form?", ["1NF", "2NF", "3NF", "4NF"], "2NF", "2NF removes partial dependencies on a proper subset of a candidate key."),
        ("A transitive dependency of a non-key attribute on a key is addressed by:", ["1NF", "2NF", "3NF", "5NF"], "3NF", "3NF removes transitive dependencies of non-key attributes on candidate keys."),
        ("Which SQL clause filters groups after aggregation?", ["WHERE", "ORDER BY", "HAVING", "LIMIT"], "HAVING", "WHERE filters rows before grouping; HAVING filters groups."),
        ("Which join returns only matching rows from both tables?", ["LEFT JOIN", "INNER JOIN", "CROSS JOIN", "FULL OUTER JOIN"], "INNER JOIN", "INNER JOIN returns rows where the join condition matches."),
        ("Which command makes a transaction's changes permanent?", ["ROLLBACK", "SAVEPOINT", "COMMIT", "GRANT"], "COMMIT", "COMMIT permanently applies the current transaction."),
        ("Which index structure is commonly used by relational databases?", ["B-tree", "Stack", "Queue", "Linked list"], "B-tree", "B-tree indexes support efficient ordered lookup and range scans."),
        ("Which property means a transaction is all-or-nothing?", ["Consistency", "Isolation", "Atomicity", "Durability"], "Atomicity", "Atomicity means all transaction operations succeed or none do."),
        ("Which constraint uniquely identifies each row?", ["CHECK", "PRIMARY KEY", "DEFAULT", "FOREIGN KEY"], "PRIMARY KEY", "A primary key uniquely identifies each row and cannot be NULL."),
        ("Which SQL function counts rows?", ["SUM()", "AVG()", "COUNT()", "ROUND()"], "COUNT()", "COUNT() returns the number of rows or non-NULL values, depending on its argument."),
        ("What does EXPLAIN QUERY PLAN help inspect in SQLite?", ["User roles", "Query execution strategy", "Passwords", "Backups"], "Query execution strategy", "It reports the high-level strategy and index usage for a query."),
        ("A foreign key primarily enforces:", ["Referential integrity", "Sorting", "Encryption", "Compression"], "Referential integrity", "A foreign key ensures references point to valid parent rows.")
    ]
    score = None
    if request.method == "POST":
        score = sum(1 for i, q in enumerate(questions) if request.form.get(f"q{i}") == q[2])
    return render_template("quiz.html", questions=questions, score=score)

@app.route("/about")
def about():
    return render_template("about.html")

if __name__ == "__main__":
    initialise()
    app.run(host="127.0.0.1", port=5000, debug=True)
