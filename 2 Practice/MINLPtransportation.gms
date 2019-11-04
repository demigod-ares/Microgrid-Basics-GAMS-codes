*** Mixed Integer Nonlinear Programming
*** Transportation model with On/off state modeling of production side
Set
i / s1*s3 /
j / d1*d4 /;
Table c(i,j)
    d1      d2      d3      d4
s1  0.0755  0.0655  0.0498  0.0585
s2  0.0276  0.0163  0.096   0.0224
s3  0.068   0.0119  0.034   0.0751;
Table data(i,*)
    'Pmin'  'Pmax'
s1  100     450
s2  50      350
s3  30      500;
Parameter demand(j) /d1 217,d2 150,d3 145,d4 244/;
***********************************************************
Variable of, P(i), x(i,j);
*** integer variable x(i,j);  <BAD OPTIMIZER !!!>
Binary Variable U(i);
Equation eq1, eq2(i), eq3(i), eq4(j), eq5(i);
eq1..    OF   =e= sum((i,j), c(i,j)*sqr(x(i,j)));
eq2(i).. P(i) =l= data(i,'Pmax')*U(i);
eq3(i).. P(i) =g= data(i,'Pmin')*U(i);
eq4(j).. sum(i, x(i,j)) =g= demand(j);
eq5(i).. sum(j, x(i,j)) =e= P(i);
P.lo(i)   = 0; P.up(i)   = data(i,'Pmax');
x.lo(i,j) = 0; x.up(i,j) = 100;
************************************************************
Model minlp / all /;
solve minlp using MINLP minimizing OF;
Display x.l, OF.l;

