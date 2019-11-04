variable of, x1, x2, x3, x4;
equations
eq1, eq2, eq3;
eq1.. x1*x4*(x1+x2+x3)+x2 =e= OF;
eq2.. x1*x2*x3*x4 =g= 20;
eq3.. x1*x1+x2*x2+x3*x3+x4*x4 =e= 30;
x1.lo = 1; x1.up = 3;
x2.lo = 1; x2.up = 3;
x3.lo = 1; x3.up = 3;
x4.lo = 1; x4.up = 3;
Model NLP1 /all/;
Solve NLP1 US NLP max of;
Display of.l, x1.l, x2.l, x3.l, x4.l;

