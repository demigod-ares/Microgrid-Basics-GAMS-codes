***Pareto optimal front
Variable of1, of2, x1, x2;
Equation eq1, eq2, eq3, eq4;
eq1.. 4*x1 - 0.5*sqr(x2) =e= of1;
eq2.. -sqr(x1) + 5*x2    =e= of2;
eq3.. 2*x1 + 3*x2        =l= 10;
eq4.. 2*x1 -   x2        =g=  0;
x1.lo = 1; x1.up = 2;
x2.lo = 1; x2.up = 3;
Set counter / c1*c21 /;
Scalar E;
Parameter report(counter,*), ranges(*);

Model pareto / all /;
solve pareto using NLP maximizing of1;
ranges('OF1max') = of1.l;
ranges('OF2min') = of2.l;
display of1.l, of2.l;
solve pareto using nlp maximizing of2;
ranges('OF2max') = of2.l;
ranges('OF1min') = of1.l;
display of1.l, of2.l;

loop(counter,
   E = (ranges('OF2max')-ranges('OF2min'))*(ord(counter)-1)/(card(counter)-1)+ranges('OF2min');
   of2.lo = E;
   solve pareto using nlp maximizing of1;
   report(counter,'OF1') = of1.l;
   report(counter,'OF2') = of2.l;
   report(counter,'E')   = E;);
display report;
