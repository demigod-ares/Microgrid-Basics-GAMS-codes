*** Benefit Maximization Transportation Example
sets
i /s1*s3/
j /D1*D4/;
scalar k/1.8/;
table C(i,j)
    d1      d2      d3      d4
s1  0.0755  0.0655  0.0498  0.0585
s2  0.0276  0.0163  0.096   0.0224
s3  0.068   0.0119  0.034   0.0751;
table data(i,*)
    'Pmin'   'Pmax'
s1  100      450
s2  50       350
s3  30       500;
parameter demand(j)
/d1 217, d2 150, d3 145, d4 244/;
variable of, x(i,j), P(i);
binary variable U(i);
equations eq1, eq2, eq3, eq4, eq5;
eq1.. OF =e= sum(i,k*P(i))-sum((i,j),C(i,j)*x(i,j)*x(i,j));
eq2(i).. P(i) =l= data(i,'Pmax')*U(i);
eq3(i).. P(i) =g= data(i,'Pmin')*U(i);
eq4(j).. sum(i,x(i,j)) =l= demand(j);
eq5(i).. sum(j,x(i,j)) =e= P(i);
P.lo(i)=0;
P.up(i)=data(i,'Pmax');
x.lo(i,j)=0;
x.up(i,j)=100;
Model minlp /all/;
Solve minlp US minlp max OF;
Display x.l, u.l, OF.l;

