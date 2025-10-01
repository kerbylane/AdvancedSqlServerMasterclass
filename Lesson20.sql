use AdventureWorks2019;

GO

-- exercise 1
with 
ranked_orders as (
    SELECT
        PurchaseOrderID,
        VendorID,
        OrderDate,
        Freight,
        TotalDue,
        ROW_NUMBER() over (PARTITION BY VendorID order by TotalDue desc) as ranking
    from Purchasing.PurchaseOrderHeader
)

select
    PurchaseOrderID,
    VendorID,
    OrderDate,
    Freight,
    TotalDue
from ranked_orders where ranking < 4

-- exercise 2

with
order_amounts as (
    select 
        PurchaseOrderID,
        VendorID,
        OrderDate,
        Freight,
        TotalDue,
        ranked_total = DENSE_RANK() over (Partition by VendorID order by TotalDue desc)
    from Purchasing.PurchaseOrderHeader
)

select 
    PurchaseOrderID,
    VendorID,
    OrderDate,
    Freight,
    TotalDue
from order_amounts where ranked_total <= 3