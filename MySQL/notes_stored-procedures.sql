STORED PROCEDURES
Based on MySQL and IBM Db2 on Cloud

____________________________________________________________________________________________________
A set of SQL statements stored and executed on the database server. Multiple statements are sent as
one from the cient to the server.

--> Reduction in network traffic.
--> Improvement in performance (processing happens on the server and just the final result is passed
    back.
    
Stored procedures can be called from external applications and dynamic SQL statements.

CALL UPDATE_SALARIES ('E1001', 1)
    
____________________________________________________________________________________________________
EXAMPLE 1

--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_SALARIES (IN empNum CHAR(6), IN rating SMALLINT)

LANGUAGE SQL

BEGIN

    IF rating = 1 THEN
      UPDATE employees
        SET salary = salary * 1.10
        WHERE emp_id = empNum;
        
    ELSE
      UPDATE employees
        SET salary = salary * 1.05
        WHERE emp_id = empNum;
        
    END IF
    
END
@

____________________________________________________________________________________________________
EXAMPLE 2

--#SET TERMINATOR @
CREATE PROCEDURE RETRIEVE_ALL       -- Name of this stored procedure routine

LANGUAGE SQL                        -- Language used in this routine 
READS SQL DATA                      -- This routine will only read data from the table

DYNAMIC RESULT SETS 1               -- Maximum possible number of result-sets to be returned to the caller query

BEGIN 

    DECLARE C1 CURSOR               -- CURSOR C1 will handle the result-set by retrieving records row by row from the table
    WITH RETURN FOR                 -- This routine will return retrieved records as a result-set to the caller query
    
    SELECT * FROM PETSALE;          -- Query to retrieve all the records from the table
    
    OPEN C1;                        -- Keeping the CURSOR C1 open so that result-set can be returned to the caller query

END
@ 

____________________________________________________________________________________________________
EXAMPLE 3

--#SET TERMINATOR @
CREATE PROCEDURE UPDATE_SALEPRICE ( 
    IN Animal_ID INTEGER, IN Animal_Health VARCHAR(5) )     -- ( { IN/OUT type } { parameter-name } { data-type }, ... )

LANGUAGE SQL                                                -- Language used in this routine
MODIFIES SQL DATA                                           -- This routine will only write/modify data in the table

BEGIN 

    IF Animal_Health = 'BAD' THEN                           -- Start of conditional statement
        UPDATE PETSALE
        SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.25)
        WHERE ID = Animal_ID;
    
    ELSEIF Animal_Health = 'WORSE' THEN
        UPDATE PETSALE
        SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.5)
        WHERE ID = Animal_ID;
        
    ELSE
        UPDATE PETSALE
        SET SALEPRICE = SALEPRICE
        WHERE ID = Animal_ID;

    END IF;                                                 -- End of conditional statement
    
END
@                                                           -- Routine termination character
