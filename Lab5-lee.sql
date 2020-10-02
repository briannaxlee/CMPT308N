-- SQL statements for displaying this example data:
/* question 1 */
select *
from People p inner join Customers c on (p.pid = c.pid);

/* question 2 */
select *
from People p inner join Agents a on (p.pid = a.pid);

/* question 3 */
select *
from People p inner join Customers c on (p.pid = c.pid)
			inner join Agents a on (p.pid = a.pid);

/* question 4 */
select firstname
from People
where pid in (select pid
			 from Customers
			 where pid not in (select custId
							  from Orders));

/* question 5 */
select firstName
from People p inner join Customers c on (p.pid = c.pid)
	left outer join orders o on (p.pid = o.custId)
	where o.prodId is NULL;

/* question 6 */
select pid, commissionPct
from Agents a
	inner join Orders o on (a.pid = o.agentId)
	where o.custId = '008'
order by commissionPct ASC;

/* question 7 */
select lastName, homeCity, commissionPct
from People p left join Agents a
on (p.pid = a.pid)
inner join orders o
on a.pid = o.agentId
where o.custId = '001'
order by commissionPct ASC;

/* question 8*/
select p.lastName, p.homeCity
from People p inner join Customers c on p.pid = c.pid
	inner join Products prod on prod.city = p.homeCity
where prod.city in (select city
				   from Products
				   group by city
				   having count(*) = 1);

/* question 9 */
select name, prodId
from Products
where prodId in (select prodId
				from Orders
				where agentId in (select agentId
								  where custId in (select pid
												 from People
												 where homeCity = 'Chicago')))
order by name ASC;

/* question 10 */
select firstName, lastName, pid, homeCity
from People
where pid in (select pid
			  from Customers)
	or pid in (select pid
				from Agents);
