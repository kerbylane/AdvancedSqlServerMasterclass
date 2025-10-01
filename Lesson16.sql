Use AdventureWorks2019;

GO

select 
    PurchaseOrderID,
    OrderDate,
    TotalDue,
    v.Name,

    PrevOrderFromVendorAmt = Lag(TotalDue) over (PARTITION BY VendorId order by OrderDate),
    NextOrderByEmployeeVendor = Lead(v.Name) over (PARTITION BY o.EmployeeId order by OrderDate),
    Next2OrderByEmployeeVendor
        = Lead(v.Name, 2) over (PARTITION BY o.EmployeeId order by OrderDate)
from Purchasing.PurchaseOrderHeader o
left join Purchasing.Vendor v on o.VendorId = v.BusinessEntityId
where o.OrderDate >= '2013-01-01'
and   TotalDue > 500.00
Order by VendorID, OrderDate