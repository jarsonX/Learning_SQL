ACID TRANSACTIONS
Based on MySQL and IBM Db2 on Cloud

____________________________________________________________________________________________________
Atomic - Consistent - Isolated - Durable

Indivisible unit of work w which consists of one or more SQL statements. Either all happens or none.

Basic Transaction Control Language (TCL):

BEGIN
    <command_1>
    <command_n>
    
COMMIT or ROLLBACK

____________________________________________________________________________________________________
EXAMPLE 1

Scenario: Let's buy Rose a pair of Boots from ShoeShop. So we have to update the Rose balance as well 
as the ShoeShop balance in the BankAccounts table. Then we also have to update Boots stock in the 
ShoeShop table.

--#SET TERMINATOR @
CREATE PROCEDURE TRANSACTION_ROSE                           -- Name of this stored procedure routine

LANGUAGE SQL                                                -- Language used in this routine 
MODIFIES SQL DATA                                           -- This routine will only write/modify data in the table

BEGIN

        DECLARE SQLCODE INTEGER DEFAULT 0;                  -- Host variable SQLCODE declared and assigned 0
        DECLARE retcode INTEGER DEFAULT 0;                  -- Local variable retcode with declared and assigned 0
        DECLARE CONTINUE HANDLER FOR SQLEXCEPTION           -- Handler tell the routine what to do when an error or warning occurs
        SET retcode = SQLCODE;                              -- Value of SQLCODE assigned to local variable retcode
        
        UPDATE BankAccounts
        SET Balance = Balance-200
        WHERE AccountName = 'Rose';
        
        UPDATE BankAccounts
        SET Balance = Balance+200
        WHERE AccountName = 'Shoe Shop';
        
        UPDATE ShoeShop
        SET Stock = Stock-1
        WHERE Product = 'Boots';
        
        IF retcode < 0 THEN                                  --  SQLCODE returns negative value for error, zero for success, positive value for warning
            ROLLBACK WORK;
        
        ELSE
            COMMIT WORK;
        
        END IF;
        
END
@                                                            -- Routine termination character
