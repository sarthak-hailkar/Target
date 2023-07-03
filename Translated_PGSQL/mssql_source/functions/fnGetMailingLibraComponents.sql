CREATE OR REPLACE FUNCTION public.fngetmailinglibracomponents(
    emaillistid integer,
    mailing integer)
RETURNS TABLE(
    testid integer,
    testgroupid integer
)
LANGUAGE plpgsql
AS $function$
BEGIN
    WITH mailingcomponents_cte AS (
        SELECT
            emaillistid,
            mailing,
            target
        FROM
            csn_notif_batch_dbo_tblmailing
        EXCEPT
        SELECT
            emaillistid,
            mailing,
            holdouttarget
        FROM
            csn_notif_batch_dbo_tblmailing
        EXCEPT
        SELECT
            emaillistid,
            mailing,
            target
        FROM
            csn_marketingemail_dbo_tblmaptargetmailingbatch
        EXCEPT
        SELECT
            emaillistid,
            mailing,
            target
        FROM
            csn_marketingemail_dbo_tblmaptargetmailingvariation
        EXCEPT
        SELECT
            mailinvariation.emaillistid,
            mailinvariation.mailing,
            eventtreatments.target
        FROM
            csn_notif_batch_dbo_tblmailingvariation AS mailinvariation
            INNER JOIN csn_marketingemail_dbo_tbleventcontentstrategytreatment AS eventtreatments ON
                ISNULL(mailinvariation.eventcontentstrategy, 1) = eventtreatments.eventcontentstrategy
                AND mailinvariation.emaillistid = eventtreatments.emaillistid
        WHERE
            eventtreatments.target IS NOT NULL
        EXCEPT
        SELECT
            mailinvariation.emaillistid,
            mailinvariation.mailing,
            skutreatments.target
        FROM
            csn_notif_batch_dbo_tblmailingvariation AS mailinvariation
            INNER JOIN csn_marketingemail_dbo_tblskucontentstrategytreatment AS skutreatments ON
                ISNULL(mailinvariation.skucontentstrategy, 1) = skutreatments.skucontentstrategy
                AND mailinvariation.emaillistid = skutreatments.emaillistid
        WHERE
            skutreatments.target IS NOT NULL
        EXCEPT
        SELECT
            mailinvariation.emaillistid,
            mailinvariation.mailing,
            arbcontenttreatments.target
        FROM
            csn_notif_batch_dbo_tblmailingvariation AS mailinvariation
            INNER JOIN csn_marketingemail_dbo_tblarbitrarycontentstrategytreatment AS arbcontenttreatments ON
                ISNULL(mailinvariation.arbitrarycontentstrategy, 1) = arbcontenttreatments.arbitrarycontentstrategy
                AND mailinvariation.emaillistid = arbcontenttreatments.emaillistid
        WHERE
            arbcontenttreatments.target IS NOT NULL
    ),
    inputmailingcomponents_cte AS (
        SELECT
            targetid
        FROM
            mailingcomponents_cte
        WHERE
            emaillistid = emaillistid
            AND mailing = mailing
    )
    SELECT
        DISTINCT testid,
        testgroupid
    FROM
        inputmailingcomponents_cte
        CROSS JOIN public.fngettargetlibracomponents(emaillistid, targetid);
END;
$function$
;