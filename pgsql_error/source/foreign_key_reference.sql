CREATE TABLE order_items (
    order_id integer,
    customer_id integer
);

ALTER TABLE order_items ADD CONSTRAINT fk_order_items_order_id FOREIGN KEY (order_id) REFERENCES orders (order_id);
