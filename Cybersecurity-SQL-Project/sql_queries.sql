select * from incident_systems;
select * from login_logs;
select * from network_events;
select * from organizations;
select * from security_incidents;
select * from systems;
select * from users;

-- Q1. Write a query to find all organizations located in the 'USA' that are in the 'Finance' industry.

select * from organizations
where country = 'USA' and industry = 'Finance';

-- Q2 How many total security_incidents have a severity of 'Critical'?

select count(*) as total from security_incidents
where severity = 'Critical';

-- Q3 Retrieve all login_logs where the status was 'Failed' and the login happened after '2024-01-01'.

select * from login_logs
where status = 'Failed' and login_time > '2024-01-01'
order by login_time;

-- Q4 List all the unique os_type values present in the systems table.

select distinct(os_type) as total 
from systems;

-- Q5 Write a query to list the user_id and role of all users, along with the country of the organization they belong to.

select u.user_id, u.role, o.country
from users as u join organizations as o
on o.org_id = u.org_id;

-- Q6 Which industry has the highest number of systems?

select o.industry, count(s.system_id) as Most
from organizations as o join systems as s
on s.org_id = o.org_id
group by o.industry
order by Most desc
limit 1;

-- Q7 List the event_id, event_type, and timestamp of all network events that occurred on systems with a 'High' criticality.

select n.event_id, n.event_type, n.timestamp, s.criticality
from network_events as n join systems as s
on s.system_id = n.system_id
where s.criticality = 'High';

-- Q8 Find the user_id of the person who has the highest number of 'Failed' login attempts.

select u.user_id, count(l.user_id) as total
from users as u join login_logs as l
on l.user_id = u.user_id
where l.status = 'Failed'
group by u.user_id 
order by total desc
limit 1;

-- Q9 Find the top 3 organizations (by org_id and industry) that have experienced the most security_incidents

select o.org_id, o.industry, count(*) as total_experience
from organizations as o join security_incidents as si
on si.org_id = o.org_id
group by o.org_id, o.industry
order by total_experience desc
limit 3;

-- Q10 Find all users who belong to an organization that has had at least one 'Data Breach' incident type.

select distinct (u.user_id) -- , count(*) as Total_servity
from users as u
join security_incidents as si
on si.org_id = u.org_id
where si.incident_type = 'Data Breach';

-- Q11 List the ip_address of any login attempt that was 'Failed', but only if that login attempt was made by a user who has an 'Admin' role.

select ip_address
from login_logs
where status = 'Failed' and  user_id in ( 
select user_id from users
where role = 'Admin');

select ll.ip_address
from login_logs as ll join users as u
on ll.user_id = u.user_id
where ll.status = 'Failed' and u.role = 'Admin';

-- Q12 Write a query to find the absolute most recent security_incident for each organization.

with cte as (
select org_id, incident_id, discovered_date,
row_number() over(partition by org_id order by discovered_date desc) as Most_recent
from security_incidents)

select * from cte
where Most_recent <=1;

-- Q13 Security analysts want to see the time gap between failed logins. Write a query that lists every 'Failed' login attempt, but also includes a column showing the date of the previous failed login attempt for that exact same user_id.

with cte as (
select user_id, login_time, status,
lag(login_time, 1) over(partition by user_id) as prev_time
from login_logs
where status = 'Failed')

select * from cte;

-- Q14 Identify the most problematic systems. Write a query to rank the systems within each industry based on their total number of network_events. Return only the Top 2 systems for each industry.

with cts as (
select organizations.industry,network_events.system_id, count(network_events.event_id) as Total_count
from organizations join systems 
on systems.org_id = organizations.org_id 
join network_events 
on systems.system_id = network_events.system_id
group by organizations.industry, network_events.system_id),

sd as (select industry, system_id, Total_count,
dense_rank() over(partition by industry order by Total_count desc)  as rk 
from cts)

select * from sd
where rk <= 2;
