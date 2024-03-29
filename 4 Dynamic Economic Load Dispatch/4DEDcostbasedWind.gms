*** Price based Dynamic Economic Load Dispatch
Set
   t 'hours'         / t1*t24 /
   i 'thermal units' / p1*p4  /;
Scalar lim /inf/, VWC /50/;
Table gendata(i,*) 'generator cost characteristics and limits'
       a     b      c    d     e     f     Pmin  Pmax  RU0  RD0
   p1  0.12  14.80  89   1.2  -5     3     28    200   40   40
   p2  0.17  16.57  83   2.3  -4.24  6.09  20    290   30   30
   p3  0.15  15.55  100  1.1  -2.15  5.69  30    190   30   30
   p4  0.19  16.21  70   1.1  -3.99  6.2   20    260   50   50;
Table data(t,*)
        lambda  load  wind
   t1   32.71   510   44.1
   t2   34.72   530   48.5
   t3   32.71   516   65.7
   t4   32.74   510   144.9
   t5   32.96   515   202.3
   t6   34.93   544   317.3
   t7   44.9    646   364.4
   t8   52      686   317.3
   t9   53.03   741   271
   t10  47.26   734   306.9
   t11  44.07   748   424.1
   t12  38.63   760   398
   t13  39.91   754   487.6
   t14  39.45   700   521.9
   t15  41.14   686   541.3
   t16  39.23   720   560
   t17  52.12   714   486.8
   t18  40.85   761   372.6
   t19  41.2    727   367.4
   t20  41.15   714   314.3
   t21  45.76   618   316.6
   t22  45.59   584   311.4
   t23  45.56   578   405.4
   t24  34.72   544   470.4;
Variable
   OF          'objective (revenue)'
   costThermal 'cost of thermal units'
   p(i,t)      'power generated by thermal power plant'
   EM          'emission calculation'
   Pw(t)       'wind power'
   Pwc(t)      'wind curtailmet';
Pw.up(t) = data(t,'wind'); Pw.lo(t) = 0;
Pwc.up(t) = data(t,'wind'); Pwc.lo(t) = 0;
p.up(i,t) = gendata(i,"Pmax"); p.lo(i,t) = gendata(i,"Pmin");
Equation Genconst3, Genconst4, costThermalcalc, balance, EMcalc, EMlim, wind;
costThermalcalc.. costThermal =e= sum((t,i),gendata(i,'a')*power(p(i,t),2)+gendata(i,'b')*p(i,t)+gendata(i,'c'));
Genconst3(i,t).. p(i,t+1)-p(i,t) =l= gendata(i,'RU0');
Genconst4(i,t).. p(i,t-1)-p(i,t) =l= gendata(i,'RD0');
balance(t).. sum(i,p(i,t))+ Pw(t) =g= data(t,'load');
EMcalc.. EM =e= sum((t,i), gendata(i,'d')*power(p(i,t),2)+gendata(i,'e')*p(i,t)+gendata(i,'f'));
EMlim.. EM =l= lim;
wind(t).. Pw(t) + Pwc(t) =e= data(t,'wind')
Model DEDwindCB /all/;
solve DEDwindCB using QCP minimizing costThermal;
Display costThermal.l, p.l, Pw.l, Pwc.l, EM.l;