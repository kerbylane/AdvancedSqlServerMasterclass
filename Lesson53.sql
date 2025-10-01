Use AdventureWorks2019;

/*
Making use of a temp table and UPDATE statements, re-write an optimized version of 
the query below.

SELECT 
	   A.BusinessEntityID
      ,A.Title
      ,A.FirstName
      ,A.MiddleName
      ,A.LastName
	  ,B.PhoneNumber
	  ,PhoneNumberType = C.Name
	  ,D.EmailAddress

FROM AdventureWorks2019.Person.Person A
	LEFT JOIN AdventureWorks2019.Person.PersonPhone B
		ON A.BusinessEntityID = B.BusinessEntityID
	LEFT JOIN AdventureWorks2019.Person.PhoneNumberType C
		ON B.PhoneNumberTypeID = C.PhoneNumberTypeID
	LEFT JOIN AdventureWorks2019.Person.EmailAddress D
		ON A.BusinessEntityID = D.BusinessEntityID
*/


create table #temp (
    BusinessEntityID int,
    Title nvarchar(8),
    FirstName NVARCHAR(64),
    MiddleName NVARCHAR(64),
    LastName NVARCHAR(64),
    PhoneNumber NVARCHAR(64),
    PhoneNumberType NVARCHAR(64),
    PhoneNumberTypeId NVARCHAR(64),
    EmailAddress NVARCHAR(64)
)

insert into #temp
(
	   BusinessEntityID
      ,Title
      ,FirstName
      ,MiddleName
      ,LastName
)
    select 
	   BusinessEntityID
      ,Title
      ,FirstName
      ,MiddleName
      ,LastName
    from Person.Person where title is not null;


update #temp set
    PhoneNumber = phone.PhoneNumber,
    -- need to get the PN Type ID so we can look it up in Person.PhoneNumberType
    PhoneNumberTypeId = phone.PhoneNumberTypeID
    from #temp
    join Person.PersonPhone phone on #temp.BusinessEntityID = phone.BusinessEntityID

update #temp SET
    PhoneNumberType = pt.Name
    from #temp
    join Person.PhoneNumberType pt on #temp.PhoneNumberTypeId = pt.PhoneNumberTypeID

update #temp SET
    EmailAddress = e.EmailAddress
    from #temp
    join Person.EmailAddress e on e.BusinessEntityID = #temp.BusinessEntityID

select * from #temp;

-- clean up
drop table #temp;