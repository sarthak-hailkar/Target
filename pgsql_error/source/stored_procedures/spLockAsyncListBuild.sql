CREATE PROCEDURE public.sp_lock_async_list_build(
    _email_list_id integer,
    _procedure_name varchar(256),
    _external_unique_id uuid DEFAULT NULL,
    _lock_id integer DEFAULT -1::integer OUT)
AS
BEGIN
    SET
        NOCOUNT ON;

    -- LOCK TYPES
    DECLARE _lock_type_list_build integer := 1;

    DECLARE _lock_type_async_process integer := 2;

    -- IS LOCKED
    DECLARE _is_locked_async_proc bit := 1;

    BEGIN TRANSACTION;

    -- CHECK LOCKED
    EXEC _is_locked_async_proc = sp_is_locked(_email_list_id,
                                                _lock_type_async_process);

    IF _is_locked_async_proc = 0
    BEGIN
        -- ASYNC PROCESS LOCK
        EXEC _lock_id = sp_lock(_email_list_id,
                                 _lock_type_list_build,
                                 _procedure_name,
                                 _external_unique_id);

    END;

    COMMIT;

    RETURN _lock_id;

END;