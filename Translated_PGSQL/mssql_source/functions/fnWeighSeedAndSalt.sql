CREATE FUNCTION fn_weigh_seed_and_salt(
    _seed uuid,
    _salt uuid = NULL
) RETURNS TABLE AS
$$
BEGIN
SELECT
  (
    CAST(
      INT64,
      CAST(
        VARBINARY(16),
        SUBSTRING(
          CAST(
            NVARCHAR(32),
            HASHBYTES(
              'MD5',
              CONCAT(_seed, _salt)
            )
          ),
          2
        )
      ),
      2
    )
  ) AS weight;
END;
$$ LANGUAGE plpgsql;