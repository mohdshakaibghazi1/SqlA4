create database Assesment04Db
use Assesment04Db
create table Products(
PId int primary key identity(500,1),
PName nvarchar(50) not null,
PPrice float,
Ptax as PPrice*0.10 persisted,
PCompany nvarchar(50),
PQty int default 10)

insert into Products(PName, PPrice, PCompany)values('Mobile', 59000, 'Redmi')
insert into Products(PName, PPrice, PCompany)values('Mobile',29999, 'Realme')
insert into Products(PName, PPrice, PCompany)values('Laptop', 89999, 'Samsung')
insert into Products(PName, PPrice, PCompany)values('laptop', 49999, 'Redmi')
insert into Products(PName, PPrice, PCompany)values('Mobile', 29999, 'Xiaomi')
insert into Products(PName, PPrice, PCompany)values('Mobile', 15999, 'HTC')
insert into Products(PName, PPrice, PCompany)values('EarPod', 14999, 'Apple')
insert into Products(PName, PPrice, PCompany)values('Mobile', 89999, 'Apple')
insert into Products(PName, PPrice, PCompany)values('Macbook', 81999, 'Apple')
insert into Products(PName, PPrice, PCompany)values('EarPhone', 1999, 'Realme')
select * from Products

create proc dis_prodTax
with encryption
as
begin 
select
PId,
PName,
PPrice + PTax as priceWithTax,
PQty *(PPrice + PTax) as TotalPrice
from Products
end
exec dis_prodTax


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
print 'Total Tax for Apple: ' + CONVERT(varchar, @TotalTax)