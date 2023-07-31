CREATE OR REPLACE PROCEDURE prajwal_test.TRUNCATE_TABLE(TEMP_TABLE_NAME STRING, TEMP_TABLE_NAME2 STRING)
                            BEGIN
                            -- Declare a variable to track the success or failure.
                            DECLARE success INT64 DEFAULT 0;
                            
                            -- Attempt to truncate the specified table.
                            BEGIN
                            EXECUTE IMMEDIATE CONCAT('TRUNCATE TABLE `', TEMP_TABLE_NAME, '`');
                            EXECUTE IMMEDIATE CONCAT('TRUNCATE TABLE `', TEMP_TABLE_NAME2, '`');
                            SET success = 1; -- Set success to 1 if the TRUNCATE TABLE statement executes successfully.
                            END;
                            
                            -- Check if the table was truncated successfully or not.
                            IF success = 1 THEN
                            SET result = 'Table truncated';
                            ELSE
                            SET result = CONCAT('Failed to truncate table: ', TEMP_TABLE_NAME);
                            END IF;
                            END;