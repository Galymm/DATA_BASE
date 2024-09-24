
CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

ALTER TABLE users
ADD COLUMN isadmin INTEGER;

CREATE TABLE new_users(
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    isadmin BOOLEAN
);

INSERT INTO new_users(id, first_name, last_name, isadmin)
SELECT id, first_name, last_name, isadmin FROM users;

DROP TABLE users;

ALTER TABLE new_users RENAME TO users;

CREATE TABLE new_users(
    id INTEGER PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    isadmin BOOLEAN DEFAULT false
);

INSERT INTO new_users(id, first_name, last_name, isadmin)
SELECT id, first_name, last_name, isadmin FROM users;

DROP TABLE users;

ALTER TABLE new_users RENAME TO users;

CREATE TABLE IF NOT EXISTS tasks(
    id AUTO INCREMENT INTEGER,
    name VARCHAR(50),
    user_id INTEGER
);

INSERT INTO tasks(id, name)
SELECT id,first_name FROM users;

DROP TABLE tasks;
