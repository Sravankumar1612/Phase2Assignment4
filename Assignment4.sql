create database Assignment4Db
use Assignment4Db

create table Products
(
	PId int primary key identity(500,1),
	PName nvarchar(50) not null,
	PPrice float ,
	PTax as PPrice*0.10 persisted,
	PCompany nvarchar(50),
	PQty int Default 10,
	constraint PQty check (PQty>=1),
	constraint PCompany check (PCompany in  ('Samsung','Apple','Redmi','HTC','RealMe','Xiomi'))
)


insert into Products(PName,PPrice,PCompany) values ('EarPods',800,'Samsung'),
													('Screen gaurd',1200,'Apple'),
													('Phone case',300,'Redmi')
insert into Products(PName,PPrice,PCompany,PQty) values ('Addapter',500,'HTC',2),
													('Charge cable',200,'Xiomi',5),
													('Ipad',30000,'Apple',1)
insert into Products(PName,PPrice,PCompany) values ('RealMe note 3',28000,'RealMe'),
													('Screen gaurd',200,'Samsung'),
													('Phone case',500,'HTC')
insert into Products(PName,PPrice,PCompany,PQty) values ('Mouse',15000,'Apple',2)
	
select * from Products
----------------------------------------------------------------------
create proc GetTotalPrice
with encryption
as 
begin
select PId,PName,PPrice+PTax as PriceWithTax,PCompany,(PQty*(PPrice+PTax)) as TotalPrice from Products
end

exec GetTotalPrice
--------------------------------------------------------------------------
create proc TotalTaxForCompany
@PCompany nvarchar(100),
@TotalTax float output
with encryption
as
begin
select
@TotalTax=SUM(PTax)
from Products
where PCompany = @PCompany
end

declare @TotalTax float
exec TotalTaxForCompany 'Apple', @TotalTax output
print  @TotalTax