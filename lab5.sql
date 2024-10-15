CREATE DATABASE lab5;

\c lab5;

CREATE TABLE customers(
    customer_id SERIAL PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(100),
    grade INT,
    salesman_id INT
);

CREATE TABLE orders(
    ord_no INT,
    purch_amt FLOAT,
    ord_date DATE,
    customer_id SERIAL PRIMARY KEY,
    salesman_id INT
);

CREATE TABLE salesman(
    salesman_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    commission FLOAT
);

INSERT INTO customers VALUES(3002, 'Nick Rimando', 'New York', 100,5001);
INSERT INTO customers VALUES(3005, 'Graham Zusi', 'California', 200,5002);
INSERT INTO customers VALUES(3001, 'Brad Guzan', 'London', NULL,5005);
INSERT INTO customers VALUES(3004, 'Fabian Johns', 'Paris', 300,5006);
INSERT INTO customers VALUES(3007, 'Brad Davis', 'New York', 200,5001);
INSERT INTO customers VALUES(3009, 'Geoff Camero', 'Berlin', 100,5003);
INSERT INTO customers VALUES(3008, 'Julian Green', 'London', 300,5002);

INSERT INTO orders VALUES(70001, 150.8, '2012-10-05', 3005,5001);
INSERT INTO orders VALUES(70009, 270.65, '2012-09-10', 3001,5001);
INSERT INTO orders VALUES(70002, 65.26, '2012-10-05', 3002,5001);
INSERT INTO orders VALUES(70004, 110.5, '2012-08-17', 3009,5001);
INSERT INTO orders VALUES(70007, 948.5, '2012-09-10', 3005,5001);
INSERT INTO orders VALUES(70005, 2400.6, '2012-07-27', 3007,5001);
INSERT INTO orders VALUES(70008, 5760, '2012-09-10', 3002,5001);

INSERT INTO salesman VALUES(5001,'James Hoog','New York',0.15);
INSERT INTO salesman VALUES(5002,'Nail Knite','Paris',0.13);
INSERT INTO salesman VALUES(5005,'Pit Alex','London',0.11);
INSERT INTO salesman VALUES(5006,'Mc Lyon','Paris',0.14);
INSERT INTO salesman VALUES(5003,'Lauson Hen',NULL,0.12);
INSERT INTO salesman VALUES(5007,'Paul Adam','Rome',0.13);

/*Находим сумму всех заказов*/
SELECT SUM(purch_amt) AS total_amount FROM orders;

/*Находим среднюю сумму всех заказов*/
SELECT AVG(purch_amt) AS average_purchase_amount FROM orders;

/*Кол-во клиентов указавщих свои имена*/
SELECT COUNT(cust_name) AS cust_with_names FROM customers
    WHERE cust_name IS NOT NULL;

/*Минимальная сумма заказа*/
SELECT MIN(purch_amt) AS min_amount FROM orders;

/*Клиенты с буквой b в конце имени*/
SELECT * FROM customers
    WHERE cust_name LIKE '%b';

/*Заказы сделанные клиентами с города New York*/
SELECT o.* FROM orders o JOIN customers c ON o.customer_id = c.customer_id
    WHERE c.city = 'New York';

/*Клиенты имеющие заказы более 10*/
SELECT c.* FROM customers c JOIN orders o ON c.customer_id = o.customer_id
    WHERE o.purch_amt > 10;

/*Общая оценка клиентов*/
SELECT SUM(grade) AS total_grade FROM customers;

/*Клиенты указавщие свои имена*/
SELECT * FROM customers WHERE cust_name IS NOT NULL;

/*Максимальная оценка всех клиентов*/
SELECT MAX(grade) AS maximum_grade FROM customers;
