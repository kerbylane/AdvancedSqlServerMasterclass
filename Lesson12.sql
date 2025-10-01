use AdventureWorks2019;

SELECT
    p.name ProductName,
    ListPrice,
    ps.Name ProductSubcategory,
    pc.Name ProductCategory,

    [Price Rank] = Rank() over (order by ListPrice desc),
    [Category Price Rank] = Rank() over (partition by pc.Name order by ListPrice desc),
    [Top 5 Price in Cat] = case
        when 
            Rank() over (partition by pc.Name order by ListPrice desc) < 6 then 'Yes'
        else
            'No'
        end
from Production.Product p
inner join Production.ProductSubcategory ps on p.ProductSubcategoryID = ps.ProductSubcategoryID
inner join Production.ProductCategory pc on ps.ProductCategoryID = pc.ProductCategoryID
order by pc.Name