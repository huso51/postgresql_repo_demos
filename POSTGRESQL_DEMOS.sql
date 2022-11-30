INSERT INTO huseyin_schema."Employee"("FIRST_NAME", "LAST_NAME", "DOB", "ADDRESS") 
VALUES('HASAN', 'AYDIN', '01-08-1938', 'TIRHAN KOYU');
CREATE SEQUENCE huseyin_schema.employee_id_seq
    INCREMENT 1
    START 1
    MINVALUE 1
    CACHE 50;

ALTER SEQUENCE huseyin_schema.employee_id_seq
    OWNER TO postgres;

COMMENT ON SEQUENCE huseyin_schema.employee_id_seq
    IS 'Çalışan sırası';
CREATE TABLE IF NOT EXISTS huseyin_schema."Employee"
(
    "ID" integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    "FIRST_NAME" text COLLATE pg_catalog."default" NOT NULL,
    "LAST_NAME" text COLLATE pg_catalog."default" NOT NULL,
    "DOB" date NOT NULL,
    "ADDRESS" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT "PK_CONSTRAINTS_ID" PRIMARY KEY ("ID")
)

CREATE OR REPLACE FUNCTION log_last_name_changes()
  RETURNS TRIGGER 
  LANGUAGE PLPGSQL
  AS
$$
BEGIN
SELECT 'SELAM';
	INSERT INTO huseyin_schema."Employee"("ID")
	VALUES(OLD.id);
	RETURN NEW;
END;
$$

CREATE TRIGGER last_name_changes
  BEFORE UPDATE
  ON huseyin_schema."Employee"
  FOR EACH ROW
  EXECUTE PROCEDURE log_last_name_changes();