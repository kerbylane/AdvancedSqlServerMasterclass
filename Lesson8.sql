use AdventureWorks2019;

-- scratch
SELECT BusinessEntityID
    --   ,[TerritoryID]
    --   ,[SalesQuota]
    --   ,[Bonus]
    --   ,[CommissionPct]
      -- ,sum([SalesYTD])
      ,Sum([SalesYTD]) over (partition by BusinessEntityID) Total_YTD
    --   ,[SalesLastYear]
    --   ,[rowguid]
    --   ,[ModifiedDate]
  FROM [AdventureWorks2019].[Sales].[SalesPerson]

-- Excercises
SELECT
    FirstName,
    LastName,
    JobTitle,
    Rate,
    Avg(Rate) over() AverageRate,
    Max(Rate) over () MaximumRate,
    rate - Avg(Rate) over () DiffFromAvgRate,
    rate / max(rate) over () PercentOfMaxRate
from person.Person p
join HumanResources.Employee e on p.BusinessEntityID = e.BusinessEntityID
join HumanResources.EmployeePayHistory h on p.BusinessEntityID = h.BusinessEntityID

