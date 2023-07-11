CREATE OR REPLACE FUNCTION public.sp_log_error(
  email_list_id integer,
  mailing integer,
  external_unique_id uuid,
  comment text,
  log_id integer DEFAULT NULL::integer)
RETURNS integer
AS
BEGIN
  DECLARE
    procedure_id integer;

  SELECT
    TOP (1)
    procedure_id
  FROM
    tblpl_procedures
  WITH (NOLOCK)
  WHERE
    name = ERROR_PROCEDURE();

  RAISE NOTICE ' %s - %s',
    CAST(CURRENT_TIMESTAMP AS text),
    ERROR_MESSAGE();

  RAISE NOTICE '    in %s at line %d. Error # %d, state %d, severity %d.',
    ERROR_PROCEDURE(),
    ERROR_LINE(),
    ERROR_NUMBER(),
    ERROR_STATE(),
    ERROR_SEVERITY();

  BEGIN
    INSERT INTO
      tbl_log_error(
        error_date_time,
        message,
        procedure_name,
        line,
        error_number,
        severity,
        state,
        email_list_id,
        mailing,
        external_unique_id,
        procedure_id,
        comment
      )
    VALUES
      (
        CURRENT_TIMESTAMP,
        ERROR_MESSAGE(),
        ERROR_PROCEDURE(),
        ERROR_LINE(),
        ERROR_NUMBER(),
        ERROR_SEVERITY(),
        ERROR_STATE(),
        email_list_id,
        mailing,
        external_unique_id,
        procedure_id,
        comment
      );

    SELECT
      log_id = SCOPE_IDENTITY();
  END;

  RETURN log_id;
END;