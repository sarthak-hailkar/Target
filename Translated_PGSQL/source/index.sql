CREATE TABLE `mlconsole-poc.prajwal_test.simple_table` (
  `a` STRING,
  `b` INT64,
  `c` JSON
)

CREATE SEARCH INDEX my_index

ON `mlconsole-poc.prajwal_test.simple_table` (
  `a`,
  `c`
)