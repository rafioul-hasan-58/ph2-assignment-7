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
    order_date DATE NOT NULL DEFAULT CURRENT_DATE
)