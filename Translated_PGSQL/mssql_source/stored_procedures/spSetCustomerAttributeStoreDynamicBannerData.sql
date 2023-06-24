CREATE OR REPLACE PROCEDURE public.spsetcustomerattributestoredynamicbannerdata(
    storeid integer,
    customerattributetypeid integer,
    customerattribute integer,
    daynumber integer,
    launchurl text,
    imageurl text,
    alttext text,
    subjectline text,
    istask bit,
    username text)
    LANGUAGE plpgsql
AS $function$
DECLARE
    now timestamp with time zone := cast(current_timestamp as timestamp with time zone);
BEGIN
    IF istask = 0 THEN
        UPDATE
            public.tblrulescustomerattributebanner
        SET
            istask = istask,
            lastupdatedby = username,
            datetimechanged = now
        WHERE
            storeid = storeid
            AND customerattributetypeid = customerattributetypeid
            AND customerattribute = customerattribute
            AND daynumber = daynumber;
    END IF;
    ELSE
        IF NOT EXISTS (
            SELECT
                top 1 1
            FROM
                public.vwlatestcustomerattributebannerbundlecontent
            WHERE
                storeid = storeid
                AND customerattributetypeid = customerattributetypeid
                AND customerattribute = customerattribute
                AND daynumber = daynumber
                AND launchurl = launchurl
                AND imageurl = imageurl
                -- Perform a case-sensitive comparison
                AND convert(text, ltrim(rtrim(alttext))) = convert(text, ltrim(rtrim(alttext)))
        ) THEN
            INSERT INTO
                public.tblcustomerattributebannerbundlecontent (
                    storeid,
                    customerattributetypeid,
                    customerattribute,
                    daynumber,
                    launchurl,
                    imageurl,
                    alttext,
                    username,
                    datetimeadded,
                    subjectline
                )
            VALUES (
                storeid,
                customerattributetypeid,
                customerattribute,
                daynumber,
                launchurl,
                imageurl,
                alttext,
                username,
                now,
                subjectline
            );
        END IF;
        SELECT
            contentblockidentifier
        INTO
            contentblockidentifier
        FROM
            public.fngetcustomerattributebannercontentblockidentifier(
                storeid,
                customerattributetypeid,
                customerattribute,
                daynumber
            );
        UPDATE
            public.tblrulescustomerattributebanner
        SET
            contentblock = contentblockidentifier,
            subjectline = subjectline,
            istask = istask,
            lastupdatedby = username,
            datetimechanged = now
        WHERE
            storeid = storeid
            AND customerattributetypeid = customerattributetypeid
            AND customerattribute = customerattribute
            AND daynumber = daynumber;
    END IF;
END;
$function$
;