
*************************** ELD Program ***************************************
set m/m1,m2/, p/p1*p3/;
***for 2 machines and 3 products
***or set i /1,2,3/*********
Parameter profit(P)
***profit on selling each product in $/Kg
/p1 10
p2 12
p3 13.5/;
Parameter avl(M)
*** machine availablity in hours
/m1 16
m2 12/;
Table task(m,p)
***Required time for task completion (h)
   p1 p2 p3
m1  2  5  2
m2  3  4  1;
*****************************
Variables gain, x(p);
*****************************
Equations obj, eq1;
obj.. gain =e= sum(p, profit(p)*x(p));
eq1(m).. sum(p, task(m,p)*x(p)) =l= avl(M);
***lower limit of units to be produced
x.lo(p) = 1;
*****************************
Model LP2 /all/;
*****************************
Solve LP2 using LP maximize gain;
Display gain.l, x.l;
