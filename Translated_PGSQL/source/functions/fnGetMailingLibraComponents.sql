CREATE FUNCTION dbo.fn_get_mailing_libra_components(
    _email_list_id integer,
    _mailing integer
) RETURNS TABLE AS
RETURN (
    WITH mailing_components_cte (email_list_id, mailing, target_id) AS (
        SELECT
            email_list_id,
            mailing,
            target
        FROM
            dbo.csn_notif_batch_dbo_tbl_mailing (NOLOCK)
        UNION
        SELECT
            email_list_id,
            mailing,
            holdout_target
        FROM
            dbo.csn_notif_batch_dbo_tbl_mailing (NOLOCK)
        UNION
        SELECT
            email_list_id,
            mailing,
            target
        FROM
            dbo.csn_marketingemail_dbo_tbl_map_target_mailing_batch (NOLOCK)
        UNION
        SELECT
            email_list_id,
            mailing,
            target
        FROM
            dbo.csn_marketingemail_dbo_tbl_map_target_mailing_variation (NOLOCK)
        UNION
        SELECT
            mailing_variation.email_list_id,
            mailing_variation.mailing,
            event_treatments.target
        FROM
            dbo.csn_notif_batch_dbo_tbl_mailing_variation AS mailing_variation WITH (NOLOCK)
            INNER JOIN dbo.csn_marketingemail_dbo_tbl_event_content_strategy_treatment AS event_treatments WITH (NOLOCK) ON isnull(mailing_variation.event_content_strategy, 1) = event_treatments.event_content_strategy
            AND mailing_variation.email_list_id = event_treatments.email_list_id
        WHERE
            event_treatments.target IS NOT NULL
        UNION
        SELECT
            mailing_variation.email_list_id,
            mailing_variation.mailing,
            sku_treatments.target
        FROM
            dbo.csn_notif_batch_dbo_tbl_mailing_variation AS mailing_variation WITH (NOLOCK)
            INNER JOIN dbo.csn_marketingemail_dbo_tbl_sku_content_strategy_treatment AS sku_treatments WITH (NOLOCK) ON isnull(mailing_variation.sku_content_strategy, 1) = sku_treatments.sku_content_strategy
            AND mailing_variation.email_list_id = sku_treatments.email_list_id
        WHERE
            sku_treatments.target IS NOT NULL
        UNION
        SELECT
            mailing_variation.email_list_id,
            mailing_variation.mailing,
            arb_content_treatments.target
        FROM
            dbo.csn_notif_batch_dbo_tbl_mailing_variation AS mailing_variation WITH (NOLOCK)
            INNER JOIN dbo.csn_marketingemail_dbo_tbl_arbitrary_content_strategy_treatment AS arb_content_treatments WITH (NOLOCK) ON isnull(mailing_variation.arbitrary_content_strategy, 1) = arb_content_treatments.arbitrary_content_strategy
            AND mailing_variation.email_list_id = arb_content_treatments.email_list_id
        WHERE
            arb_content_treatments.target IS NOT NULL
    ),
    input_mailing_components_cte (target_id) AS (
        SELECT
            target_id
        FROM
            mailing_components_cte
        WHERE
            email_list_id = _email_list_id
            AND mailing = _mailing
    )
    SELECT
        DISTINCT test_id,
        test_group_id
    FROM
        input_mailing_components_cte
        CROSS APPLY dbo.fn_get_target_libra_components(_email_list_id, target_id)
);