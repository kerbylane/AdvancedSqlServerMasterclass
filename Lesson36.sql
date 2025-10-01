Use AdventureWorks2019;

with valid_sales as (
	SELECT
        OrderMonth,
        TotalSales = SUM(TotalDue)
	FROM (
		SELECT 
		   OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM AdventureWorks2019.Sales.SalesOrderHeader
	) S
	WHERE OrderRank > 10
	GROUP BY OrderMonth
),
valid_purchases as (
	SELECT
        OrderMonth,
        TotalPurchases = SUM(TotalDue)
	FROM (
		SELECT 
		   OrderDate
		  ,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		  ,TotalDue
		  ,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
		FROM Purchasing.PurchaseOrderHeader
	) P
	WHERE OrderRank > 10
	GROUP BY OrderMonth
)

SELECT
    s.OrderMonth,
    s.TotalSales,
    p.TotalPurchases

FROM valid_sales s
JOIN valid_purchases p ON s.OrderMonth = p.OrderMonth

ORDER BY 1