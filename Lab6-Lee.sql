/* Brianna Lee CMPT308N 10.15.20 */

/* question #1 */
select city, count(*) as city_amount
from Products
group by city
	having count(*) = (select max(city_amount)
					  from (select city, count(*) as city_amount
						   from Products
						   group by city) PRODUCTS);
						   
/* question #2 */
select name
from Products
where priceUSD > any (select avg (priceUSD)
					  from Products)
ORDER BY name desc;

/* question #3 */
select distinct lastName, o1.prodId, o1.totalUSD
from People p inner join Customers c on p.pid = c.pid
	inner join Orders o1 on c.pid = o1.custId
	inner join Orders o2 on o1.prodId = o2.prodId
	inner join Orders o3 on o1.totalUSD = o3.totalUSD
where EXTRACT (month from o1.dateOrdered) = 3
ORDER BY totalUSD desc;

/* question #4 */
select distinct p1.lastName, o2.quantityOrdered
from People p inner join Customers c on p.pid = c.pid
inner join Orders o1 on p.pid = c.pid
inner join Orders o2 on c.pid = o2.custId
inner join People p1 on p1.pid = o2.custId
ORDER BY p1.lastName desc; 

/* question #5 */
select p.firstName as customerFirstName,
		p.lastName as customerLastName, 
		p1.firstName as agentFirstName,
		p1.lastName as agentLastName,
		pr.name as productName
from Customers c
inner join Orders o on c.pid = o.custId
inner join Products pr on o.prodId = pr.prodId
inner join People p on c.pid = p.pid
inner join People p1 on o.agentId = p1.pid
where p1.homeCity = 'Teaneck';


/* question 6 */
select *
from Orders o
inner join Products pr on pr.prodId = o.prodId
inner join Customers c on c.pid = o.custId
where totalUSD != ANY(select ROUND((o.quantityOrdered * pr.priceUSD) - ((o.quantityOrdered * pr.priceUSD)*(c.discountPct/100)),2)
						from Orders);
/* in the cap database screenshot, the original price for orderNum 1017 is 25643.89 when it should be
25643.88 */

/* question #7 */
select firstName, lastName
from People
where pid = ANY(select pid
				from Agents
				where pid = ANY(select pid
							   from Customers));
							   
/* question #8 */
DROP VIEW PeopleCustomers;

CREATE VIEW PeopleCustomers as
select p.pid, p.prefix, p.firstName, p.lastName, p.suffix, p.homeCity, p.DOB, c.pid as custPid, c.paymentTerms, c.discountPct
from People p full outer join Customers c on p.pid = c.pid;

select *
from PeopleCustomers;

DROP VIEW PeopleAgents;

CREATE VIEW PeopleAgents as
select p.pid, p.prefix, p.firstName, p.lastName, p.suffix, p.homeCity, p.DOB, a.pid as agentPid, a.paymentTerms, a.commissionPct
from People p full outer join Agents a on p.pid = a.pid;

select *
from PeopleAgents;

/* question #9 */
select firstName, lastName
from PeopleAgents
where agentPid = ANY(select custPid
					 from PeopleCustomers)
			   
/* question #10
Question #7 and #9 both produce the same answer. For #7, the database runs through all
the information in the People table, then looks for the pid in Customers and then will compare
it to all of the pids in Agents to find the one person who is in both. However, #9 is a newly
created view table where all the information of people who are customers in a table. Rather than
having to run a sub query within a sub query, it simply finds all the information in the view table
giving the database less work internally to find the information needed. */


/* question #11
Left outer join joins two tables and fetches row bases on a condition, which is matching in both
tables and the unmatched rows will also be available from the table before the join clause. The
right outer join is the same as the left outer join but on the right side. To make it easier to
understand, if there was a venn diagram, the full left circle including the overlapped area while
the right outer join takes the entire right circle and will add that information to the table to
find information. */
select firstName
from People p inner join Customers c on (p.pid = c.pid)
	left outer join orders o on (p.pid = o.custId)
	where o.prodId is NULL;
/* left outer join */

select *
from People p right outer join Customers c on p.pid = c.pid;
/* right outer join */
 
