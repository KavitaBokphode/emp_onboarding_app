-- Users Table (Common for all roles)
CREATE TABLE users (
    user_id        INT PRIMARY KEY AUTO_INCREMENT,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(150) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('Employee', 'Admin', 'Dept_User', 'Super_Admin') NOT NULL,
    department_id INT NULL,
    status        ENUM('Active', 'Inactive') DEFAULT 'Active',
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (department_id) REFERENCES departments(dept_id) ON DELETE SET NULL
);

CREATE TABLE departments (
    dept_id   INT PRIMARY KEY AUTO_INCREMENT,
    name      VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE employees (
    emp_id        INT PRIMARY KEY AUTO_INCREMENT,
    user_id       INT UNIQUE NOT NULL,
    designation   VARCHAR(100) NOT NULL,
    joining_date  DATE NOT NULL,
    department_id INT,
    supervisor_id INT NULL,
    document_url  TEXT NULL, -- S3 URL for storing employee documents
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (department_id) REFERENCES departments(dept_id) ON DELETE SET NULL,
    FOREIGN KEY (supervisor_id) REFERENCES employees(emp_id) ON DELETE SET NULL
);

CREATE TABLE onboarding_tasks (
    task_id       INT PRIMARY KEY AUTO_INCREMENT,
    emp_id        INT NOT NULL,
    assigned_by   INT NOT NULL,
    department_id INT NOT NULL,
    task_name     VARCHAR(255) NOT NULL,
    description   TEXT,
    status        ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    due_date      DATE NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_by) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (department_id) REFERENCES departments(dept_id) ON DELETE SET NULL
);

CREATE TABLE employee_queries (
    query_id     INT PRIMARY KEY AUTO_INCREMENT,
    emp_id       INT NOT NULL,
    query_text   TEXT NOT NULL,
    assigned_to  INT NULL,
    status       ENUM('Open', 'In Progress', 'Resolved') DEFAULT 'Open',
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id) ON DELETE CASCADE,
    FOREIGN KEY (assigned_to) REFERENCES users(user_id) ON DELETE SET NULL
);
