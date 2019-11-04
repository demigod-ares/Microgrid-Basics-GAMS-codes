***Simple Mixed Integer Linear Programming model
Variable x, of;
Binary Variable y;
Equation eq1, eq2, eq3;

eq1.. -3*x +  2*y =g=  1;
eq2.. -8*x + 10*y =l= 10;
eq3..    x +    y =e= of;

Model MIP / all /;

x.up = 0.3;
solve MIP using MIP maximizing of;
display y.l, x.l, of.l;
