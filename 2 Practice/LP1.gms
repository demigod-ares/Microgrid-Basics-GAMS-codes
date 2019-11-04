***Simple linear programming model
Variable x1, x2, x3, of;
Equation eq1, eq2, eq3, eq4;

eq1.. x1 + 2*x2       =g= 3;
eq2.. x3 + x2         =g= 5;
eq3.. x1 + x3         =e= 4;
eq4.. x1 + 3*x2 +3*x3 =e= of;

Model LP1 / all /;

solve LP1 using LP minimizing of;
display x1.l, x2.l, x3.l, of.l;
