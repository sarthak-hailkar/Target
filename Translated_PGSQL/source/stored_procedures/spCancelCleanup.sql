CREATE PROCEDURE public.sp_cancel_cleanup(
    _email_list_id integer,
    _mailing integer,
    _external_unique_id uuid DEFAULT NULL)
AS
BEGIN
    SET
        NOCOUNT ON;

    DECLARE
        _log_id integer = -1;

    DECLARE
        _log_procedure_cleanup integer = 3001;

    EXEC sp_log_run_time_start_procedure(_log_procedure_cleanup,
                                         _email_list_id,
                                         _mailing,
                                         _external_unique_id,
                                         _log_id OUTPUT);

    DECLARE
        _cancel_cleanup_status_code integer = 2;

    UPDATE
        dbo.tbl_registry_cleanup
    SET
        status_code = _cancel_cleanup_status_code
    WHERE
        email_list_id = _email_list_id
        AND mailing = _mailing
        AND started_datetime IS NULL;

    EXEC sp_log_run_time_finish_procedure(_log_id);

END;

;