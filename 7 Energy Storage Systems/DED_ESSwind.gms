***Cost based Dynamic Economic Dispatch integrated with Energy Storage & Wind
Set t/t1*t24/, g/g1*g4/;
Table gendata(g,*) 'generator cost characteristics and limits'
       a     b      c    d     e     f     Pmin  Pmax  RU0  RD0
   g1  0.12  14.80  89   1.2  -5     3     28    200   40   40
   g2  0.17  16.57  83   2.3  -4.24  6.09  20    290   30   30
   g3  0.15  15.55  100  1.1  -2.15  5.69  30    190   30   30
   g4  0.19  16.21  70   1.1  -3.99  6.2   20    260   50   50;
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
Variable OBJ, cost, p(g,t), SOC(t), Pd(t), Pc(t), Pw(t), PWC(t);
Scalar SOC0/100/, SOCmax/300/, eta_c/0.95/, eta_d/0.9/, VWC/50/;
p.up(g,t)= gendata(g,"Pmax"); p.lo(g,t)= gendata(g,"Pmin");
SOC.up(t)= SOCmax; SOC.lo(t)= 0.2*SOCmax; SOC.fx('t24')= SOC0;
Pc.up(t)= 0.2*SOCmax; Pc.lo(t)= 0; Pd.up(t)= 0.2*SOCmax; Pd.lo(t)= 0;
Pw.up(t)= data(t,'wind'); Pw.lo(t)= 0; PWC.up(t)= data(t,'wind'); PWC.lo(t)= 0;
Equation Genconst3, Genconst4, costcalc, balance, constESS, wind;
costcalc.. cost =e= sum(t, VWC*pwc(t))+sum((t,g),gendata(g,'a')*power(p(g,t),2)+gendata(g,'b')*p(g,t)+gendata(g,'c'));
Genconst3(g,t).. p(g,t+1)-p(g,t) =l= gendata(g,'RU0');
Genconst4(g,t).. p(g,t-1)-p(g,t) =l= gendata(g,'RD0');
constESS(t).. SOC(t) =e= SOC0$(ord(t)=1)+SOC(t-1)$(ord(t)>1)+Pc(t)*eta_c-Pd(t)/eta_d;
* Delta_t is 1 hour in the above equation
balance(t).. Pw(t)+sum(g,p(g,t))+Pd(t) =g= data(t,'load')+Pc(t);
wind(t).. Pw(t)+PWC(t) =e= data(t,'wind');
Model DEDESS /all/;
solve DEDESS using QCP minimizing cost;
Parameter rep(t,*);
rep(t,'Pth')  = sum(g,p.l(g,t));
rep(t,'SOC')  = SOC.l(t);
rep(t,'Pd')   = Pd.l(t);
rep(t,'Pc')   = Pc.l(t);
rep(t,'Pw')   = Pw.l(t);
rep(t,'PWC')  = Pwc.l(t);
rep(t,'Load') = data(t,'load');
Display rep, cost.l;
