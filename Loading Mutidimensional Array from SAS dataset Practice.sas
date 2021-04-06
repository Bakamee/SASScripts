libname orion "/folders/myshortcuts/SAS_projects/DidiesFiles/ecpr363r";
************Practice level 1*****************;

proc print data=orion.coupons;
run;

proc print data=orion.orderfact(obs=10);
run;

data CouponValue(drop= i j quantity1-quantity6 );
	array c{3, 1:6} _temporary_;

	if _n_=1 then
		do;

			do i=1 to 3;
				set orion.coupons;
				array temp{6} Quantity1-quantity6;

				do j=1 to 6;
					c{i, j}= temp{j};
				end;
			end;
		end;
		set orion.orderfact(keep= customerID ordertype quantity);
	CouponValue = c{ordertype, quantity};
run;

proc print data= couponvalue(obs=5);
run;

*****************Practice level 2*******************;
proc print data= orion.msp;
run;

proc print data= orion.shoesales;
run;
