SET
    ANSI_NULLS OFF;
GO
SET
    QUOTED_IDENTIFIER OFF;
GO

ALTER FUNCTION [dbo].[fnLogToGraphite](
    _data [nvarchar](4000),
    _host [nvarchar](4000) = N'statsd.csnzoo.com',
    _port [int] = 8125
) RETURNS [bit] WITH EXECUTE AS CALLER AS EXTERNAL NAME [Graphite].[Graphite.Graphite].[LogToGraphite]
GO