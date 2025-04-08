-- Active: 1743933960278@@127.0.0.1@5432@assignment

-- Creating the books table
CREATE TABLE books(
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    author VARCHAR(50) NOT NULL,
    price NUMERIC NOT NULL CHECK (price>=0),
    stock INT NOT NULL CHECK (stock>=0),
    published_year INT
)

-- creating the customers table
CREATE TABLE customers(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    joined_date DATE NOT NULL DEFAULT CURRENT_DATE
)

-- creating the orders table
CREATE TABLE orders(
    id SERIAL PRIMARY KEY,
    customer_id INTEGER REFERENCES customers(id),
    book_id INTEGER REFERENCES books(id),
    quantity INT NOT NULL CHECK (quantity>0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
)

-- inserting data into books table
INSERT INTO books (title, author, price, stock, published_year) VALUES
('INFERNO', 'Dan Brown', 10.99, 0, 1960),
('3am', 'Nic perock', 9.99, 0, 1949),
('The Alchemist', 'Pawlo coelho', 8.50, 0, 1813),
('The Name of Prodhan', 'sourav', 12.00, 0, 1925);

-- inserting data into customers table
INSERT INTO customers (name,email) VALUES('Mitu','mitu@gmail.com')

-- inserting data into orders table
INSERT INTO orders (customer_id,book_id,quantity) VALUES
(2,1,3)



-- solving problems

-- problem:1️⃣ (find the books that are out of stock)
SELECT * FROM books WHERE stock=0;

-- problem:2️⃣ (find the most expensive book)
SELECT max(price) as expensive_book FROM books

-- problem:3️⃣ (find the total number of books ordered by each customer)
SELECT name,count(*) as total_orders FROM orders
JOIN customers on orders.customer_id=customers.id 
GROUP BY name

-- problem:4️⃣ (calculate the total revenue sold from all orders)
SELECT SUM(o.quantity*b.price) as total_revenue FROM orders as o
JOIN books as b ON o.book_id=b.id


-- problem:5️⃣ (who ordered more than 1 book)
SELECT c.name,count(o.id) as orders_count FROM orders as o
JOIN customers as c on o.customer_id=c.id 
GROUP BY c.name

-- problem:6️⃣ (find the avg price of books)
SELECT ROUND(AVG(price),2) as avg_book_price FROM books

-- problem:7️⃣ (increase book price 10% for all books published before 2000)
UPDATE books SET price=ROUND(price*1.1,2) WHERE published_year<2000;

-- problem:8️⃣ (delete customer who has not placed any orders)
DELETE FROM customers 
WHERE id IN (SELECT customers.id FROM orders 
RIGHT JOIN customers ON orders.customer_id=customers.id
WHERE orders.customer_id IS NULL)



