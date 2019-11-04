* Water-Energy Nexus
Set t/t1*t24/, i/p1*p4/, c/c1*c3/, w/w1/;
Table gendata(i,*) 'generator cost characteristics and limits'
       a          b        c      Pmax  Pmin
   p1  0.0002069  -0.1483  57.11  500   0
   p2  0.0003232  -0.1854  57.11  400   0
   p3  0.001065   -0.6026  126.8  400   0
   p4  0.0004222  -0.2119  57.11  350   0   ;
Table Coproduct(c,*)
       Pmax Pmin Wmax Wmin rmin rmax A11       A12      A22       b1     b2    C
   c1  800  160  200  30   4    9    0.0004433 0.003546 0.007093 -1.106 -4.426 737.4
   c2  600  120  150  23   4    9    0.0007881 0.006305 0.01261  -1.475 -5.901 737.4
   c3  400  80   100  15   4    9    0.001773  0.01419  0.02837  -2.213 -8.851 737.4;
Table waterdata(w,*)
       a          b         c      Wmax  Wmin
   w1  1.82E-02  -7.081e-1  7.374  250   0   ;
Table PWdata(t,*)
        Pd   water
   t1   1250 150
   t2   1125 130
   t3   875  100
   t4   750  150
   t5   950  200
   t6   1440 350
   t7   1500 300
   t8   1750 200
   t9   2000 300
   t10  2250 400
   t16  2500 550
   t17  2125 550
   t18  2375 500
   t19  2250 400
   t20  1975 350
   t21  1750 300
   t22  1625 250
   t23  1500 200
   t24  1376 150  ;

Variable of, p(i,t), TC, CC, Pc(c,t), Wc(c,t), Water(w,t), WaterCost;
Binary   Variable Up(i,t), Uc(c,t), Uw(w,t);
Positive Variable p, Pc, Wc, Water;

p.up(i,t)     = gendata(i,'Pmax');
Pc.up(c,t)    = Coproduct(c,'Pmax');
Wc.up(c,t)    = Coproduct(c,'Wmax');
Water.up(w,t) = waterdata(w,'Wmax');

Equation costThermal, balanceP(t), balanceW(t), costCoprodcalc, Objective, costwatercalc, ratio1(c,t), ratio2(c,t),
         eq1(w,t), eq2(w,t), eq3(c,t), eq4(c,t), eq5(c,t), eq6(c,t), eq7(i,t), eq8(i,t);

costThermal.. TC =e= sum((t,i),gendata(i,'a')*sqr(p(i,t))+gendata(i,'b')*p(i,t)+gendata(i,'c')*Up(i,t));
balanceP(t).. sum(i,p(i,t))+sum(c,Pc(c,t)) =e= PWdata(t,'Pd');
balanceW(t).. sum(w,Water(w,t))+sum(c,Wc(c,t)) =e= PWdata(t,'water');
costCoprodcalc.. CC =e= sum((c,t),Coproduct(c,'A11')*sqr(Pc(c,t))+2*Coproduct(c,'A12')*Pc(c,t)*Wc(c,t)+Coproduct(c,'A22')*sqr(Wc(c,t))
                                 +Coproduct(c,'B1')*Pc(c,t)+Coproduct(c,'B2')*Wc(c,t)+Coproduct(c,'C')*Uc(c,t));
costwatercalc.. WaterCost =e= sum((t,w), waterdata(w,'a')*sqr(Water(w,t))+waterdata(w,'b')*Water(w,t)+waterdata(w,'c')*Uw(w,t));
Objective.. of =e= TC + CC + WaterCost;
ratio1(c,t).. Pc(c,t) =l= Wc(c,t)*Coproduct(c,'Rmax');
ratio2(c,t).. Pc(c,t) =g= Wc(c,t)*Coproduct(c,'Rmin');
eq1(w,t).. Water(w,t) =l= Uw(w,t)*waterdata(w,'Wmax');
eq2(w,t).. Water(w,t) =g= Uw(w,t)*waterdata(w,'Wmin');
eq3(c,t).. wc(c,t) =l= Uc(c,t)*Coproduct(c,'Wmax');
eq4(c,t).. wc(c,t) =g= Uc(c,t)*Coproduct(c,'Wmin');
eq5(c,t).. Pc(c,t) =l= Uc(c,t)*Coproduct(c,'Pmax');
eq6(c,t).. Pc(c,t) =g= Uc(c,t)*Coproduct(c,'Pmin');
eq7(i,t).. p(i,t) =l= Up(i,t)*gendata(i,"Pmax");
eq8(i,t).. p(i,t) =g= Up(i,t)*gendata(i,"Pmin");

Model DEDcostbased / all /;
Solve DEDcostbased using MINLP min OF;
Display wc.l, Water.l, p.l, Pc.l;
