CREATE OR REPLACE PROCEDURE public.spcancelcleanup(
    in _emaillistid integer,
    in _mailing integer,
    in _externaluniqueid uuid)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE
            _logid integer;
            _logprocedurecleanup integer;
            _cancelcleanupstatuscode integer;
        BEGIN
            _logid := -1;
            _logprocedurecleanup := 3001;

            CALL public.splogruntimestartprocedure(_logprocedurecleanup, _emaillistid, _mailing, _externaluniqueid, _logid);

            _cancelcleanupstatuscode := 2;

            UPDATE public.tblregistrycleanup
                SET 
                    statuscode = _cancelcleanupstatuscode
                WHERE
                    emaillistid = _emaillistid
                    AND mailing = _mailing
                    AND starteddatetime IS NULL;

            CALL public.splogruntimefinishprocedure(_logid);
        END;
    $procedure$
    ;