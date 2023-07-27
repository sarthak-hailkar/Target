CREATE PROCEDURE public.sp_log_run_time_start_procedure(
    _procedure_id integer,
    _email_list_id integer DEFAULT NULL,
    _mailing integer DEFAULT NULL,
    _external_unique_id uuid DEFAULT NULL,
    _log_id integer OUT)
AS
BEGIN
    SET
        NOCOUNT ON;

    EXEC sp_create_external_unique_id(
        _input_unique_id = _external_unique_id,
        _output_unique_id = _external_unique_id::uuid
    );

    DECLARE
        _procedure_name varchar(256);

    SELECT
        TOP 1
            _procedure_name = name
        FROM
            tblpl_procedures
        WITH (NOLOCK)
        WHERE
            procedure_id = _procedure_id;

    RAISE NOTICE 'Starting %', CAST(_procedure_name AS VARCHAR(128));

    INSERT INTO
        tbl_log_run_time(
            procedure_name,
            procedure_id,
            email_list_id,
            mailing,
            started_datetime,
            finished_datetime,
            external_unique_id
        )
    VALUES(
        _procedure_name,
        _procedure_id,
        _email_list_id,
        _mailing,
        GETDATE(),
        NULL,
        _external_unique_id::uuid
    );

    SELECT
        _log_id = SCOPE_IDENTITY();

END;