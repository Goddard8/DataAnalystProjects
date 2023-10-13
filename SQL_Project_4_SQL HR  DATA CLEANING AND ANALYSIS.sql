################################
# DATA CLEANING
################################
select * from hr;

ALTER TABLE hr
CHANGE COLUMN `ï»¿id` `emp_id` VARCHAR(20) NULL; -- changing column name
select * from hr;

Describe hr; -- looking at all the data types per column

select birthdate from hr;

update hr
set birthdate = case
	when birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d') #changing the format from m/d/y to y/m/d
    when birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d') #changing the format from m-d-y to y/m/d
    else null
end;

alter table hr
modify column birthdate date; #changing birthdate data type from text to date
select birthdate from hr;

update hr
set hire_date = case
	when hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d') #changing the format from m/d/y to y/m/d
    when hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d') #changing the format from m-d-y to y/m/d
    else null
end;
select hire_date from hr;

alter table hr
modify column hire_date date; #changing hiring_date data type from text to date
describe hr;

update hr
set termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')) # changing null values to a specific format instead of null
where termdate is not null and termdate !='';
select * from hr;

UPDATE hr SET termdate = NULL WHERE termdate = '';
DELETE FROM hr WHERE termdate = '';
ALTER TABLE hr MODIFY COLUMN termdate DATE NULL DEFAULT NULL; # changing data type from text to date
describe hr

ALTER TABLE hr ADD COLUMN AGE INT; #adding age column


UPDATE hr
SET AGE = timestampdiff(YEAR,birthdate,CURDATE()); #ADDING DATA TO AGE COLUMN
SELECT birthdate,age FROM hr;

SELECT max(age) as OLDEST, min(age) as YOUNGEST FROM hr; # LOOKING FOR MAX AND MIN AGE TO DETERMINE IF THERES ERROR IN DATA

SELECT count(*) FROM hr WHERE age<18; 


######################################
#DATA ANALYSIS
######################################

#Gender breakdown of employees in the company
SELECT gender, count(*) as count
FROM hr
WHERE age >= 18 
GROUP BY gender;

#race/ethnicity breakdown of employees in the company
SELECT race,count(*) AS count
FROM hr
WHERE age>=18 
GROUP BY race
ORDER BY count(*) DESC; 

#AGE DISTRIBUTION OF EMPLOYEES IN THE COMPANY AND BY GENDER
SELECT min(age) as YOUNGEST, max(age) as OLDEST
FROM HR
WHERE AGE >=18;

SELECT
	CASE 
		WHEN age >= 18 AND age <=24 THEN '18-24'
        WHEN age >= 25 AND age <=34 THEN '25-34'
        WHEN age >= 35 AND age <=44 THEN '35-44'
        WHEN age >= 45 AND age <=54 THEN '45-54'
        WHEN age >= 55 AND age <=64 THEN '55-64'
        ELSE '65+'
	END AS age_group, gender,
    count(*) as count
FROM hr
WHERE AGE >=18
GROUP BY age_group,gender
ORDER BY age_group,gender;
        
#How many employees work at headquarters vs remote?
SELECT location, count(*) as loccount
FROM hr
group by location
order by count(*) desc;
select * from hr

#average length of employment for employees who have been terminated
SELECT 
	avg(datediff(termdate,hiredate))/365 AS avg_length_emmployment
FROM HR
WHERE termdate <=curdate() AND termdate<>'0000-00-00' AND age >=18;

#gender distribution across departments and jobtitles
SELECT department, count(*) as depcount,gender,jobtitle
FROM hr
group by department,gender,jobtitle
order by department;

#distribution of jobtitles across the company
select jobtitle, count(*) as jobtitlecount
from hr
group by jobtitle
order by jobtitle desc;

#turnover rate per department
select department,total_count,terminated_count,terminated_count/total_count as termination rate
from (
	select department,
    count(*) as total_count,
    sum(case when termdate<>'0000-00-00' AND termdate <= curdate() then 1 else 0 end) as terminated_count
    FROM hr
    where age >= 18
    group by department
    )as subquery 
order by termination_rate desc;

#DISTRIBUTION OF EMPLOYEES ACROSS LOCATIONS BY CITY AND STATE
SELECT location_state, count(*) as locstatecount
from hr
group by location_state
order by count(*) desc;

#company's employee count over time by hired and term dates
SELECT 
	year,
	hires,
    terminations,
    hires-terminations as net change,
    round((hires-terminations)/hires*100,2) as net_change_percent
FROM(
	SELECT 
     YEAR(hire_date) as year
	 count(*) AS hires,
     SUM(case when termdate <>'0000-00-00' and termdate <= curdate() then 1 else 0 end) as terminations
     FROM hr
     WHERE age => 18
     GROUP BY year(hire_date)
     )AS subquery
ORDER BY year ASC;

#tenure ditribution for each department
select department,round(avg(datediff(termdate,hire_date)/365),0)as avg_tenure
from hr
where termdate <=curdate() and termdate<>'0000-00-00' and age >= 18
group by department;

###################
#END OF DATA ANALYSIS
###################
	

