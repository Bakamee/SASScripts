libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";

data newdescriptions;
	if _n_=1 then
		do;
			declare hash T();
			T.definekey("continentID");
			T.definedata("continentname");
			T.definedone();
		end;
	set orion.continent end=last;
	T.add(key: continentID, data: continentname);

	if last then
		do;

			do i=1 to tot;
				length continentname $30.;
				set orion.country nobs=tot;
				rc=T.find(key: continentID);
				output;
			end;
		end;
run;

proc print data=newdescriptions;
run;