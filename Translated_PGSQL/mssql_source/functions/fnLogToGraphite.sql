ALTER FUNCTION public.fnlogtographite(
    _data text,
    _host text = 'statsd.csnzoo.com',
    _port integer = 8125
) RETURNS boolean AS
$$
BEGIN
    RETURN (
        SELECT logtographite(
            $1,
            $2,
            $3
        )
    );
END;
$$ LANGUAGE plpgsql;