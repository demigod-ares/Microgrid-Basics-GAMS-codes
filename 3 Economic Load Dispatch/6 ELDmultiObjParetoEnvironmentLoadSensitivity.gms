*** Sensitivity analysis for load values in Multi-objective Economic-Environmental Load Dispatch

Set Gen /g1*g5/, counter /c1*c11/, Loadcounter / Lc1*Lc4 /;
Scalar load /400/, Eprice /0.1/, Elim;
Table data(Gen,*)
       a     b      c       d     e      f     Pmin  Pmax
   G1  3     20     100     2     -5     3     28    206
   G2  4.05  18.07  98.87   3.82  -4.24  6.09  90    284
   G3  4.05  15.55  104.26  5.01  -2.15  5.69  68    189
   G4  3.99  19.21  107.21  1.1   -3.99  6.2   76    266
   G5  3.88  26.18  95.31   3.55  -6.88  5.57  19    53;
Variable P(gen), OF, TE, TC;
Equation eq1, eq2, eq3;
eq1.. TC =e= sum(gen,data(gen,'a')*P(gen)*P(gen)+data(gen,'b')*P(gen)+data(gen,'c'));
eq2.. sum(gen, P(gen)) =g= load;
eq3.. TE =e= sum(gen,data(gen,'d')*P(gen)*P(gen)+data(gen,'e')*P(gen)+data(gen,'f'));
P.lo(gen) = data(gen,'Pmin');
P.up(gen) = data(gen,'Pmax');

Model END / eq1, eq2, eq3 /;
parameter report(Loadcounter,*), report2(Loadcounter,counter,*), report3(Loadcounter,counter,gen);

* load values in the report are 400, 450, 500, 550
Loop (Loadcounter,
 load = 350 + ord(Loadcounter)*50;
 solve END using qcp minimizing TC;
 report(Loadcounter,'maxTE') = TE.l;
 report(Loadcounter,'minTC') = TC.l;
 solve END using QCP minimizing TE;
 report(Loadcounter,'maxTC') = TC.l;
 report(Loadcounter,'minTE') = TE.l;
 Loop(counter,
   Elim  = (report(Loadcounter,'maxTE')-report(Loadcounter,'minTE'))*((ord(counter)-1)/(card(counter)-1))+report(Loadcounter,'minTE');
   TE.up =  Elim;
   solve END using QCP minimizing TC;
   report2(Loadcounter,counter,'TC') = TC.l;
   report2(Loadcounter,counter,'TE') = TE.l;
   report3(Loadcounter,counter,gen) = P.l(gen); );
*** this next statement is very important to Reset the TEmax to inf from Elim
 TE.up = inf; );
display report, report2, report3, TE.l, TC.l;
