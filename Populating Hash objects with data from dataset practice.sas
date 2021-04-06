libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";
***********Practice level 1************;

data cust;
	if 0 then
		set orion.customertype(keep=customertype);
	set orion.customer(keep=CustomerID CustomerTypeID);

	if _N_=1 then
		do;
			declare hash T(dataset: "orion.customertype");
			T.definekey("CustomerTypeID");
			T.definedata("CustomerType");
			T.definedone();
		end;
	T.find(key : customertypeID);
run;

proc print data=cust(obs=5);
run;

*************Practice level 2***************;
Create a new data set named billing that reads CustomerID, OrderDate, 
	ProductID, Quantity, and TotalRetailPrice from orion.orderfact;

data billing;
	drop Country;

	if _N_=1 then
		do;

			if 0 then
				set orion.productlist(keep=ProductID ProductName);

			if 0 then
				set orion.customerdim(keep=CustomerID CustomerCountry CustomerName);

			if 0 then
				set orion.country(keep=Country CountryName);
			declare hash Prod(dataset:'orion.productlist');
			Prod.definekey('ProductID');
			Prod.definedata('ProductName');
			Prod.definedone();
			declare hash Customer(dataset:'orion.customerdim');
			customer.definekey('CustomerID');
			customer.definedata('CustomerCountry', 'CustomerName');
			customer.definedone();
			declare hash C(dataset:'orion.country');
			C.definekey('Country');
			C.definedata('CountryName');
			C.definedone();
		end;
	set orion.orderfact(keep=OrderDate Quantity ProductID TotalRetailPrice 
		CustomerID);
	Customer.find();
	Prod.find();
	C.find(key:CustomerCountry);
run;

proc print data=billing;
run;


*************Challenge***************;
proc print data= orion.staff(obs=1);
proc print data= orion.employeeaddresses(obs=1);
proc print data= orion.employeepayroll(obs=1);





data manager;
   length EmployeeName EmpName ManagerName $40;
   keep EmployeeID EmpName ManagerID ManagerName Salary;
   if _N_=1 then 
      do;
         declare hash M(dataset:'orion.staff');
         M.definekey('EmployeeID');
         M.definedata('ManagerID');
         M.definedone();
         declare hash N(dataset:'orion.employeeaddresses');
         N.definekey('EmployeeID');
         N.definedata('EmployeeName');
         N.definedone();
         call missing(EmployeeName); 
      end;
   set orion.employeepayroll(keep=EmployeeID Salary);
   rc1=M.find(key:EmployeeID);
   rc2=N.find(key:EmployeeID);
   if rc2=0 then EmpName=EmployeeName;
   else EmpName=' ';
   rc3=N.find(key:ManagerID);
   if rc3=0 then ManagerName=EmployeeName;
   else ManagerName=' ';
run;

proc print data= manager;

run;