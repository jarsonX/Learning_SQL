--INTRODUCTION--------------------------------------------------------------------------------------
____________________________________________________________________________________________________

--Sometimes we would like to see the end results of aggregation without changing the grain of our
--data (i.e. without downsampling or upsampling). That's why window function are useful.

--Four window functions supported by MS SQL Server:

--ROW_NUMBER()    unique, ascending integer value starting from 1.
                  --example: 1, 2, 3, 4
--RANK()          ascending, starting from 1, however can have ties and thus skip numbers.
                  --example: 1, 2, 2, 4
--DENSE_RANK()    ascending, starting from 1 and also can have ties but does not skip numbers.
                  --example: 1, 2, 2, 3
--NTILE()
