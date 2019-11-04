
*************************** ELD Program ***************************************
Set i /1*3/;
***or set i /1,2,3/*********
Parameters
a(i) Cost cofficient /1 100, 2 200, 3 300/
b(i) Cost cofficient /1 10, 2 15, 3 12/
c(i) Cost cofficient /1 0.01, 2 0.05, 3 0.08/
Pd demand /300/
Pmax(i) maximum gen limit /1 200, 2 150, 3 100/
Pmin(i) minimum gen limit /1 20, 2 15, 3 10/;
*****************************
Variables cost, P(i);
*****************************
Equations obj, eq1, eq2(i), eq3(i);
*****************************
obj.. cost =e= sum(i, a(i)+b(i)*p(i)+c(i)*p(i)*p(i));
eq1.. Pd =e= sum(i, p(i));
eq2(i).. Pmin(i) =l= P(i);
eq3(i).. Pmax(i) =g= P(i);
*****************************
Model ELD /all/;
*****************************
Solve ELD using NLP minimizing cost;
Display cost.l, P.l;

