*** Combined Heat Power Dispatching
Sets Gen/g1*g2/, heat/h1*h2/, CHP/chp1*chp2/;
*** Electric load & Heating load
scalars Le/605/, Lh/540/;
Table dataTh (Gen,*)
    a    b     c     Pmin Pmax
 g1 3    20    100   28   206
 g2 4.05 18.07 98.87 90   284;
Table dataH (heat,*)
    a    b     c      hmin hmax
 h1 4.05 10.55 104.26 60   200
 h2 3.99 9.21  107.21 70   270;
Table datachp(chp,*)
       a       b   c     d     e    f
 chp1  0.0345  14  2540  0.03  4.2  0.031
 chp2  0.0435  13  1460  0.02  0.7  0.011;
Table FR(chp,*)
      Aq  Ap   Bq   Bp   Cq     Cp Dq Dp
 chp1 0   247  180  215  104.8  81 0  99
 chp2 0   125  135  110  75     40 0  45;
Variables P(gen), OF , q(heat), Pchp(chp), qchp(chp), Fth, Fh, Fchp;
Equations eq1, eq2, eq3, eq4, eq5, eq6, eq7a, eq7b, eq7c;
eq1.. OF =e= Fth+Fh+Fchp ;
eq2.. Fth =e= sum(gen,dataTh(gen,'a')*P(gen)*P(gen)+dataTh(gen,'b')*P(gen)+dataTh(gen,'c'));
eq3.. Fh =e= sum(heat,dataH(heat,'a')*q(heat)*q(heat)+dataH(heat,'b')*q(heat)+dataH(heat,'c'));
eq4.. Fchp =e= sum(CHP,datachp(CHP,'a')*Pchp(CHP)*Pchp(CHP)+datachp(CHP,'b')*Pchp(CHP)+datachp(CHP,'c')+datachp(CHP,'d')*qchp(CHP)*qchp(CHP)+datachp(CHP,'e')*qchp(CHP)+datachp(CHP,'f')*qchp(CHP)*pchp(CHP));
eq5.. sum(gen,P(gen))+sum(CHP, Pchp(CHP)) =g= Le;
eq6.. sum(heat,q(heat))+sum(CHP, Qchp(CHP)) =g= Lh;
eq7a(CHP).. Pchp(CHP)-FR(chp,'Dp') =g= (qchp(chp)-FR(chp,'Dq'))*(FR(chp,'Dp')-FR(chp,'Cp'))/(FR(chp,'Dq')-FR(chp,'Cq'));
eq7b(CHP).. Pchp(CHP)-FR(chp,'Ap') =l= (qchp(chp)-FR(chp,'Aq'))*(FR(chp,'Ap')-FR(chp,'Bp'))/(FR(chp,'Aq')-FR(chp,'Bq'));
eq7c(CHP).. Pchp(CHP)-FR(chp,'Bp') =g= (qchp(chp)-FR(chp,'Bq'))*(FR(chp,'Bp')-FR(chp,'Cp'))/(FR(chp,'Bq')-FR(chp,'Cq'));
P.lo(gen) = dataTh(gen,'Pmin'); P.up(gen) = dataTh(gen,'Pmax');
q.lo(heat) = dataH(heat,'hmin'); q.up(heat) = dataH(heat,'hmax');
Model chpdispatch /all/;
Solve chpdispatch using NLP min OF;
Display P.l, q.l, Pchp.l, qchp.l, Fth.l, Fh.l, Fchp.l, OF.l;
