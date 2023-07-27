CREATE PROCEDURE public.sp_create_external_unique_id(
    _input_unique_id uuid = NULL,
    _output_unique_id uuid OUT)
AS
BEGIN
    SET
        NOCOUNT ON;

    DECLARE
        _external_unique_id uuid = _input_unique_id;

    IF _external_unique_id IS NULL
        AND CONTEXT_INFO() IS NULL
    BEGIN
        SET
            _external_unique_id = NEWID();
    END;

    IF _external_unique_id IS NOT NULL
    BEGIN
        SET
            CONTEXT_INFO _external_unique_id;
    END;

    ELSE IF CONTEXT_INFO() IS NOT NULL
    BEGIN
        SET
            _external_unique_id = CAST(CONTEXT_INFO() AS uuid);
    END;

    SET
        _output_unique_id = _external_unique_id;
END;