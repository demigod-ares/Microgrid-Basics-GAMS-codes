*** Optimal power flow for a three-bus system
Set Gen/g1*g2/, bus/1*2/;
Scalar L2/400/, X12/0.2/, Sbase/100/, P12_max/1.5/;
Table data(Gen,*)
       a     b      c      Pmin  Pmax
   G1  3     20     100    28    206
   G2  4.05  18.07  98.87  90    284;
Variable P(gen), OF, delta(bus), P12;
Equation eq1, eq2, eq3, eq4;
eq1.. OF =e= sum(gen,data(gen,'a')*P(gen)*P(gen)+data(gen,'b')*P(gen)+data(gen,'c'));
eq2.. P('G1') =e= P12;
eq3.. P('G2')+P12 =e= L2/Sbase;
eq4.. P12 =e= (delta('1') - delta('2'))/X12;
P.lo(gen) = data(gen,'Pmin')/Sbase;
P.up(gen) = data(gen,'Pmax')/Sbase;
P12.lo = -P12_max;
P12.up = P12_max;
delta.fx('1')=0;
Model OPF / all /;
solve OPF using QCP minimizing OF;
display P.l, P12.l;
