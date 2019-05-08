DROP DATABASE IF EXISTS PizzRestaurant;
CREATE DATABASE PizzRestaurant;
USE PizzRestaurant;

CREATE TABLE customer (
	customer_id  INT AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    phone VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL
);

CREATE TABLE stores (
 store_id INT PRIMARY KEY,
 store_name VARCHAR (255) NOT NULL,
 phone VARCHAR (25),
 email VARCHAR (255),
 street VARCHAR (255),
 city VARCHAR (255),
 state VARCHAR (10),
 zip_code VARCHAR (5)
);

CREATE TABLE categories (
 category_id INT PRIMARY KEY,
 category_name VARCHAR (255) NOT NULL
);

CREATE TABLE products (
 product_id INT PRIMARY KEY,
 product_name VARCHAR (255) NOT NULL,
 category_id INT NOT NULL,
 list_price DECIMAL (10, 2) NOT NULL,
 FOREIGN KEY (category_id) 
        REFERENCES categories (category_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE address (
	address_id INT PRIMARY KEY,
	customer_id INT,
    street_address VARCHAR(50) NOT NULL,
    city VARCHAR(25) NOT NULL,
    state CHAR(2) NOT NULL,
    zip_code CHAR(5) NOT NULL,
    address_description VARCHAR(150) NOT NULL,
    FOREIGN KEY(customer_id) REFERENCES customer(customer_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE staff (
 staff_id INT PRIMARY KEY,
 first_name VARCHAR (20) NOT NULL,
 last_name VARCHAR (20) NOT NULL,
 email VARCHAR (255) NOT NULL UNIQUE,
 phone VARCHAR (25),
 store_id INT NOT NULL,
 manager_id INT,
 FOREIGN KEY (store_id) 
        REFERENCES stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (manager_id) 
        REFERENCES staff (staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE orders (
	order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIMESTAMP,
    order_status tinyint NOT NULL,
 -- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	required_date DATE NOT NULL,
    delivery_date DATE NOT NULL,
	customer_id INT,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
    FOREIGN KEY (customer_id) 
        REFERENCES customer (customer_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) 
        REFERENCES stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) 
        REFERENCES staff (staff_id) 
        ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE invoice (
	invoice_id INT PRIMARY KEY,
    order_id INT,
    total_price DECIMAL(6,2) NOT NULL,
    sales_tax DECIMAL(5,2) NOT NULL,
    discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
    total_amount DECIMAL(6,2) NOT NULL,
    FOREIGN KEY(order_id) REFERENCES orders(order_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE order_items(
 order_id INT,
 item_id INT,
 product_id INT NOT NULL,
 quantity INT NOT NULL,
 list_price DECIMAL (10, 2) NOT NULL,
 discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
 PRIMARY KEY (order_id, item_id),
 FOREIGN KEY (order_id) 
        REFERENCES orders (order_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (product_id) 
        REFERENCES products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE stocks (
 store_id INT,
 product_id INT,
 quantity INT,
 PRIMARY KEY (store_id, product_id),
 FOREIGN KEY (store_id) 
        REFERENCES stores (store_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
 FOREIGN KEY (product_id) 
        REFERENCES products (product_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO customer VALUES ('1', 'Ashraf', 'Besada', '5080000000', 'ash@besada.com');
INSERT INTO customer VALUES ('2', 'Joe', 'Hana', '5070000000', 'joe@hana.com');
INSERT INTO customer VALUES ('3', 'Trish', 'Thomas', '5090000000', 'trish@thomas.com');
INSERT INTO stores VALUES ('1', 'Shrewsbury', '5080000000', 'shrw@pizzachain.com', '33 Highland', 'Shrewsbury', 'MA', '01545');
INSERT INTO stores VALUES ('2', 'Auburn', '5080000111', 'aub@pizzachain.com', '31 Southbridge', 'Auburn', 'MA', '01005');
INSERT INTO stores VALUES ('3', 'Worcester', '5080000001', 'wor@pizzachain.com', '40 Grafton', 'Worcester', 'MA', '01604');
INSERT INTO categories VALUES ('1', 'pizza');
INSERT INTO categories VALUES ('2', 'subs');
INSERT INTO categories VALUES ('3', 'salads');
INSERT INTO products VALUES ('1', 'cheese pizza', '1', '7.99');
INSERT INTO products VALUES ('2', 'italian', '2', '5.99');
INSERT INTO products VALUES ('3', 'ceasar', '3', '4.99');
INSERT INTO address VALUES ('1', '1', '33 Hamilton st', 'Worcester', 'MA', '01604', '1st floor');
INSERT INTO address VALUES ('2', '2', '20 James st', 'Auburn', 'MA', '01005', 'back door');
INSERT INTO address VALUES ('3', '3', '17 South st', 'Shrewsbury', 'MA', '01545', 'garage door');
INSERT INTO staff VALUES ('1', 'Mark', 'Kramer', 'mark@gmail.com', '9720001110', '1', '1');
INSERT INTO staff VALUES ('2', 'Anne', 'Demulas', 'annd@gmail.com', '9720501110', '2', '2');
INSERT INTO staff VALUES ('3', 'Susan', 'Antony', 'sa3@gmail.com', '9720301110', '3', '3');
