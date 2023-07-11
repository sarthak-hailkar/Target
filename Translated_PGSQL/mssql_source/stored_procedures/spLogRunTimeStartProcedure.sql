CREATE PROCEDURE public.sp_log_run_time_start_procedure(
    procedure_id integer,
    email_list_id integer DEFAULT NULL,
    mailing integer DEFAULT NULL,
    external_unique_id uuid DEFAULT NULL,
    log_id integer DEFAULT NULL)
AS
BEGIN
    SET
        NOCOUNT ON;

    SELECT
        external_unique_id
    FROM
        public.sp_create_external_unique_id(
            external_unique_id);

    DECLARE
        procedure_name character varying(256);

    SELECT
        top 1
        procedure_name
    FROM
        public.tblpl_procedures
    WHERE
        procedure_id = procedure_id;

    PERFORM
        pg_log('Starting ' + cast(procedure_name AS varchar(128)));

    INSERT INTO
        public.tbl_log_run_time(
            procedure_name,
            procedure_id,
            email_list_id,
            mailing,
            started_datetime,
            finished_datetime,
            external_unique_id)
    VALUES(
        procedure_name,
        procedure_id,
        email_list_id,
        mailing,
        current_timestamp,
        NULL,
        external_unique_id);

    SELECT
        log_id = scope_identity();

END;