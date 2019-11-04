***Mixed integer linear programming model for optimal allocation of Emergency Centres
Binary Variable x1, x2, x3, x4, x5, x6;
Variable of;
Equation eq1, eq2, eq3, eq4, eq5, eq6, eq7;

eq1.. x1                    + x6  =g= 1;
eq2..      x2                     =g= 1;
eq3..           x3      + x5      =g= 1;
eq4..                x4 + x5      =g= 1;
eq5..           x3 + x4 + x5 + x6 =g= 1;
eq6.. x1                + x5 + x6 =g= 1;
eq7.. x1 + x2 + x3 + x4 + x5 + x6 =e= of;

Model MIPemergency / all /;
solve MIPemergency using MIP minimizing of;
display x1.l, x2.l, x3.l, x4.l, x5.l, x6.l;
