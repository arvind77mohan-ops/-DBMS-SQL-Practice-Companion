# Capstone 12 — DBMS and SQL Practice Companion
## Research report

### 1. Project question and audience
**Question:** How can AI help students learn database design and SQL through guided practice and error explanation?
**Target audience:** Third-semester Computer Science and Engineering students with introductory programming knowledge and limited practical SQL experience.

### 2. Learning objectives
Students should be able to: identify entities and relationships; map an ER model to relational tables; explain 1NF, 2NF and 3NF; write SELECT queries with filtering, joins, grouping and subqueries; understand indexes and query plans; and describe transaction properties.

### 3. Research approach and AI tools
Two AI research assistants can accelerate early-stage learning-material discovery: ChatGPT and Google Gemini. Use both to generate explanations, candidate examples and quiz drafts, then compare clarity and consistency. AI output is treated as a draft, not an authority. All SQL and database behavior in this project is checked by executing it against SQLite; design claims are checked against official documentation and course notes. Do not claim that AI independently verifies correctness.

**Prompt log (reusable):**
1. "Explain ER modelling for a third-semester CSE student. Give a small library example, cardinalities, and common modelling mistakes."
2. "Create a 1NF-to-3NF worked example. State candidate keys and functional dependencies at each step."
3. "Generate SQLite SELECT exercises covering filters, joins, aggregation, subqueries, CTEs and EXPLAIN QUERY PLAN. Include expected results."
4. "Explain this exact SQLite error, list likely causes, and propose a minimal safe correction. Do not invent schema details."
5. "Review this SQL for correctness, portability and unsafe assumptions. Separate verified facts from guesses."

### 4. Core concepts
**ER modelling:** Entities represent things about which data is stored; attributes describe them; relationships connect entities. Cardinality (1:1, 1:N, M:N) and participation constraints describe relationship rules. In the sample, one author can write many books; one member can make many loans; loans and books are connected through LoanItems.

**Normalization:** 1NF requires atomic values and no repeating groups. 2NF requires 1NF and no partial dependency of a non-prime attribute on part of a candidate key. 3NF requires 2NF and removes relevant transitive dependencies; formally, for every non-trivial FD X→A, X is a superkey or A is prime. Normalization reduces update, insertion and deletion anomalies, but design must still reflect real requirements.

**Joins:** INNER JOIN returns matching rows; LEFT JOIN preserves every row from the left side and supplies NULL for unmatched right-side columns. Join conditions should use primary/foreign key relationships.

**Indexing:** An index can reduce lookup work but consumes storage and adds write-maintenance cost. Index columns used selectively in WHERE, JOIN and ORDER BY only after examining workload. SQLite's EXPLAIN QUERY PLAN provides a high-level description of the chosen plan; it is not a substitute for benchmarking.

**Transactions:** A transaction groups operations into a logical unit. ACID means atomicity, consistency, isolation and durability. COMMIT makes changes permanent; ROLLBACK undoes uncommitted changes. This teaching app's browser console is read-only, so transaction practice should be performed in a separate local SQLite shell or script.

### 5. Sample database
A fictional library schema is used: Authors, Books, Members, Loans and LoanItems. It contains five fictional members, five authors, eight books and six loans. All names and email addresses are synthetic and use the reserved `.test` domain. No real student, patient or institutional records are included.

### 6. AI support and limitations
The app includes a rule-based SQLite error explainer for common errors (missing table/column, syntax errors, uniqueness, foreign-key, NOT NULL and datatype constraints). It creates explanation drafts from the error text. It is not a generative model and cannot infer missing schema context reliably. Students must inspect the schema, reproduce the issue and test any correction. Future extension: connect a model through a server-side API with consent, rate limits, privacy controls and verified context.

### 7. Verification and safety
- Schema and seed scripts are executed locally.
- All 25 supplied SELECT queries are executed against the sample database.
- Browser query console permits a single SELECT only; write and DDL statements are blocked.
- Error explanations are checked against known SQLite error categories.
- Quiz key is included and scoring is performed by the application.
- Dataset is fictional; no personal records or secrets are used.
- SQLite foreign-key enforcement is enabled per connection.

### 8. Sources
- SQLite documentation: https://www.sqlite.org/docs.html
- SQLite CREATE TABLE: https://www.sqlite.org/lang_createtable.html
- SQLite SELECT: https://www.sqlite.org/lang_select.html
- SQLite query planner: https://www.sqlite.org/eqp.html
- PostgreSQL documentation (comparison/reference): https://www.postgresql.org/docs/current/
- MySQL reference manual (comparison/reference): https://dev.mysql.com/doc/refman/8.4/en/
- Flask documentation: https://flask.palletsprojects.com/

### 9. Conclusion
The prototype combines a normalized sample database, SQL practice console, normalization walkthrough, quiz and explainable error helper. It demonstrates how AI-assisted drafting can support learning when paired with source checking, executable tests and clear limits.
