--MANIPULATION-FUNCTIONS------------------------------------------------------------------
__________________________________________________________________________________________

--Adding a new column in a table:

ALTER TABLE table_name
ADD column_name data_type


--CONVERTING-DATA-TYPES-------------------------------------------------------------------
__________________________________________________________________________________________

--For comparing two values, they need to be of the same data type. Otherwise SQL tries to
--convert types behind the scenes (IMPLICIT). If that's not possible, you need to
--explicitly convert them (EXPLICIT) using CAST() or CONVERT().


--IMPLICIT-CONVERSION---------------------------------------------------------------------

SELECT
company,
bean_type,
cocoa_percent [type: decimal]
FROM ratings
WHERE cocoa_percent > '0.5';

--For some reason we used '0.5' (a string) rather than 0.5 (decimal). However, the server
--will be able to understand what we're trying to do. It will convert the string to the
--decimal and perform the operation.

--For every comparison present in WHERE clause, the data type of the two operands is
--evaluated. If they differ, SQL Server will check if once can be automatically converted
--to another, without data loss.

--Implicit conversion is done for each row of the query, therefore the cost might be
--significant. Thankfully, implicit conversion can be prevented with a good database schema
--design.


--EXPLICIT-CONVERSION---------------------------------------------------------------------

--Performed with CAST() or CONVERT(). CAST() comes from the SQL standard and CONVERT() is
--SQL Server specific. If you're writing your queries with the intention of migrating them
--in the future to a different platform than SQL Server, you should use the CAST().
--However, in terms of performance CONVERT() is slightly better. This is because when using
--CAST(), SQL Server first transforms it into CONVERT(), so it executes an additional
--operation.

CAST(expression AS data_type [(length)])

CONVERT(data_type, [(length)], expression [, style])
