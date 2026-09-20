CREATE OR REPLACE TRIGGER trg_student_insert
AFTER INSERT ON Student
FOR EACH ROW
BEGIN
    INSERT INTO Student_Log
    VALUES (:NEW.student_id, :NEW.name, SYSDATE);
END;
/


CREATE OR REPLACE TRIGGER trg_salary_update
AFTER UPDATE OF salary ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_log
    VALUES (
        :OLD.emp_id,
        :OLD.salary,
        :NEW.salary,
        SYSDATE
    );
END;
/


CREATE OR REPLACE TRIGGER trg_before_employee
BEFORE INSERT ON Employees
FOR EACH ROW
BEGIN
    IF :NEW.salary < 20000 THEN
        :NEW.salary := 20000;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_before_salary_update
BEFORE UPDATE OF salary ON Employees
FOR EACH ROW
BEGIN
    IF :NEW.salary < 0 THEN
        :NEW.salary := 0;
    END IF;
END;
/


CREATE OR REPLACE TRIGGER trg_before_delete
BEFORE DELETE ON Employees
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Employee ' || :OLD.emp_name || ' will be deleted.'
    );
END;
/


CREATE OR REPLACE TRIGGER trg_employee_delete
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_log
    VALUES (
        :OLD.emp_id,
        :OLD.salary,
        NULL,
        SYSDATE
    );
END;
/


DECLARE
    v_rows_updated NUMBER;
BEGIN
    UPDATE Employees
    SET salary = salary + (salary * 0.10)
    WHERE dept_id = 20;

    IF SQL%FOUND THEN
        v_rows_updated := SQL%ROWCOUNT;
        DBMS_OUTPUT.PUT_LINE(
            'Total ' || v_rows_updated || ' employees updated.'
        );
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'No employee was updated.'
        );
    END IF;

    COMMIT;
END;
/


DECLARE
    CURSOR c_emp IS
        SELECT emp_id, emp_name, salary
        FROM Employees
        WHERE dept_id = 20;

    v_id Employees.emp_id%TYPE;
    v_name Employees.emp_name%TYPE;
    v_salary Employees.salary%TYPE;

BEGIN
    OPEN c_emp;

    LOOP
        FETCH c_emp INTO v_id, v_name, v_salary;

        EXIT WHEN c_emp%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_id ||
            ' | Name: ' || v_name ||
            ' | Salary: ' || v_salary
        );
    END LOOP;

    CLOSE c_emp;
END;
/


DECLARE
    CURSOR c_emp IS
        SELECT emp_id, emp_name, salary
        FROM Employees;

BEGIN
    FOR emp_record IN c_emp LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || emp_record.emp_id ||
            ' | Name: ' || emp_record.emp_name ||
            ' | Salary: ' || emp_record.salary
        );
    END LOOP;
END;
/


DECLARE
    v_emp_id Employees.emp_id%TYPE := 101;
    v_emp_name Employees.emp_name%TYPE;
    v_salary Employees.salary%TYPE;

BEGIN
    SELECT emp_name, salary
    INTO v_emp_name, v_salary
    FROM Employees
    WHERE emp_id = v_emp_id;

    DBMS_OUTPUT.PUT_LINE(
        'Employee Name: ' || v_emp_name ||
        ' | Salary: ' || v_salary
    );
END;
/
