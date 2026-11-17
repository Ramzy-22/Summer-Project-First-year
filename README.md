# Student Records Web Application

A first-year summer project for managing student records through a browser. Built with HTML, CSS, JavaScript, an Express API, and PostgreSQL.

## Features

- User registration and login with bcrypt password hashing and JWT sessions.
- Student listing and search by student ID, name, or course.
- Administrator routes for creating, editing, and deleting students.
- CSV export API and a browser export of the displayed table to an Excel-readable HTML file.
- Student details including email, phone, date of birth, gender, and course.

## Project layout

```text
Student web serever database/
├── Frontend/             # Browser interface, styles, and client logic
└── backend/
    ├── server.js         # Express entry point
    ├── db.js             # PostgreSQL connection pool
    ├── routes/           # Authentication and student endpoints
    ├── middleware/       # Token verification and admin checks
    ├── schema.sql        # Initial database tables
    └── .env.example      # Local configuration template
```

## Local setup

Requirements: Node.js 22 or newer with npm, PostgreSQL with `createdb` and `psql`, and Python 3 for the static frontend server below.

### 1. Install the backend

```sh
git clone https://github.com/Ramzy-22/Summer-Project-First-year.git
cd "Summer-Project-First-year/Student web serever database/backend"
npm ci
```

Copy `.env.example` to `.env` and fill in your PostgreSQL credentials and a long random `SECRET_KEY`. On PowerShell use `Copy-Item .env.example .env`; on Linux/macOS use `cp .env.example .env`.

Keep `PORT=5000`: the existing frontend calls `http://localhost:5000` directly. Generate a session-signing secret with:

```sh
node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"
```

### 2. Create a database

From the backend directory:

```sh
createdb -U postgres student_records
psql -U postgres -d student_records -f schema.sql
```

The supplied schema matches the fields used by the API. It is intended for a new database and does not drop existing tables. Set `DB_NAME=student_records` in `.env`.

### 3. Start the API

```sh
npm start
```

### 4. Serve the frontend

In a second terminal, change to `Student web serever database/Frontend` and run:

```sh
python -m http.server 8080
```

On Windows you can use `py -m http.server 8080`. Open [localhost:8080](http://localhost:8080), register a user, and log in.

## API overview

Authenticated requests use `Authorization: Bearer <token>`.

| Method | Endpoint | Access |
| --- | --- | --- |
| POST | `/api/auth/register` | Public |
| POST | `/api/auth/login` | Public |
| GET | `/api/students` | Signed-in user |
| GET | `/api/students?q=term` | Signed-in user |
| POST | `/api/students` | Admin |
| PATCH | `/api/students/:student_id` | Admin |
| DELETE | `/api/students/:student_id` | Admin |
| GET | `/api/students/export/csv` | Admin |

## Current limitations

This is a local coursework demonstration. Before using real student information or deploying publicly, address these existing behaviors:

- Registration accepts a caller-supplied role, including `admin`, and returns the stored user row including its password hash.
- Student values are inserted into HTML without escaping.
- The CSV endpoint exists, but the frontend CSV button has no click handler. Exporting an empty dataset may fail.
- The Excel download is an HTML table with an `.xls` extension, not a native Excel workbook.
- The frontend uses a fixed localhost API address and stores session tokens in local storage.

## Development checks

From `backend`, run `npm run check` for JavaScript syntax checks. This does not test database connectivity, authentication flows, or browser behavior. The PostgreSQL setup and full application workflows have not been tested in this repository improvement pass.
