CREATE DATABASE onboarding;


CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending'
);
select * from employees;

CREATE TABLE onboarding_tasks (
    id SERIAL PRIMARY KEY,
    task_name VARCHAR(255) NOT NULL,
    category VARCHAR(50) NOT NULL,
    assigned_to INT REFERENCES employees(id),
    status VARCHAR(20) DEFAULT 'Pending'
);

CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id),
    document_name VARCHAR(255) NOT NULL,
    upload_date TIMESTAMP DEFAULT NOW()
);

CREATE TABLE queries (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(id),
    query_text TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'Open',
    created_at TIMESTAMP DEFAULT NOW()
);
