SELECT TOP(1000) dbname, numberofconnections, loginname
  FROM mssql_to_pgsql_pgloader.dbo.activeuserconnections;

CREATE PROCEDURE usp_find_products()
AS
BEGIN
SELECT
dbname,
numberofconnections,
loginname
FROM
mssql_to_pgsql_pgloader.dbo.activeuserconnections
ORDER BY
numberofconnections;
END;

ALTER PROCEDURE usp_find_products(min_list_price DECIMAL)
AS
BEGIN
UPDATE mssql_to_pgsql_pgloader.dbo.activeuserconnections
SET numberofconnections = numberofconnections + 1
WHERE numberofconnections < min_list_price;

UPDATE mssql_to_pgsql_pgloader.dbo.activeuserconnections
SET numberofconnections = numberofconnections - 1
WHERE numberofconnections < min_list_price;

END;


CALL usp_find_products(5);

SELECT TOP(1000) dbname, numberofconnections, loginname
  FROM mssql_to_pgsql_pgloader.dbo.activeuserconnections;