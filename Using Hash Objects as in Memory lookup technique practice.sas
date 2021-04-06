libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";
********Practice********;

data descriptions;
	length saletype $30.;

	if _n_=1 then
		do;
			declare hash T();
			T.definekey("ordertype");
			T.definedata('saletype');
			T.definedone();
			T.add(key: 1, data: "Retail Sale");
			T.add(key: 2, data: "Catalog Sale");
			T.add(key: 3, data: "Internet Sale");
		end;
	set orion.orders;
	rc = T.find(key: ordertype);
	putlog rc=;
	drop rc;
run;

proc print data= descriptions(obs = 5);
var OrderID OrderType SaleType;
run;