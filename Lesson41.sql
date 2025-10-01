Use AdventureWorks2019;

-- Here we reproduce the exercise from Lesson 36 using temporary tables.

SELECT
	OrderMonth,
	TotalSales = SUM(TotalDue)
into #ValidSales
FROM (
	SELECT 
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	FROM AdventureWorks2019.Sales.SalesOrderHeader
) S
WHERE OrderRank > 10
GROUP BY OrderMonth;

SELECT
	OrderMonth,
	TotalPurchases = SUM(TotalDue)
into #ValidPurchases
FROM (
	SELECT 
		OrderDate
		,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
		,TotalDue
		,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
	FROM Purchasing.PurchaseOrderHeader
) P
WHERE OrderRank > 10
GROUP BY OrderMonth;

SELECT
    s.OrderMonth,
    s.TotalSales,
    p.TotalPurchases

FROM #ValidSales s
JOIN #ValidPurchases p ON s.OrderMonth = p.OrderMonth

ORDER BY 1

Drop table #ValidSales;
drop table #ValidPurchases;