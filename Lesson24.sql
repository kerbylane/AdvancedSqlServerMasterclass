use AdventureWorks2019;

-- The focus for this exercise is scalar subqueries.

-- I think this could all be done with Window functions instead of a scalar subquery.
-- But this is the exercise.

SELECT
    BusinessEntityID,
    JobTitle,
    VacationHours,

    (select max(VacationHours) from HumanResources.Employee) MaxVacationHours,
    (1.0 * VacationHours) / (select max(VacationHours) from HumanResources.Employee) VacPercent
from HumanResources.Employee
where VacationHours > (.8*(select max(VacationHours) from HumanResources.Employee))