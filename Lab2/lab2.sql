CREATE DATABASE lab_2;

CREATE TABLE countries(
    country_id INTEGER PRIMARY KEY,
    country_name VARCHAR(50),
    region_id INTEGER,
    population INTEGER
);

INSERT INTO countries(country_name, region_id, population)
    VALUES ('Kazakhstan',2, 20000000);

INSERT INTO countries(country_id, country_name)
    VALUES(2, 'Russia');

INSERT INTO countries(country_name, region_id, population)
    VALUES('India', NULL,1428627663);

INSERT INTO countries(country_name, region_id, population) VALUES
    ('USA',1,336023460),
    ('China',3,1438083000),
    ('Spain',4,25000000);

ALTER TABLE countries
    ALTER COLUMN country_name SET DEFAULT 'Kazakhstan';

INSERT INTO countries(region_id, population)
    VALUES(5, 4000000);

INSERT INTO countries DEFAULT VALUES;

CREATE TABLE countries_new(LIKE countries);

INSERT INTO countries_new
    SELECT * FROM countries;

UPDATE countries SET region_id = 1
    WHERE countries.region_id IS NULL;

UPDATE countries SET population = population * 1.1
    WHERE population IS NOT NULL
    RETURNING country_name, population AS "New Population";

DELETE FROM countries
    WHERE population < 100000;

DELETE FROM countries_new
    WHERE country_id IN (SELECT country_id FROM countries)
    RETURNING *;

DELETE FROM countries
    RETURNING *;
