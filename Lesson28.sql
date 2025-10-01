Use AdventureWorks2019;

-- exercise 1
SELECT
    PurchaseOrderID,
    OrderDate,
    SubTotal,
    TaxAmt
from Purchasing.PurchaseOrderHeader header
where exists (
    select 1 from Purchasing.PurchaseOrderDetail detail
    where OrderQty > 500
    and header.PurchaseOrderID = detail.PurchaseOrderID
)
order by PurchaseOrderID;

-- exercise 2
SELECT
    *
from Purchasing.PurchaseOrderHeader header
where exists (
    select 1 from Purchasing.PurchaseOrderDetail detail
    where OrderQty > 500
    and UnitPrice > 50.00
    and header.PurchaseOrderID = detail.PurchaseOrderID
)
order by PurchaseOrderID;

-- exercise 3
SELECT *
from Purchasing.PurchaseOrderHeader header
where not exists (
    select 1 from Purchasing.PurchaseOrderDetail detail
    where RejectedQty > 0
    and header.PurchaseOrderID = detail.PurchaseOrderID
)
order by PurchaseOrderID;

