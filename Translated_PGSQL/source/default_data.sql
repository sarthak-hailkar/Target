CREATE TABLE `your_project.your_dataset.your_table_name` (
  `id` INT64,
  `name` STRING(50),
  `age` INT64 DEFAULT 18
);

INSERT INTO `your_project.your_dataset.your_table_name` (`id`, `name`) VALUES (1, 'John');