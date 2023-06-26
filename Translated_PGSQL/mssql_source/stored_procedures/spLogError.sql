CREATE OR REPLACE PROCEDURE public.splogerror(IN _emaillistid integer, IN _mailing integer, IN _externaluniqueid uuid, IN _comment text, OUT _logid integer)
     LANGUAGE plpgsql
    AS $procedure$
    BEGIN
        DECLARE _procedureid integer;

        BEGIN
            SELECT
                TOP (1) _procedureid
            FROM
                tblplprocedures
            WHERE
                name = current_user;

            RAISE NOTICE 'Error: %s', current_user;

            RAISE NOTICE '    in %s at line %d. Error # %d, state %d, severity %d.',
                    current_user,
                    ERROR_LINE(),
                    ERROR_NUMBER(),
                    ERROR_STATE(),
                    ERROR_SEVERITY();

        END;

        INSERT INTO tbllogerror(
            errordatetime,
            message,
            procedurename,
            line,
            errornumber,
            severity,
            state,
            emaillistid,
            mailing,
            externaluniqueid,
            procedureid,
            comment
        )
        VALUES(
            CURRENT_TIMESTAMP,
            ERROR_MESSAGE(),
            current_user,
            ERROR_LINE(),
            ERROR_NUMBER(),
            ERROR_SEVERITY(),
            ERROR_STATE(),
            _emaillistid,
            _mailing,
            _externaluniqueid,
            _procedureid,
            _comment
        );

        SELECT currval(pg_get_serial_sequence('tblLogError', 'logid')) INTO _logid;
    END;
    $procedure$
    ;