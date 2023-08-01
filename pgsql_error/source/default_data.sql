CREATE TABLE your_table_name (
  id integer,
  name character varying(50),
  age integer DEFAULT 18
);

INSERT INTO your_table_name(id,name) VALUES(1,'John');