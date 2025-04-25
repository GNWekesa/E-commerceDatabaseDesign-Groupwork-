-- CREATE DATABASE ecommerce;
-- USE ecommerce;
-- my work

-- CREATE TABLE book (
--     book_id INT AUTO_INCREMENT PRIMARY KEY,
--     title VARCHAR(255) NOT NULL,
--     publication_year YEAR,
--     language_id INT,
--     publisher_id INT,
--     price DECIMAL(10,2),
--     stock_quantity INT
-- );

-- CREATE TABLE author (
--     author_id INT AUTO_INCREMENT PRIMARY KEY,
--     full_name VARCHAR(255) NOT NULL
-- );

-- CREATE TABLE book_author (
--     book_id INT,
--     author_id INT,
--     PRIMARY KEY (book_id, author_id),
--     FOREIGN KEY (book_id) REFERENCES book(book_id),
--     FOREIGN KEY (author_id) REFERENCES author(author_id)
-- );

-- CREATE TABLE book_language (
--     language_id INT AUTO_INCREMENT PRIMARY KEY,
--     language_name VARCHAR(100) NOT NULL
-- );

-- CREATE TABLE publisher (
--     publisher_id INT AUTO_INCREMENT PRIMARY KEY,
--     publisher_name VARCHAR(255) NOT NULL
-- );

-- CREATE TABLE customer (
--     customer_id INT AUTO_INCREMENT PRIMARY KEY,
--     full_name VARCHAR(255),
--     email VARCHAR(255) UNIQUE,
--     phone VARCHAR(20)
-- );

-- CREATE TABLE country (
--     country_id INT AUTO_INCREMENT PRIMARY KEY,
--     country_name VARCHAR(100)
-- );

-- CREATE TABLE order_status (
--     order_status_id INT AUTO_INCREMENT PRIMARY KEY,
--     status_name VARCHAR(100)
-- );

-- CREATE TABLE address_status (
--     address_status_id INT AUTO_INCREMENT PRIMARY KEY,
--     status_name VARCHAR(50)
-- );

-- CREATE TABLE shipping_method (
--     shipping_method_id INT AUTO_INCREMENT PRIMARY KEY,
--     method_name VARCHAR(100),
--     cost DECIMAL(10,2)
-- );

-- CREATE TABLE address (
--     address_id INT AUTO_INCREMENT PRIMARY KEY,
--     street VARCHAR(255),
--     city VARCHAR(100),
--     postal_code VARCHAR(20),
--     country_id INT,
--     FOREIGN KEY (country_id) REFERENCES country(country_id)
-- );

-- CREATE TABLE customer_address (
--     customer_address_id INT AUTO_INCREMENT PRIMARY KEY,
--     customer_id INT,
--     address_id INT,
--     address_status_id INT,
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
--     FOREIGN KEY (address_id) REFERENCES address(address_id),
--     FOREIGN KEY (address_status_id) REFERENCES address_status(address_status_id)
-- );

-- CREATE TABLE cust_order (
--     order_id INT AUTO_INCREMENT PRIMARY KEY,
--     customer_id INT,
--     order_date DATE,
--     shipping_method_id INT,
--     order_status_id INT,
--     FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
--     FOREIGN KEY (shipping_method_id) REFERENCES shipping_method(shipping_method_id),
--     FOREIGN KEY (order_status_id) REFERENCES order_status(order_status_id)
-- );

-- CREATE TABLE order_line (
--     order_line_id INT AUTO_INCREMENT PRIMARY KEY,
--     order_id INT,
--     book_id INT,
--     quantity INT,
--     price DECIMAL(10,2),
--     FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
--     FOREIGN KEY (book_id) REFERENCES book(book_id)
-- );

-- CREATE TABLE order_history (
--     history_id INT AUTO_INCREMENT PRIMARY KEY,
--     order_id INT,
--     status_change_date DATETIME,
--     old_status_id INT,
--     new_status_id INT,
--     FOREIGN KEY (order_id) REFERENCES cust_order(order_id),
--     FOREIGN KEY (old_status_id) REFERENCES order_status(order_status_id),
--     FOREIGN KEY (new_status_id) REFERENCES order_status(order_status_id)
-- );

--  General Product Table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    base_price DECIMAL(10,2),
    category_id INT,
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (category_id) REFERENCES product_category(category_id)
);

--  Brand Table
CREATE TABLE brand (
    brand_id INT AUTO_INCREMENT PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

--  Product Category Table
CREATE TABLE product_category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

--  Product Item Table (specific SKU/variant that is sold)
CREATE TABLE product_item (
    product_item_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    sku VARCHAR(100) UNIQUE,
    price DECIMAL(10,2),
    stock_quantity INT,
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

--  Product Variation Table (links to specific color/size)
CREATE TABLE product_variation (
    variation_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    color_id INT,
    size_option_id INT,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(size_option_id)
);

--  Color Table
CREATE TABLE color (
    color_id INT AUTO_INCREMENT PRIMARY KEY,
    color_name VARCHAR(50) NOT NULL
);

--  Size Category Table (e.g., "Clothing Sizes", "Shoe Sizes")
CREATE TABLE size_category (
    size_category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

--  Size Option Table (e.g., "S", "M", "L", "42")
CREATE TABLE size_option (
    size_option_id INT AUTO_INCREMENT PRIMARY KEY,
    size_label VARCHAR(50) NOT NULL,
    size_category_id INT,
    FOREIGN KEY (size_category_id) REFERENCES size_category(size_category_id)
);

-- Product Image Table
CREATE TABLE product_image (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    image_url TEXT NOT NULL,
    is_primary BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id)
);

--  Attribute Category Table (e.g., Physical, Technical)
CREATE TABLE attribute_category (
    attribute_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Attribute Type Table (text, number, boolean)
CREATE TABLE attribute_type (
    attribute_type_id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50) NOT NULL
);

-- Product Attribute Table (actual attribute values)
CREATE TABLE product_attribute (
    attribute_id INT AUTO_INCREMENT PRIMARY KEY,
    product_item_id INT,
    attribute_category_id INT,
    attribute_type_id INT,
    attribute_name VARCHAR(100) NOT NULL,
    attribute_value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_item_id) REFERENCES product_item(product_item_id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(attribute_category_id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(attribute_type_id)
);
