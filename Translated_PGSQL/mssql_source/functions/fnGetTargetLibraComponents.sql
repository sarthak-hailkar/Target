CREATE OR REPLACE FUNCTION public.fngettargetlibracomponents(integer, integer)
     RETURNS TABLE(testid integer, testgroupid integer)
     LANGUAGE plpgsql
    AS $function$
    BEGIN
        RETURN QUERY
            SELECT DISTINCT
                TestID,
                TestGroupID
            FROM
                public.csn_libra_dbo_tbltestgroup AS TestGroup
                INNER JOIN (
                    SELECT
                        UniqueID
                    FROM
                        public.dbo.tblmaptargetinclude
                    WHERE
                        EmailListID = $1
                        AND Target = $2
                    UNION
                    SELECT
                        UniqueID
                    FROM
                        public.dbo.tblmaptargetexclude
                    WHERE
                        EmailListID = $1
                        AND Target = $2
                ) AS TargetComponents ON (
                    TestGroup.TestGroupGuid = TargetComponents.UniqueID
                );
    END;
    $function$
    ;