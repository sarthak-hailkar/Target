CREATE PROCEDURE spLogRunTimeStartProcedure(
    _ProcedureID INT,
    _EmailListID INT = NULL,
    _Mailing INT = NULL,
    _ExternalUniqueID UUID = NULL,
    _LogID INT OUTPUT)
AS
BEGIN
    SET
        NOCOUNT ON;

    SELECT
        1 AS _ProcedureName;

    INSERT INTO
        tblLogRunTime(
            ProcedureName,
            ProcedureID,
            EmailListID,
            Mailing,
            StartedDatetime,
            FinishedDatetime,
            ExternalUniqueID
        )
    VALUES
        (
            _ProcedureName,
            _ProcedureID,
            _EmailListID,
            _Mailing,
            CURRENT_TIMESTAMP,
            NULL,
            _ExternalUniqueID
        );

    SELECT
        _LogID = SCOPE_IDENTITY();

END;