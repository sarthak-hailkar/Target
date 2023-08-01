CREATE FUNCTION Test.MyUDF(a INT64, b INT64, c INT64)
  RETURNS INT64
  AS (
    a + b - c
  );