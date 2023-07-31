CREATE TABLE `your_project.your_dataset.simple_table` (
  `a` STRING,
  `b` INT64,
  `c` JSON
);

CREATE SEARCH INDEX `my_index`
ON `your_project.your_dataset.simple_table` (
  `a`,
  `c`
);