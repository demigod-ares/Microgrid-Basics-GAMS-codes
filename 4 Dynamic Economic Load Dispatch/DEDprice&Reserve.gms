*** Price based Dynamic Economic Load Dispatch with arbitrage
*** Price-Based DED Energy and Reserve Market
Set
   t 'hours'         / t1*t24 /
   i 'thermal units' / p1*p4 /;
Scalar lim /inf/;
Table gendata(i,*) 'generator cost characteristics and limits'
       a     b      c    d     e     f     Pmin  Pmax  RU0  RD0
   p1  0.12  14.80  89   1.2  -5     3     28    200   40   40
   p2  0.17  16.57  83   2.3  -4.24  6.09  20    290   30   30
   p3  0.15  15.55  100  1.1  -2.15  5.69  30    190   30   30
   p4  0.19  16.21  70   1.1  -3.99  6.2   20    260   50   50;
Table data(t,*)
           lambdaE      load       lambdaR
t1         32.71        510        25.55
t2         34.72        530        20.83
t3         32.71        516        19.68
t4         32.74        510        21.73
t5         32.96        515        22.43
t6         34.93        544        23.94
t7         44.9         646        42.22
t8         52           686        36.53
t9         53.03        741        21.41
t10        47.26        734        12.58
t11        44.07        748        13.86
t12        38.63        760        9.58
t13        39.91        754        7.18
t14        39.45        700        12.16
t15        41.14        686        18.2
t16        39.23        720        17.83
t17        52.12        714        24.13
t18        40.85        761        18.8
t19        41.2         727        18.02
t20        41.15        714        17.03
t21        45.76        618        13.37
t22        45.59        584        16.94
t23        45.56        578        19.05
t24        34.72        544        13.58 ;
Variable
   OF          'objective (revenue)'
   costThermal 'cost of thermal units'
   p(i,t)      'power generated by thermal power plant'
   EM          'emission calculation'
   SR(i,t)     'Spinning reserve calculation';
p.up(i,t) = gendata(i,"Pmax"); p.lo(i,t) = gendata(i,"Pmin");
SR.up(i,t) = gendata(i,"Pmax"); SR.lo(i,t) = 0;
Equation Genconst3, Genconst4, costThermalcalc, balance, EMcalc, EMlim, benefitcalc, reserve;
costThermalcalc.. costThermal =e= sum((t,i),gendata(i,'a')*power(p(i,t),2)+gendata(i,'b')*p(i,t)+gendata(i,'c'));
Genconst3(i,t).. p(i,t+1)-p(i,t) =l= gendata(i,'RU0');
Genconst4(i,t).. p(i,t-1)-p(i,t) =l= gendata(i,'RD0');
balance(t).. sum(i,p(i,t)) =l= data(t,'load');
EMcalc.. EM =e= sum((t,i),gendata(i,'d')*power(p(i,t),2)+gendata(i,'e')*p(i,t)+gendata(i,'f'));
EMlim.. EM =l= lim;
benefitcalc.. OF =e= sum((i,t),1*data(t,'lambdaE')*p(i,t)+data(t,'lambdaR')*SR(i,t))-costThermal;
reserve(i,t).. SR(i,t) =l= gendata(i,"Pmax")-p(i,t);
Model DEDPB /all/;
Solve DEDPB using QCP maximizing OF;
Display OF.l, p.l, SR.l, EM.l;
