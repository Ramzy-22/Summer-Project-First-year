-- Initial schema inferred from the existing API queries.
-- Run against a new, empty database. No existing tables are dropped.
BEGIN;
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'guest' CHECK (role IN ('guest', 'admin'))
);
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    student_id TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT,
    birth_date DATE,
    gender TEXT,
    course TEXT NOT NULL
);
COMMIT;
