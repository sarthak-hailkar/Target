CREATE OR REPLACE PROCEDURE create_table_with_sequence()
     LANGUAGE plpgsql
AS $procedure$
BEGIN

    -- Step 1: Create the Sequence
    EXECUTE IMMEDIATE '
CREATE SEQUENCE seq_example
START WITH 1
INCREMENT BY 1
NO CYCLE;
';

    -- Step 2: Create the Table
    EXECUTE IMMEDIATE '
CREATE TABLE your_table (
    id_column INTEGER PRIMARY KEY,
);
';

    -- Step 3: Insert Data into the Table using the Sequence
    DECLARE
        v_id INTEGER;
    BEGIN
        -- Insert first row
        SELECT nextval('seq_example') INTO v_id;
        INSERT INTO your_table (id_column) VALUES (v_id);

        -- Insert second row
        SELECT nextval('seq_example') INTO v_id;
        INSERT INTO your_table (id_column) VALUES (v_id);

        -- You can add more INSERT statements for additional rows as needed.
    END;
END;
$procedure$
;