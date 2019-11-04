***Quadratic constrained Programming
variable of, x1, x2;
equations eq1, eq2, eq3;
eq1.. -3*x1*x1 -10*x1 +x2*x2 -3*x2 =e= OF;
eq2.. x1+x2*x2 =g= 2.5;
eq3.. 2*x1+x2=e= 1;
Model QCP1 /all/;
Solve QCP1 US QCP max OF;
Display of.l, x1.l, x2.l;

