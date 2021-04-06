libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";
*declaring a hash object;
options details;

data;
	set orion.continent;
	declare hash Contname();
	contname.definekey("ContinentID");
	contname.definedata("ContinentName");
	contname.definedone();
run;

***Alternative syntax***;

data _null_;
	set orion.continent;
	declare hash T(dataset: 'orion.continent');
run;

***Alternative Syntax***;

data _null_;
	set orion.continent;
	declare hash T(hashexp: 10, ordered: "ascending");
run;

***Loading data into the hash object***;

proc print data=orion.continent;
run;

data;
set orion.continent;
	declare hash Contname();
	contname.definekey("ContinentID");
	contname.definedata("ContinentName");
	contname.definedone();
	contname.add(Key: 91, data: "North America");
	contname.add(key: 92, data : "Europe");
	contname.add(key: 93, data: "Africa");
	contname.add(key: 94, data: "Asia");
	contname.find(key: 94);
run;
