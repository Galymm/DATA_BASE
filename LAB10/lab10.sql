CREATE DATABASE lab10;

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    title VARCHAR(50),
    author VARCHAR(50),
    price DECIMAL(10, 2),
    quantity INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    book_id INT,
    customer_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(250),
    email VARCHAR(250)
);

--Внедряем данные для таблицы Books
INSERT INTO Books (book_id, title, author, price, quantity) VALUES
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

--Внедряем данные для таблицы Customers
INSERT INTO Customers (customer_id, name, email) VALUES
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', 'janedoe@example.com');

--Транзакции для оформления заказа
BEGIN TRANSACTION;

--Добавляем новый заказ
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (1, 1, 101, '2024-12-10', 2);

--Обновляем количство книг с ID=1
UPDATE Books
SET quantity=quantity-2
WHERE book_id=1;

--Конец транзакции
COMMIT;

--Транзакция с откатом(ROLLBACK)
BEGIN TRANSACTION;

--Добавляем заказ
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (2, 3, 102, '2024-12-10', 10);

--Проверка наличия книг
DO $$
BEGIN
    IF (SELECT quantity FROM Books WHERE book_id = 3) < 10 THEN
        -- Если книг недостаточно, откатываем транзакцию
        RAISE EXCEPTION 'Not enough books in stock for order.';
    ELSE
        -- Если книг достаточно, добавляем заказ и обновляем количество
        INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
        VALUES (2, 3, 102, '2024-12-10', 10);

        UPDATE Books
        SET quantity = quantity - 10
        WHERE book_id = 3;
    END IF;
END $$;

-- Фиксируем транзакцию
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Books
SET price=25
WHERE book_id=2;
COMMIT;

BEGIN TRANSACTION;
UPDATE Customers
SET email='email@example.com'
WHERE customer_id=101;
COMMIT;


