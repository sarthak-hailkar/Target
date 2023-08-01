CREATE OR REPLACE PROCEDURE my_dataset.truncate_table(temptablename text)
                     RETURNS  text
                     LANGUAGE plpgsql
                    AS $procedure$
                    BEGIN
                        EXECUTE IMMEDIATE  'truncate table ' || temptablename;
                        RETURN 'Table truncated';
                    END;
                    $procedure$
                    ;