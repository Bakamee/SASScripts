libname orion "/opt/sas/data";
**************Practice level 1*******************;

data expensive least;
	drop i;

	if _n_=1 then
		do;

			if 0 then
				set orion.shoesales;
			declare hash expensive(dataset: 'orion.shoesales', multidata : "yes", 
				ordered: "ascending");
			expensive.definekey("TotalRetailPrice");
			expensive.definedata("TotalRetailPrice", "ProductID", "productName");
			expensive.definedone();
		end;
	declare hiter h("expensive");
	h.first();

	do i=1 to 5;
		output least;
		h.next();
	end;
	h.last();

	do i=1 to 5;
		output expensive;
		h.prev();
	end;
run;

proc print data=least;
	title "least expensive shoes";
run;

proc print data=expensive;
	title "most expensive";
run;

***************Practice level 2***************;

data group;
	drop i;
length Rank $20.;
	if _n_=1 then
		do;

			if 0 then
				set orion.shoesales;
			declare hash expensive(dataset: 'orion.shoesales', multidata : "NO", 
				ordered: "ascending");
			expensive.definekey("TotalRetailPrice");
			expensive.definedata("TotalRetailPrice", "ProductID", "productName");
			expensive.definedone();
		end;
	declare hiter h("expensive");
	h.last();

	do i=1 to 5;
		Rank=CATX("", "Top", i);
		output;
		h.prev();
	end;
	h.first();

	do i=1 to 5;
		rank=CATX("", "Bottom", i);
		output;
		h.next();
	end;
run;

proc print data=group;
	title "ranking of shoes sales";
run;

******************Challenge******************;

data different;
	drop rc;

	if _n_=1 then
		do;

			if 0 then
				set orion.orderfact(keep=customerID ordertype) nobs=totobs;
			declare hash h(dataset: "orion.orderfact", multidata: "No", ordered: "Ascending");
			h.definekey("CustomerID", "ordertype");
			h.definedata("CustomerID", "ordertype");
			h.definedone();
		declare hiter o("h");
			o.first();
		end;
rc = 0;
	do while(rc = 0);
		output;
		rc=o.next();
		putlog rc;
	end;
run;
proc print data= different(obs=5);
title 'no duplicates';
run;