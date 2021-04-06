*returning the difference between the currrent salary of an employee and and the average





					salary of all the employees for that same year;
libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";

proc print data=orion.employeepayroll(obs=5);
	title "Employee information";
run;

proc print data=orion.salarystats;
	title "salaries information over the years";
run;

data compare;
	keep EmployeeID YearHired Salary Average SalaryDif;
	format Salary Average SalaryDif dollar12.2;
	array yr{1978:2011} Yr1978-Yr2011;

	if _n_=1 then
		set orion.salarystats(where=(Statistic='AvgSalary'));
		
		
	set orion.employeepayroll(keep=EmployeeID EmployeeHireDate Salary);
	YearHired=year(EmployeeHireDate);
	Average=yr{yearHired};
	SalaryDif=sum(Salary, -Average);
run;

proc print data=compare;
run;