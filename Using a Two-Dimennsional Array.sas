libname orion "/opt/sas/data";
*******************Practice level 1***************************;

proc print data=orion.orderfact;
run;

data customercoupons;
	array pct{3, 6} _temporary_ (10 10 15 20 20 25 10 15 20 25 25 30 10 15 15 20 
		25 25);
	set orion.orderfact(keep=customerID ordertype quantity);
	CouponValue=pct{orderType, Quantity};
run;

proc print data=customercoupons(obs=5);
run;

*******************Practice level 2***********************;

data combine(drop=prodln prodid);
	format prodID 2.;
	array msp{21:24, 1:2} _temporary_ (. 70.79 173.79 174.40 . . 29.65 287.8);
	set orion.shoesales;
	prodln=input(substr(productID, 1, 2), 2.);
	prodid=input(substr(productID, 3, 2), 2.);
	AvgPrice=msp{prodln, prodid};
	format AvgPrice dollar12.2;
run;

proc print data=combine(obs=5);
	title "Coupon Value";
run;

********************Challenge*************************;
*Copied Code;

data warehouses;
	set orion.productlist(keep=ProductID ProductName ProductLevel 
		where=(ProductLevel=1));
		
	ProdID=put(productID, 12.);
	productLine=input(substr(ProdID, 1, 2), 2.);
	ProductCategory=input(Substr(ProdID, 3, 2), 2.);
	ProductLocID=input(substr(ProdID, 12, 1), 1.);

	if productLine in (21, 22) and productCategory <=2 and ProductlocId <2;
run;


*****************************;
