use AdventureWorks2019;

SELECT
    p.name ProductName,
    ListPrice,
    ps.Name ProductSubcategory,
    pc.Name ProductCategory,

    AvgPriceByCategory = avg(ListPrice) over (partition by pc.Name),
    AvgPriceByCategoryAndSubcategory = avg(ListPrice) over (partition by pc.NAME, ps.NAME),
    ProductVsCategoryDelta = ListPrice - avg(ListPrice) over (PARTITION by pc.Name)
from Production.Product p
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID
-- Window w as (Partition by pc.Name) This is flagged as incorrect but I don't know why