/*
This is just notes on SQL programming

Variables begin with @.
*/

-- Creating variables

-- create and then assign
declare @myvar int

set @myvar = 11

select @myvar

-- create + assign
declare @another int = 12

select @another

-- Use of a variable can help clean up scalar subqueries
-- This is particularly helpful if you are reusing such a subquery.

declare @AvgPrice MONEY

set @AvgPrice = ( /*subquery here */ )

/*
Functions

Note: functions live in a single Database.
*/

use AdventureWorks2019;

GO

create function dbo.ufnCurrentDate() returns date
as
BEGIN
    -- logic goes here
END

GO

-- Functin with variables

CREATE FUNCTION dbo.ufnElapsedBusinessDays(@StartDate DATE, @EndDate DATE)
RETURNS INT
AS  
BEGIN
	RETURN -- this returns a single value, so it needs to be wrapped in ()
		(
			SELECT
				COUNT(*)
			FROM AdventureWorks2019.dbo.Calendar

			WHERE DateValue BETWEEN @StartDate AND @EndDate
				AND WeekendFlag = 0
				AND HolidayFlag = 0
		)	- 1
END

-- Table Defined Functions

-- just like the above example but return more than 1 line

-- IF Else

if [thing]
    BEGIN
    END
if [another thing]
    BEGIN
    END
ELSE
    BEGIN
    END