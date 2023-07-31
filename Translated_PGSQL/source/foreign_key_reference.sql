CREATE TABLE `mlconsole-poc.prajwal_test.order_items` (
  `order_id` INT64,
  `customer_id` INT64
)

ALTER TABLE `mlconsole-poc.prajwal_test.order_items` ADD CONSTRAINT `fk_order_items_order_id` FOREIGN KEY (`order_id`) REFERENCES `mlconsole-poc.prajwal_test.orders` (`order_id`);