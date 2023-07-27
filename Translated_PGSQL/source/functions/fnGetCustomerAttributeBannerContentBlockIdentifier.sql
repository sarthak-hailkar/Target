CREATE FUNCTION fn_get_customer_attribute_banner_content_block_identifier(
    _store_id integer,
    _customer_attribute_type_id integer,
    _customer_attribute integer,
    _day_number integer
)
RETURNS TABLE
AS
RETURN (
    WITH latest_target_customer_attribute_cte (customer_attribute_banner_bundle_content_id, store_id, customer_attribute_type_id, customer_attribute, day_number)
    AS
    (
        SELECT customer_attribute_banner_bundle_content_id, store_id, customer_attribute_type_id, customer_attribute, day_number
        FROM dbo.vw_latest_customer_attribute_banner_bundle_content
        WHERE store_id = _store_id
        AND customer_attribute_type_id = _customer_attribute_type_id
        AND customer_attribute = _customer_attribute
        AND day_number = _day_number
    )
    SELECT (
            REPLACE(COALESCE(email_list.name_shorthand, N'Missing_email_list_name_shorhand'), ' ', '') + '_' +
            REPLACE(REPLACE(COALESCE(customer_attribute_type.name, N'Missing_customer_attribute_type_name'), ' ', ''), 'InMarket', 'IM') + '_' +
            REPLACE(REPLACE(COALESCE(customer_attribute_store.name, N'Missing_customer_attribute_store_name'), ' ', ''), 'InMarket', 'IM') + '_' +
            COALESCE(SUBSTRING(weekdays.weekday_name, 1, 3), N'Missing_weekday_name') + '_' +
            CAST(banner_content.customer_attribute_banner_bundle_content_id AS NVARCHAR)
        ) AS content_block_identifier

    FROM latest_target_customer_attribute_cte AS banner_content

    INNER JOIN dbo.csn_notif_batch_dbo_tblpl_email_lists AS email_list (NOLOCK)
    ON (banner_content.store_id = email_list.store_id)

    INNER JOIN dbo.dbo_tblpl_customer_attribute_types AS customer_attribute_type (NOLOCK)
    ON (banner_content.customer_attribute_type_id = customer_attribute_type.customer_attribute_type_id)

    INNER JOIN dbo.dbo_tbl_customer_attribute_store AS customer_attribute_store (NOLOCK)
    ON (banner_content.store_id = customer_attribute_store.store_id
    AND banner_content.customer_attribute_type_id = customer_attribute_store.customer_attribute_type_id
    AND banner_content.customer_attribute = customer_attribute_store.customer_attribute)

    INNER JOIN dbo.dbo_tblpl_weekday AS weekdays
    ON (banner_content.day_number = weekdays.weekday_id)
);