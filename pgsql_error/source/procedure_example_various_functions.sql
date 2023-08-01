CREATE OR REPLACE PROCEDURE exampleprocedure(
    in_empid integer,
    in_empfname varchar(50),
    in_emplname varchar(50),
    in_department varchar(50),
    in_project varchar(50),
    in_address varchar(100),
    in_dob timestamp,
    in_gender varchar(20),
    in_empposition varchar(50),
    in_dateofjoining date,
    in_salary integer
)
AS
BEGIN
    DECLARE nand_result integer;
    DECLARE dob_day integer;
    DECLARE joined_date date;

    -- Calculate the intNand of the salary
    SET nand_result = int2and(in_salary, in_empid);

    -- Check if address is NULL and replace with a default value
    SET in_dob = COALESCE(in_dob, CURRENT_TIMESTAMP);

    -- Extract the day of the year from the Date of Birth
    SET dob_day = EXTRACT(DAY FROM in_dob);

    -- Add 3 months to the Date of Joining
    SET joined_date = ADD_MONTHS(in_dateofjoining, 3);

    -- Insert into EmployeeInfo table with NVL function
    INSERT INTO employeeinfo (empid, empfname, emplname, department, project, address, dob, gender)
    VALUES (in_empid, in_empfname, in_emplname, in_department, in_project, NVL(in_address, 'No Address'), in_dob, in_gender);

    -- Insert into EmployeePosition table
    INSERT INTO employeeposition (empid, empposition, dateofjoining, salary)
    VALUES (in_empid, in_empposition, in_dateofjoining, in_salary);

    SELECT CURRENT_TIMESTAMP AS current_timestamp;

    COMMIT;
END;