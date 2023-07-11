CREATE PROCEDURE sp_cancel_cleanup(
    email_list_id integer,
    mailing integer,
    external_unique_id uuid DEFAULT NULL)
AS
BEGIN
    SET
        NOCOUNT ON;

    DECLARE log_id integer;

    DECLARE log_procedure_cleanup integer;

    EXEC sp_log_run_time_start_procedure(
        log_procedure_cleanup,
        email_list_id,
        mailing,
        external_unique_id,
        log_id OUT);

    DECLARE cancel_cleanup_status_code integer;

    UPDATE
        tbl_registry_cleanup
    SET
        code = cancel_cleanup_status_code
    WHERE
        email_list_id = email_list_id
        AND mailing = mailing
        AND started_datetime IS NULL;

    EXEC sp_log_run_time_finish_procedure(log_id);

END;

;