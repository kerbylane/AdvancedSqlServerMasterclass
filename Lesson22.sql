Use AdventureWorks2019;

with grouped_sales as (
    select 
        OrderMonth = month(OrderDate),
        OrderYear = YEAR(OrderDate),
        sum(TotalDue) SubTotal
    from Purchasing.PurchaseOrderHeader
    group by month(OrderDate), year(OrderDate)
)

select
    *,
    Rolling3MonthTotal = sum(SubTotal) 
        over (order by OrderYear, OrderMonth Rows BETWEEN 2 Preceding and current row),

    MovingAvg6Month = avg(SubTotal) 
        over (order by OrderYear, OrderMonth Rows BETWEEN 6 Preceding and 1 Preceding),

    MovingAvgNext2Months = avg(SubTotal)
        over (order by OrderYear, OrderMonth Rows BETWEEN current row and 2 following)
from grouped_sales