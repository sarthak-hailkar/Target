CREATE TRIGGER safety
ON DATABASE
FOR DROP_SYNONYM
AS
BEGIN
IF (SELECT COUNT(*) FROM sys.tables WHERE object_id = OBJECT_ID('safety')) = 0
RETURN;
RAISE EXCEPTION 'You must disable Trigger ""safety"" to remove synonyms!', 10, 1;
ROLLBACK;
END;

DROP TRIGGER safety
ON DATABASE;
