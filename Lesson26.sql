Use AdventureWorks2019;

-- The focus here is on correlated scalar subqueries

select
    PurchaseOrderId,
    VendorID,
    OrderDate,
    TotalDue,

    NonRejectedItems = (
        select count(*) from Purchasing.PurchaseOrderDetail detail
        where ReceivedQty > 0
        and detail.PurchaseOrderID = header.PurchaseOrderID
    ),

    MostExpensiveItem = (
        select max(UnitPrice) from Purchasing.PurchaseOrderDetail detail
        where detail.PurchaseOrderID = header.PurchaseOrderID
    )
from Purchasing.PurchaseOrderHeader header


-- select * from Purchasing.PurchaseOrderDetail where PurchaseOrderID = 1