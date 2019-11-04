*** Simple linear programming model for determination of boundary values of an objective function

Variable x1, x2, x3, of;
Equation eq1, eq2, eq3, eq4;

eq1.. x1 + 2*x2        =l= 3;
eq2..        x2 +   x3 =l= 2;
eq3.. x1 +   x2 +   x3 =e= 4;
eq4.. x1 + 2*x2 - 3*x3 =e= of;

Model BLP / all /;

x1.lo = 0; x1.up = 5;
x2.lo = 0; x2.up = 3;
x3.lo = 0; x3.up = 2;

solve BLP using lp maximizing of;
display x1.l, x2.l, x3.l, of.l;

solve BLP using LP minimizing of;
display x1.l, x2.l, x3.l, of.l;
*** Notice that solution is generated twice.
*** interval optimization, fuzzy optimization and DC power flow
