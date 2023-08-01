CREATE OR REPLACE FUNCTION factorial_function(number_arg integer)
     RETURNS bigint
     LANGUAGE plpgsql
AS $function$
BEGIN
    DECLARE
        result bigint;
    BEGIN
        IF number_arg < 0 THEN
            RAISE EXCEPTION 'Factorial is not defined for negative numbers.';
        ELSIF number_arg = 0 OR number_arg = 1 THEN
            result := 1;
        ELSE
            result := number_arg * factorial_function(number_arg - 1);
        END IF;
        RETURN result;
    END;
END;
$function$
;