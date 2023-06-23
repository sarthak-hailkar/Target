CREATE OR REPLACE FUNCTION public.fngettargetlibracomponents(
    emaillistid integer,
    target integer)
RETURNS TABLE(
    testid integer,
    testgroupid integer
)
LANGUAGE plpgsql
AS $function$
BEGIN
    WITH targetcomponents_cte(uniqueid) AS (
        SELECT
            uniqueid
        FROM
            public.tblmaptargetinclude
        WHERE
            emaillistid = emaillistid
            AND target = target
        UNION
        SELECT
            uniqueid
        FROM
            public.tblmaptargetexclude
        WHERE
            emaillistid = emaillistid
            AND target = target
    )
    SELECT
        DISTINCT testid,
        testgroupid
    FROM
        public.csn_libra_dbo_tbltestgroup AS testgroup
        INNER JOIN targetcomponents_cte AS targetcomponents ON (
            testgroup.testgroupguid = targetcomponents.uniqueid
        )
END;
$function$
;