*** Environmental Load Dispatch - Various Load Models
Set Gen / g1*g5 /;
Scalar load   / 400 /, Eprice / 0.1 /;
Table data(Gen,*)
       a     b      c       d     e      f     Pmin  Pmax
   G1  3     20     100     2     -5     3     28    206
   G2  4.05  18.07  98.87   3.82  -4.24  6.09  90    284
   G3  4.05  15.55  104.26  5.01  -2.15  5.69  68    189
   G4  3.99  19.21  107.21  1.1   -3.99  6.2   76    266
   G5  3.88  26.18  95.31   3.55  -6.88  5.57  19    53;
Variable P(gen), OF, TE, TC;
Equation eq1, eq2, eq3, eq4;
eq1.. TC =e= sum(gen, data(gen,'a')*P(gen)*P(gen)+data(gen,'b')*P(gen)+data(gen,'c'));
eq2.. sum(gen, P(gen)) =g= load;
eq3.. TE =e= sum(gen, data(gen,'d')*P(gen)*P(gen)+data(gen,'e')*P(gen)+data(gen,'f'));
eq4.. OF =e= TC + TE*Eprice;
P.lo(gen) = data(gen,'Pmin');
P.up(gen) = data(gen,'Pmax');

Model END / eq1, eq2, eq3, eq4 /;
Parameter report(gen,*);

solve END using qcp minimizing TC;
report(gen,'ED') = P.l(gen);
display TC.l, TE.l, OF.l;
solve END using qcp minimizing TE;
report(gen,'END') = P.l(gen);
display TC.l, TE.l, OF.l;
solve END using qcp minimizing OF;
report(gen,'penalty') = P.l(gen);
display TC.l, TE.l, OF.l;
*** Maximum limit for total emission for Penalty model
TE.up = 90000;
solve END using qcp minimizing TC;
report(gen,'limit') = P.l(gen);
display TC.l, TE.l, OF.l;
* Printing generation report
display report;
