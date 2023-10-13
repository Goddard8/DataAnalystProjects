
select * from salaries;

select EmployeeName,JobTitle from salaries;

select count(EmployeeName) as 'employee count' from salaries;

select distinct JobTitle from salaries;

select JobTitle, OvertimePay from Salaries
where OvertimePay > 50000; 


select avg(BasePay) from salaries;

select EmployeeName,TotalPay from salaries
order by TotalPay desc
limit 10;

Select * from salaries;

Select EmployeeName,(BasePay + OvertimePay +OtherPay)/3 as 'Average of all Three' from salaries;

select EmployeeName,JobTitle from salaries
where JobTitle like '%Manager%';

select EmployeeName,JobTitle from salaries
where JobTitle not like '%Manager%';

select EmployeeName,TotalPay from salaries
where TotalPay between 50000 and 75000;

select EmployeeName,BasePay,TotalPay from salaries
where BasePay < 50000 or TotalPay > 100000;

select EmployeeName,TotalPayBenefits,JobTitle from salaries
where TotalPayBenefits between 125000 and 150000 and JobTitle like '%Director%';

select EmployeeName,TotalPayBenefits from salaries
order by TotalPayBenefits desc;

select JobTitle, avg(BasePay) as 'average base pay' from salaries
group by JobTitle
having avg(BasePay) >= 100000
order by avg(BasePay) desc;

select * from salaries;
alter table salaries	
drop column Notes;

select * from salaries;

update salaries 
set BasePay = Basepay * 1.1
where JobTitle Like '%Manager%' ;

select * from salaries

