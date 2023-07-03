CREATE OR REPLACE PROCEDURE public.splockasynclistbuild(IN _emaillistid integer, IN _procedurename varchar(256), IN _externaluniqueid uuid, OUT _lockid integer)
     LANGUAGE plpgsql
    AS $procedure$
        DECLARE _locktypelistbuild integer := 1;
        DECLARE _locktypeasyncprocess integer := 2;
        DECLARE _islockedasyncproc boolean := 1;

        BEGIN
            BEGIN TRANSACTION;
            SELECT _islockedasyncproc INTO _islockedasyncproc
            FROM public.spislocked(_emaillistid, _locktypeasyncprocess);

            IF _islockedasyncproc = 0 THEN
                SELECT _lockid INTO _lockid
                FROM public.splock(_emaillistid, _locktypelistbuild, _procedurename, _externaluniqueid);
            END IF;

            COMMIT;
            RETURN _lockid;
        END;
    $procedure$
    ;