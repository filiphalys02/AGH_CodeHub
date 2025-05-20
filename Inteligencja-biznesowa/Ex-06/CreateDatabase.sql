--DROP TABLE Store CASCADE;
--DROP TABLE Employee CASCADE;
--DROP TABLE Customer CASCADE;
--DROP TABLE Category CASCADE;
--DROP TABLE Publisher CASCADE;
--DROP TABLE Product CASCADE;
--DROP TABLE Transaction CASCADE;
--DROP TABLE TransactionDetail CASCADE;

-- OLTP

-- 1. Store
CREATE TABLE Store (
    store_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100),
    street VARCHAR(100)
);

-- 2. Employee
CREATE TABLE Employee (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    store_id INT REFERENCES Store(store_id)
);

-- 3. Customer
CREATE TABLE Customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

-- 4. Category
CREATE TABLE Category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

-- 5. Publisher
CREATE TABLE Publisher (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    country VARCHAR(50)
);

-- 6. Product
CREATE TABLE Product (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category_id INT REFERENCES Category(category_id),
    publisher_id INT REFERENCES Publisher(publisher_id)
);

-- 7. Transaction
CREATE TABLE Transaction (
    transaction_id SERIAL PRIMARY KEY,
    transaction_date DATE,
    customer_id INT REFERENCES Customer(customer_id),
    employee_id INT REFERENCES Employee(employee_id)
);

-- 8. Transaction Detail
CREATE TABLE TransactionDetail (
    detail_id SERIAL PRIMARY KEY,
    transaction_id INT REFERENCES Transaction(transaction_id),
    product_id INT REFERENCES Product(product_id),
    quantity INT,
    unit_price DECIMAL(10,2)
);

-- OLAP
-- Tabele wymiarów
CREATE TABLE DIM_Store (
    store_key SERIAL PRIMARY KEY,
    store_id INT UNIQUE,
    name VARCHAR(100),
    city VARCHAR(100),
    street VARCHAR(100)
);

CREATE TABLE DIM_Employee (
    employee_key SERIAL PRIMARY KEY,
    employee_id INT UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    position VARCHAR(50),
    store_key INT REFERENCES DIM_Store(store_key)
);

CREATE TABLE DIM_Customer (
    customer_key SERIAL PRIMARY KEY,
    customer_id INT UNIQUE,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100)
);

CREATE TABLE DIM_Category (
    category_key SERIAL PRIMARY KEY,
    category_id INT UNIQUE,
    name VARCHAR(50)
);

CREATE TABLE DIM_Publisher (
    publisher_key SERIAL PRIMARY KEY,
    publisher_id INT UNIQUE,
    name VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE DIM_Product (
    product_key SERIAL PRIMARY KEY,
    product_id INT UNIQUE,
    name VARCHAR(100),
    price DECIMAL(10,2),
    category_key INT REFERENCES DIM_Category(category_key),
    publisher_key INT REFERENCES DIM_Publisher(publisher_key)
);

CREATE TABLE DIM_Date (
    date_key SERIAL PRIMARY KEY,
    transaction_date DATE UNIQUE,
    year INT,
    month INT,
    day INT,
    day_of_week INT
);

CREATE TABLE FCT_Sales (
    sales_key SERIAL PRIMARY KEY,
    transaction_key INT REFERENCES DIM_Date(date_key),
    store_key INT REFERENCES DIM_Store(store_key),
    employee_key INT REFERENCES DIM_Employee(employee_key),
    customer_key INT REFERENCES DIM_Customer(customer_key),
    product_key INT REFERENCES DIM_Product(product_key),
    quantity INT,
    unit_price DECIMAL(10,2)
);
