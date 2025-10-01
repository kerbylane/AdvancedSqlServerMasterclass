Use AdventureWorks2019;

-- The focus of this exercise is Pivot.

-- exercise 1: not split out, only 1 row

SELECT
    [Sales Representative], [Buyer], [Janitor]
from (
    select JobTitle, VacationHours from HumanResources.Employee
    where JobTitle in ('Sales Representative', 'Buyer', 'Janitor')
) subquery

PIVOT (
    avg(VacationHours) for JobTitle in ([Sales Representative], [Buyer], [Janitor])
) pivot_alias;

-- exercise 2: split into rows by gender

SELECT
    Gender, -- this makes it include rows per gender
    [Sales Representative], [Buyer], [Janitor]
from (
    select JobTitle, VacationHours, Gender from HumanResources.Employee
    where JobTitle in ('Sales Representative', 'Buyer', 'Janitor')
) subquery

PIVOT (
    avg(VacationHours) for JobTitle in ([Sales Representative], [Buyer], [Janitor])
) pivot_alias;

