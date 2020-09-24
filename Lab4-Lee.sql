/* Brianna Lee CMPT308N 09.23.20 */

select *
from People
where pid in (select pid
			 from Customers);
			 
select *
from People
where pid in (select pid
			 from Agents);
			 
select *
from People
where pid in (select pid
			 from Agents
			 where pid in (select pid
						   from Customers));

select *
from People
where not pid in (select pid
				  from Customers)
				  and not pid in (select pid
								   from Agents);
								   
select pid
from Customers
where pid in (select custId
			  from Orders
			  where prodId = 'p01' or prodId = 'p07');
			  
select pid
from Customers
where pid in (select custId
			  from Orders
			  where prodId = 'p01'
			  and custId in (select custId
							from Orders
							where prodId = 'p07'))
order by pid desc;

select firstName, lastName
from People
where pid in (select pid
			 from Agents
			 where pid in (select AgentId
							 from Orders
							 where prodId = 'p05' or prodId = 'p07'))
order by lastName desc;

select homecity, DOB
from People
where pid in (select AgentId
			 from Orders
			 where custId = '001')
order by homecity asc;

select prodId
from Orders
where agentId in (select agentId
				 from Orders
				 where quantityOrdered >= 1
				 and custId in (select pid
							   from People
							   where homecity = 'Toronto'
							   and pid in (select pid
										  from Customers)))
order by prodId desc;

select lastName, homecity
from People
where pid in (select pid
			  from Customers
			  where pid in (select custId
						   from Orders
						   where agentId in (select pid
											from People
											where homecity = 'Teaneck' or homecity = 'Santa Monica'
											and pid in (select pid
													from Agents))));