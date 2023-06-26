CREATE FUNCTION sp_create_external_unique_id(
  _input_unique_id uuid = NULL,
  _output_unique_id uuid OUTPUT)
RETURNS uuid
AS
BEGIN
  SET
    NOCOUNT ON;

  DECLARE _external_unique_id uuid = _input_unique_id;

  IF _external_unique_id IS NULL
  AND CURRENT_CONTEXT() IS NULL
  BEGIN
    SET
      _external_unique_id = uuid_generate_v4();
  END;

  IF _external_unique_id IS NOT NULL
  BEGIN
    SET
      CURRENT_CONTEXT(_external_unique_id);
  END;

  ELSE IF CURRENT_CONTEXT() IS NOT NULL
  BEGIN
    SET
      _external_unique_id = CAST(CURRENT_CONTEXT() AS uuid);
  END;

  SET
    _output_unique_id = _external_unique_id;

  RETURN
    _output_unique_id;
END;