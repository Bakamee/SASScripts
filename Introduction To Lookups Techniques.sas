libname orion "/opt/sas/sasdata";


data countryinfo();
	array contName{91:96} $30 _temporary_ ("North America", "", "Europe", "Africa" "Asia", 
		"Australia/Pacific") ;
		set orion.country;
		continent = contName(continentID);
run;

proc print data=countryinfo;
title "with table lookup";
run;

proc print data= orion.country;
title "without table lookup";
run;