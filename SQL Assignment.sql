create schema assignment;
set search_path to assignment;

select *
from aiven.international_debt_with_missing_values idwmv ;


-- What is the total amount of debt owed by all countries in the dataset?
select (sum(debt)/ 1000000)::numeric(12,2) as Total_debt_owed_in_millions
from aiven.international_debt_with_missing_values idwmv;

-- How many distinct countries are recorded in the dataset?
select count(distinct country_name) as distinct_countries
from aiven.international_debt_with_missing_values idwmv;

-- What are the distinct types of debt indicators, and what do they represent?
select distinct indicator_name
from aiven.international_debt_with_missing_values idwmv;

-- Which country has the highest total debt, and how much does it owe?
select country_name, sum(debt) as total_debt
from aiven.international_debt_with_missing_values idwmv
group by country_name 
order by sum(debt) desc;

-- What is the average debt across different debt indicators?
select distinct indicator_name, avg(debt) as average_debt
from aiven.international_debt_with_missing_values idwmv
group by indicator_name ;

-- Which country has made the highest amount of principal repayments?
select distinct country_name, sum(debt)
from aiven.international_debt_with_missing_values idwmv
where indicator_name like '%Principal repayments%'
group by country_name 
order by sum(debt) desc;

-- solution 2
select distinct country_name,  sum(debt)
from aiven.international_debt_with_missing_values idwmv
where indicator_name like '%Principal repayment%'
group by country_name 
 having sum(debt) >= 0 
order by sum(debt) desc
;

-- What is the most common debt indicator across all countries?
select indicator_name, count(indicator_name)
from aiven.international_debt_with_missing_values idwmv
group by indicator_name
order by count(indicator_name) desc;

-- Identify any other key debt trends and summarize your findings.
