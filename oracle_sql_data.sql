CREATE TABLE Departments (
    dept_id NUMBER PRIMARY KEY,
    dept_name VARCHAR2(50) NOT NULL
);

INSERT INTO Departments VALUES (10, 'Administration');
INSERT INTO Departments VALUES (20, 'Software Engineering');
INSERT INTO Departments VALUES (30, 'Finance & Accounting');
INSERT INTO Departments VALUES (40, 'Human Resources');
INSERT INTO Departments VALUES (50, 'Marketing');

COMMIT;


CREATE TABLE Employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50) NOT NULL,
    salary NUMBER(10,2),
    dept_id NUMBER,
    manager_id NUMBER,
    CONSTRAINT fk_department
        FOREIGN KEY (dept_id)
        REFERENCES Departments(dept_id),
    CONSTRAINT fk_manager
        FOREIGN KEY (manager_id)
        REFERENCES Employees(emp_id)
);

INSERT INTO Employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(101, 'Rahim Chowdhury', 120000, 10, NULL);

INSERT INTO Employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(102, 'Karim Hasan', 85000, 20, 101);

INSERT INTO Employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(103, 'Nusrat Jahan', 75000, 30, 101);

INSERT INTO Employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(104, 'Tanvir Ahmed', 45000, 20, 102);

INSERT INTO Employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(105, 'Sultana Razia', 50000, 40, 101);

INSERT INTO Employees
(emp_id, emp_name, salary, dept_id, manager_id)
VALUES
(106, 'Rony Ahmed', 30000, 50, 101);

COMMIT;


CREATE TABLE salary_log (
    emp_id NUMBER,
    old_salary NUMBER,
    new_salary NUMBER,
    change_date DATE
);


CREATE TABLE Student (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    age NUMBER
);

INSERT INTO Student VALUES (1, 'Rahim', 20);
INSERT INTO Student VALUES (2, 'Karim', 21);
INSERT INTO Student VALUES (3, 'Nusrat', 19);
INSERT INTO Student VALUES (4, 'Tanvir', 22);
INSERT INTO Student VALUES (5, 'Ayesha', 20);

COMMIT;


CREATE TABLE Student_Log (
    student_id NUMBER,
    name VARCHAR2(50),
    log_date DATE
);

COMMIT;


