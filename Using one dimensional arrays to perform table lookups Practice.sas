libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";
*********************Practice level***********************;

proc print data=orion.retail(obs=5);
run;

proc print data=orion.retailinformation(obs=5);
run;

data compare(drop=statistic);
	drop month1-month12;
	array mon{12} Month1-Month12;

	if _n_=1 then
		set orion.retailinformation(where=(Statistic="MedianRetailPrice"));
	set orion.retail;
	month=month(orderdate);
	MedianRetailPrice=mon{month};
	format medianRetailPrice dollar12.2;
run;

proc print data=compare(obs=5);
run;

********************level 2***************************;

proc print data=orion.shoestats;
run;

data trans;
	drop i;
	set orion.shoestats;
	array prod{21:24} product21-product24;

	do i=21 to 24;
		value=prod{i};
		output;
	end;
run;

data trans;
	drop product21-product24;
	array prod{21:24} product21-product24;
	set orion.shoestats;

	do Productline=21 to 24;
		value=prod{productline};
		output;
	end;
run;

proc print data=trans;
run;

*******************Challenge**********************;
*Copied code;

proc sort data=orion.orderfact out=neworderfact(keep=customerID ordertype 
		orderdate deliverydate quantity);
	where customerID in (89, 2550) and year(orderdate)=2011;
	by ordertype;
run;

proc print data=neworderfact;
run;

proc sql print;
	title "Count by order type";
	create table total as select orderType, count(*) as count from neworderfact 
		group by ordertype;
quit;

proc print data=total;
run;

**************************;

data all;
	array ordt{*} orderdate1-orderdate4;
	array deldt{*} delivereddate1-delivereddate4;
	array q{*} quantity1-quantity4;
	format orderdate1-orderdate4 delivereddate1-delivereddate4 date9.;
	N=0;

	do until(last.ordertype);
		set neworderfact;
		by ordertype;
		N+1;
		ordt{N}=orderdate;
		deldt{N}=deliverydate;
		q{N}=Quantity;
	end;
run;

proc print data= all;
run;