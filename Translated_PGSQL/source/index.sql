CREATE TABLE simple_table (
    a text,
    b int64,
    c jsonb
);

CREATE INDEX my_index
ON dataset.simple_table (a, c);
