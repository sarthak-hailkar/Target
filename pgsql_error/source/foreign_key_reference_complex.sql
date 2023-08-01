CREATE TABLE customers (
  customer_id integer,
  customer_name character varying(100),
  customer_email character varying(100)
);

-- Create the 'orders' table
CREATE TABLE orders (
  order_id integer,
  order_date date,
  customer_id integer
);

-- Create the 'products' table
CREATE TABLE products (
  product_id integer,
  product_name character varying(100),
  product_price numeric(10, 2)
);

-- Create the 'order_items' table (Assuming it already exists)
CREATE TABLE order_items (
  order_item_id integer,
  order_id integer,
  product_id integer,
  quantity integer
);

-- Add foreign key reference to 'orders' table
ALTER TABLE order_items
ADD FOREIGN KEY (order_id) REFERENCES orders(order_id);

-- Add foreign key reference to 'products' table
ALTER TABLE order_items
ADD FOREIGN KEY (product_id) REFERENCES products(product_id);