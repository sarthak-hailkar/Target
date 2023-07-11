ALTER FUNCTION public.fn_log_to_graphite(
    _data text,
    _host text = 'statsd.csnzoo.com',
    _port integer = 8125
) RETURNS boolean AS
$$
BEGIN
    RETURN (
        SELECT 1
        FROM pg_catalog.pg_stat_activity
        WHERE usename = current_user
    );
END;
$$ LANGUAGE plpgsql;