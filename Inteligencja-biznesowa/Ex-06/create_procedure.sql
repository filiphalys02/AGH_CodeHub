-- Procedura do załadowania danych do DIM_Store
CREATE OR REPLACE PROCEDURE LoadDIM_Store()
AS $$
BEGIN
    INSERT INTO DIM_Store (store_id, name, city, street)
    SELECT store_id, name, city, street
    FROM Store
    ON CONFLICT (store_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do DIM_Employee
CREATE OR REPLACE PROCEDURE LoadDIM_Employee()
AS $$
BEGIN
    INSERT INTO DIM_Employee (employee_id, first_name, last_name, position, store_key)
    SELECT e.employee_id, e.first_name, e.last_name, e.position, s.store_key
    FROM Employee e
    JOIN DIM_Store s ON e.store_id = s.store_id
    ON CONFLICT (employee_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do DIM_Customer
CREATE OR REPLACE PROCEDURE LoadDIM_Customer()
AS $$
BEGIN
    INSERT INTO DIM_Customer (customer_id, first_name, last_name, email)
    SELECT customer_id, first_name, last_name, email
    FROM Customer
    ON CONFLICT (customer_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do DIM_Category
CREATE OR REPLACE PROCEDURE LoadDIM_Category()
AS $$
BEGIN
    INSERT INTO DIM_Category (category_id, name)
    SELECT category_id, name
    FROM Category
    ON CONFLICT (category_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do DIM_Publisher
CREATE OR REPLACE PROCEDURE LoadDIM_Publisher()
AS $$
BEGIN
    INSERT INTO DIM_Publisher (publisher_id, name, country)
    SELECT publisher_id, name, country
    FROM Publisher
    ON CONFLICT (publisher_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do DIM_Product
CREATE OR REPLACE PROCEDURE LoadDIM_Product()
AS $$
BEGIN
    INSERT INTO DIM_Product (product_id, name, price, category_key, publisher_key)
    SELECT p.product_id, p.name, p.price, c.category_key, pub.publisher_key
    FROM Product p
    JOIN DIM_Category c ON p.category_id = c.category_id
    JOIN DIM_Publisher pub ON p.publisher_id = pub.publisher_id
    ON CONFLICT (product_id) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do DIM_Date
CREATE OR REPLACE PROCEDURE LoadDIM_Date()
AS $$
BEGIN
    INSERT INTO DIM_Date (transaction_date, year, month, day, day_of_week)
    SELECT DISTINCT transaction_date,
                    EXTRACT(YEAR FROM transaction_date),
                    EXTRACT(MONTH FROM transaction_date),
                    EXTRACT(DAY FROM transaction_date),
                    EXTRACT(DOW FROM transaction_date)
    FROM Transaction
    ON CONFLICT (transaction_date) DO NOTHING;
END;
$$ LANGUAGE plpgsql;

-- Procedura do załadowania danych do FCT_Sales
CREATE OR REPLACE PROCEDURE LoadFCT_Sales()
AS $$
BEGIN
    INSERT INTO FCT_Sales (transaction_key, store_key, employee_key, customer_key, product_key, quantity, unit_price)
    SELECT
        dd.date_key,
        ds.store_key,
        de.employee_key,
        dc.customer_key,
        dp.product_key,
        td.quantity,
        td.unit_price
    FROM TransactionDetail td
    JOIN Transaction t ON td.transaction_id = t.transaction_id
    JOIN DIM_Date dd ON t.transaction_date = dd.transaction_date
    JOIN DIM_Customer dc ON t.customer_id = dc.customer_id
    JOIN DIM_Employee de ON t.employee_id = de.employee_id
    JOIN DIM_Store ds ON de.store_key = ds.store_key
    JOIN DIM_Product dp ON td.product_id = dp.product_id;
END;
$$ LANGUAGE plpgsql;