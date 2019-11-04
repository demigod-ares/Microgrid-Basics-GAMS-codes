***title Economic Load Dispatch

Set Gen / g1*g5 /;

Scalar load / 400 /;

Table data(Gen,*)
       a     b      c       Pmin  Pmax
   G1  3     20     100     28    206
   G2  4.05  18.07  98.87   90    284
   G3  4.05  15.55  104.26  68    189
   G4  3.99  19.21  107.21  76    266
   G5  3.88  26.18  95.31   19    53;
Variable P(gen), OF;
Equation eq1, eq2;
eq1.. OF =e= sum(gen,data(gen,'a')*P(gen)*P(gen)+data(gen,'b')*P(gen)+data(gen,'c'));
eq2.. sum(gen,P(gen)) =g= load;
P.lo(gen) = data(gen,'Pmin');
P.up(gen) = data(gen,'Pmax');
*********************************
Model ED /eq1, eq2/;
Solve ED using QCP minimizing OF;
Display OF.l, P.l;
