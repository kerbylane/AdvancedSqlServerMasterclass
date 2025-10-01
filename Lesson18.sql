Use AdventureWorks2019;

GO

-- Exercise 1
SELECT
    BusinessEntityID as EmployeeId,
    JobTitle,
    HireDate,
    VacationHours,

    FirstHireVacationHours = FIRST_VALUE(VacationHours) over (PARTITION BY JobTitle order by HireDate)
from HumanResources.Employee
order by JobTitle, HireDate

-- Exercise 2
SELECT
    p.ProductID,
    P.Name,
    h.ListPrice,
    h.ModifiedDate,

    HighestPrice = max(h.ListPrice) over (partition by P.ProductID),
    LowestCost = min(h.ListPrice) over (partition by P.ProductID),
    PriceRange = max(h.ListPrice) over (partition by P.ProductID)
                - min(h.ListPrice) over (partition by P.ProductID)
from Production.Product p
inner join Production.ProductListPriceHistory h on p.ProductID = h.ProductID
order by p.ProductID, ModifiedDate