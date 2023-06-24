CREATE OR REPLACE PROCEDURE public.splockasynclistbuild(
    IN _emaillistid integer,
    IN _procedurename character varying,
    IN _externaluniqueid uuid,
    OUT _lockid integer)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE
            _locktypelistbuild integer;
            _locktypeasyncprocess integer;
            _islockedasyncproc boolean;
        BEGIN
            _locktypelistbuild := 1;
            _locktypeasyncprocess := 2;
            _islockedasyncproc := 1;

            BEGIN
                SELECT INTO _islockedasyncproc
                    spIsLocked(_emaillistid, _locktypeasyncprocess);

                IF _islockedasyncproc = 0 THEN
                    SELECT INTO _lockid
                        spLock(_emaillistid, _locktypelistbuild, _procedurename, _externaluniqueid);
                END IF;

            COMMIT;

            RETURN _lockid;
        END;
    $procedure$
    ;