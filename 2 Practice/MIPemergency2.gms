set city /1*6/;
alias(city,town);
binary variable x (city);
variable OF;
table data (city, town)
  1 2  3  4  5  6
1 0 30 46 22 24 19
2   0  54 32 43 24
3      0  44 16 28
4         0  14 43
5            0  12
6               0;
data(city,town)$data(town,city) = data(town,city);
scalar criticaltime /20/;
Equations
eq1, eq2;
eq1(city).. sum(town$(data(city,town) < criticaltime), x(town)) =g= 1;
eq2.. OF =e= sum(city, x(city));
Model emergency / all /;
Solve emergency using MIP min OF;
Display x.l

