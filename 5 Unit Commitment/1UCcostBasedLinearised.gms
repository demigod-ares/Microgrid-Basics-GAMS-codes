*** Unit commitment(cost based) using linear model
Set
   t 'time'               / t1*t24 /
   i 'generators indices' / g1*g10 /
   k 'cost segments'      / sg1*sg20 /
   char                   / ch1*ch2 /;
Alias (t,h);
Table gendata(i,*) 'generator cost characteristics and limits'
        a      b     c    CostsD  costst  RU   RD   UT  DT  SD   SU   Pmin Pmax U0 Uini S0
   g1   0.0148 12.1  82   42.6    42.6    40   40   3   2   90   110  80   200  1  0    1
   g2   0.0289 12.6  49   50.6    50.6    64   64   4   2   130  140  120  320  2  0    0
   g3   0.0135 13.2  100  57.1    57.1    30   30   3   2   70   80   50   150  3  0    3
   g4   0.0127 13.9  105  47.1    47.9    104  104  5   3   240  250  250  520  1  1    0
   g5   0.0261 13.5  72   56.6    56.9    56   56   4   2   110  130  80   280  1  1    0
   g6   0.0212 15.4  29   141.5  141.5    30   30   3   2   60   80   50   150  0  0    0
   g7   0.0382 14.0  32   113.5  113.5    24   24   3   2   50   60   30   120  0  1    0
   g8   0.0393 13.5  40   42.6    42.6    22   22   3   2   45   55   30   110  0  0    0
   g9   0.0396 15.0  25   50.6    50.6    16   16   0   0   35   45   20   80   0  0    0
   g10  0.0510 14.3  15   57.1    57.1    12   12   0   0   30   40   20   60   0  0    0;
Parameter data(k,i,*);
data(k,i,'DP')       =(gendata(i,"Pmax") - gendata(i,"Pmin"))/card(k);
data(k,i,'Pini')     =(ord(k) - 1)*data(k,i,'DP') + gendata(i,"Pmin");
data(k,i,'Pfin')     = data(k,i,'Pini') + data(k,i,'DP');
data(k,i,'Cini')     = gendata(i,"a")*power(data(k,i,'Pini'),2) + gendata(i,"b")*data(k,i,'Pini') + gendata(i,"c");
data(k,i,'Cfin')     = gendata(i,"a")*power(data(k,i,'Pfin'),2) + gendata(i,"b")*data(k,i,'Pfin') + gendata(i,"c");
data(k,i,'s')        =(data(k,i,'Cfin') - data(k,i,'Cini'))/data(k,i,'DP');
gendata(i,'Mincost') = gendata(i,'a')*power(gendata(i,"Pmin"),2) + gendata(i,'b')*gendata(i,"Pmin") + gendata(i,'c');
Table dataLP(t,*)
        lambda  load
   t1   14.72   883
   t2   15.62   915
   t3   14.72   1010
   t4   14.73   1149
   t5   14.83   1236
   t6   15.72   1331
   t7   20.21   1397
   t8   23.40   1419
   t9   23.86   1455
   t10  21.27   1455
   t11  19.83   1441
   t12  17.38   1419
   t13  17.96   1397
   t14  17.75   1339
   t15  18.51   1368
   t16  17.65   1339
   t17  23.45   1236
   t18  18.38   1105
   t19  18.54   1038
   t20  18.52   959
   t21  20.59   922
   t22  20.52   885
   t23  20.50   915
   t24  15.62   834;
Parameter unit(i,char);
unit(i,'ch1') = 24;
unit(i,'ch2') =(gendata(i,'UT') - gendata(i,'U0'))*gendata(i,'Uini');
Parameter unit2(i,char);
unit2(i,'ch1')  = 24;
unit2(i,'ch2')  =(gendata(i,'DT') - gendata(i,'S0'))*(1 - gendata(i,'Uini'));
gendata(i,'Lj') = smin(char,unit(i,char));
gendata(i,'Fj') = smin(char,unit2(i,char));
Variable costThermal;
Positive Variable pu(i,t), p(i,t), StC(i,t), SDC(i,t), Pk(i,t,k);
Binary Variable u(i,t), y(i,t), z(i,t);
p.up(i,t)    = gendata(i,"Pmax"); p.lo(i,t)    = 0;
Pk.up(i,t,k) = data(k,i,'DP'); Pk.lo(i,t,k) = 0;
pu.up(i,h)   = gendata(i,"Pmax");
Equation Uptime1, Uptime2, Uptime3, Dntime1, Dntime2, Dntime3, Ramp1, Ramp2, Ramp3, Ramp4,
   startc, shtdnc, genconst1, Genconst2, Genconst3, Genconst4, balance;
Uptime1(i)$(gendata(i,"Lj")>0).. sum(t$(ord(t)<(gendata(i,"Lj")+1)), 1-U(i,t)) =e= 0;
Uptime2(i)$(gendata(i,"UT")>1).. sum(t$(ord(t)>24-gendata(i,"UT")+1), U(i,t)-y(i,t)) =g= 0;
Uptime3(i,t)$(ord(t)>gendata(i,"Lj") and ord(t)<24-gendata(i,"UT")+2 and not(gendata(i,"Lj")>24-gendata(i,"UT")))..
   sum(h$((ord(h)>ord(t)-1) and (ord(h)<ord(t)+gendata(i,"UT"))), U(i,h)) =g= gendata(i,"UT")*y(i,t);
Dntime1(i)$(gendata(i,"Fj")>0).. sum(t$(ord(t)<(gendata(i,"Fj")+1)), U(i,t)) =e= 0;
Dntime2(i)$(gendata(i,"DT")>1).. sum(t$(ord(t)>24-gendata(i,"DT")+1), 1 - U(i,t)-z(i,t)) =g= 0;
Dntime3(i,t)$(ord(t)>gendata(i,"Fj") and ord(t)<24-gendata(i,"DT")+2 and not(gendata(i,"Fj")>24-gendata(i,"DT")))..
   sum(h$((ord(h)>ord(t)-1) and (ord(h)<ord(t)+gendata(i,"DT"))), 1-U(i,h)) =g= gendata(i,"DT")*z(i,t);
startc(i,t).. StC(i,t) =g= gendata(i,"costst")*y(i,t);
shtdnc(i,t).. SDC(i,t) =g= gendata(i,"CostsD")*z(i,t);
genconst1(i,h).. p(i,h) =e= u(i,h)*gendata(i,"Pmin") + sum(k, Pk(i,h,k));
Genconst2(i,h)$(ord(h)>0).. U(i,h) =e= U(i,h-1)$(ord(h)>1)+gendata(i,"Uini")$(ord(h)=1)+y(i,h)-z(i,h);
Genconst3(i,t,k).. Pk(i,t,k) =l= U(i,t)*data(k,i,'DP');
Genconst4.. costThermal =e= sum((i,t),StC(i,t)+SDC(i,t))+sum((t,i),u(i,t)*gendata(i,'Mincost')+sum(k,data(k,i,'s')*pk(i,t,k)));
Ramp1(i,t).. p(i,t-1) - p(i,t) =l= U(i,t)*gendata(i,'RD')+z(i,t)*gendata(i,"SD");
Ramp2(i,t).. p(i,t)  =l= pu(i,t);
Ramp3(i,t)$(ord(t)<24).. pu(i,t) =l= (u(i,t)-z(i,t+1))*gendata(i,"Pmax")+z(i,t+1)*gendata(i,"SD");
Ramp4(i,t)$(ord(t)>1).. pu(i,t) =l= p(i,t-1)+U(i,t-1)*gendata(i,'RU')+y(i,t)*gendata(i,"SU");

balance(t).. sum(i, p(i,t)) =e= dataLP(t,'load');

Model UCLP / all /;
option optCr = 0.0;
solve UCLP minimizing costThermal using mip;
display data, costThermal.l;
