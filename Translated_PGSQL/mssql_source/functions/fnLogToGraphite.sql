CREATE OR REPLACE FUNCTION public.fnlogtographite(
        data text,
        host text DEFAULT 'statsd.csnzoo.com',
        port integer DEFAULT 8125
    ) RETURNS boolean
     LANGUAGE plpgsql
    AS $function$
        DECLARE
            _data text;
            _host text;
            _port integer;
        BEGIN
            SELECT INTO _data data;
            SELECT INTO _host host;
            SELECT INTO _port port;
            RETURN call graphite.graphite.logtographite(_data, _host, _port);
        END;
    $function$
    ;