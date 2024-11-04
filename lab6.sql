-- step 1
CREATE DATABASE lab6;

-- step 2
CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_addres VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

CREATE TABLE employees(
    emplloyee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

DO
$$
    DECLARE
        i INTEGER := 0;
    BEGIN
        WHILE i < 100
            LOOP
                INSERT INTO locations (street_addres, postal_code, city, state_province)
                VALUES (LEFT(md5(random()::text || clock_timestamp()::text), 25),
                        LEFT(md5(random()::text || clock_timestamp()::text), 12),
                        LEFT(md5(random()::text || clock_timestamp()::text), 30),
                        LEFT(md5(random()::text || clock_timestamp()::text), 12));
                i := i + 1;
            END LOOP;
    END
$$;

DO
$$
    DECLARE
        i INTEGER := 0;
    BEGIN
        WHILE i < 50
        LOOP
            INSERT INTO departments (department_name, budget, location_id)
            VALUES (
                LEFT(md5(random()::text || clock_timestamp()::text), 50),
                (random() * 100000)::INTEGER,
                (SELECT location_id FROM locations ORDER BY random() LIMIT 1)
            );
            i := i + 1;
        END LOOP;
    END
$$;

DO
$$
    DECLARE
        i INTEGER := 0;
    BEGIN
        WHILE i < 200  -- Вставим 200 случайных сотрудников
        LOOP
            INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
            VALUES (
                LEFT(md5(random()::text || clock_timestamp()::text), 50),
                LEFT(md5(random()::text || clock_timestamp()::text), 50),
                LEFT(md5(random()::text || clock_timestamp()::text), 50) || '@example.com',
                LEFT(md5(random()::text || clock_timestamp()::text), 20),
                (random() * 100000)::INTEGER,
                (SELECT department_id FROM departments ORDER BY random() LIMIT 1)
            );
            i := i + 1;
        END LOOP;
    END
$$;

--step 3
SELECT  e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id=d.department_id;

--step 4
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
JOIN departments d ON e.department_id=d.department_id
WHERE e.department_id IN (80, 40);

--step 5
SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e
JOIN departments d on e.department_id = d.department_id
JOIN locations l on d.location_id = l.location_id;

--step 6
SELECT d.department_name, e.first_name, e.last_name
FROM departments d
LEFT JOIN employees e on d.department_id = e.department_id;

--step 7
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e
LEFT JOIN departments d on e.department_id = d.department_id;
