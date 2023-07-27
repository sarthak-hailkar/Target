CREATE FUNCTION [dbo].[fnLogToGraphite](
    _data NVARCHAR(4000),
    _host NVARCHAR(4000) = N'statsd.csnzoo.com',
    _port INT = 8125
) RETURNS BIT WITH EXECUTE AS CALLER AS
BEGIN
    RETURN EXTERNAL 'Graphite.Graphite.LogToGraphite'
        (
            CAST(_data AS VARCHAR),
            CAST(_host AS VARCHAR),
            CAST(_port AS INT)
        );
END;