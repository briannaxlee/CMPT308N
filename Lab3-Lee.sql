/* Brianna Lee CMPT308N 09.16.20 */

select ordernum, totalusd
from Orders;

select lastname, homecity
from People
where prefix = 'Dr.';

select prodid, name, priceusd
from Products
where qtyonhand > 1007;

select  *
from People
where dob > '1950-01-01' and dob < '1959-12-31'

select  prefix, lastname
from People
where prefix != 'Mr.'

select *
from Products
where city != 'Dallas' and city != 'Duluth'
	and priceusd > 3
	
select *
from Orders
where extract(month from dateordered) = '03';

select *
from Orders
where extract(mon from dateordered) = '02'
	and totalusd > 20000;

select *
from Orders
where custid = 007;

select *
from Orders
where custid = 005;

