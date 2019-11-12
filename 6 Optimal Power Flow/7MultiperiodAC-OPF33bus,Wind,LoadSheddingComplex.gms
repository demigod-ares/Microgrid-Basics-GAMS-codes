$title Multi-period AC-OPF for IEEE 33-bus network considering wind and load shedding
Set
   i        'network buses'    / 1*33 /
   slack(i)                    / 13 /
   t                           / t1*t24 /

Scalar Sbase/100/, VOLL 'value of loss of load($/Mwhr)'/1000/, VOLW 'value of loss of wind($/Mwhr)'/20/;
Alias (i,j);
* good technique to get rid of a set connecting bus & generator
Table GenD(i,*) 'generating units characteristics'
       pmax  pmin    a     b       c     Qmax  Qmin  Vg     RU  RD
   1   152   30.4    2.3   13.32   14    192   -50   1.035  21  21
   2   152   30.4    2.3   13.32   14    192   -50   1.035  21  21
   7   350   75      3.1   20.7    22    300   0     1.025  43  43
   13  591   206.85  2.4   20.93   22    591   0     1.02   31  31
   15  215   66.25   2.1   21      22    215   -100  1.014  31  31
   16  155   54.25   2.6   10.52   11    155   -50   1.017  31  31
   18  400   100     1.9   5.47    6     400   -50   1.05   70  70
   20  400   100     1.9   5.47    6     400   -50   1.05   70  70
   21  300   0       1.1   10      11    300   -60   1.05   53  53
   22  360   248.5   1.1   10.52   11    310   -125  1.05   31  31
   25  155   54.25   2.6   10.52   11.3  152   -50   1.02   21  21
   28  152   30.4    3.1   13.32   14.3  150   -50   1.018  14  14
   31  400   100     2.2   5.47    6.1   350   -98   1.04   47  47
   33  400   100     2.2   5.47    6.1   350   -100  1.04   47  47;
Table BD(i,*) 'demands of each bus in MW & MVar'
       Pd   Qd
   1   108  22
   2   97   20
   3   180  37
   4   74   15
   5   71   14
   6   136  28
   7   125  25
   8   171  35
   9   175  36
   10  195  40
   11  14   3
   12  16   2
   13  265  54
   14  194  39
   15  317  64
   16  100  20
   17  18   3
   18  333  68
   19  181  37
   20  128  26
   21  11   2
   22  14   3
   23  12   2
   24  18   1
   25  34   6
   26  180  43
   27  25   5
   28  16   2
   29  100  35
   30  208  28
   31  11   2
   32  9    1
   33  159  34;
Table LN(i,j,*) 'network technical characteristics'
        r        x        b       limit
1.2     0.0922   0.0470   0       175
2.3     0.4930   0.2511   0       175
3.4     0.3660   0.1864   0       400
4.5     0.3811   0.1941   0       500
5.6     0.8190   0.7070   0       200
6.7     0.1872   0.6188   0       400
7.8     0.7114   0.2351   0       175
8.9     1.0300   0.7400   0       1000
9.10    1.0440   0.7400   0       500
10.11   0.1966   0.0650   0       400
11.12   0.3744   0.1238   0       200
12.13   1.4680   1.1550   0       175
13.14   0.5416   0.7129   0       400
14.15   0.5910   0.5260   0       500
15.16   0.7463   0.5450   0       175
16.17   1.2890   1.7210   0       400
17.18   0.7320   0.5740   0       200
2.19    0.1640   0.1565   0       300
19.20   1.5042   1.3554   0       400
20.21   0.4095   0.4784   0       250
21.22   0.7089   0.9373   0       1000
3.23    0.4512   0.3083   0       500
23.24   0.8980   0.7091   0       250
24.25   0.8960   0.7011   0       175
6.26    0.2030   0.1034   0       400
26.27   0.2842   0.1447   0       300
27.28   1.0590   0.9337   0       600
28.29   0.8042   0.7006   0       700
29.30   0.5075   0.2585   0       175
30.31   0.9744   0.9630   0       500
31.32   0.3105   0.3619   0       200
32.33   0.3410   0.5302   0       1000
21.8    2.0000   2.0000   0       600
9.15    2.0000   2.0000   0       500
12.22   2.0000   2.0000   0       250
18.33   0.5000   0.5000   0       300
25.29   0.5000   0.5000   0       500;
Table WD(t,*)
        w                   d
*  t1   0.                  1.
   t1   0.0786666666666667  0.684511335492475
   t2   0.0866666666666667  0.644122690036197
   t3   0.117333333333333   0.6130691560297
   t4   0.258666666666667   0.599733282530006
   t5   0.361333333333333   0.588874071251667
   t6   0.566666666666667   0.5980186702229
   t7   0.650666666666667   0.626786054486569
   t8   0.566666666666667   0.651743189178891
   t9   0.484               0.706039245570585
   t10  0.548               0.787007048961707
   t11  0.757333333333333   0.839016955610593
   t12  0.710666666666667   0.852733854067441
   t13  0.870666666666667   0.870642027052772
   t14  0.932               0.834254143646409
   t15  0.966666666666667   0.816536483139646
   t16  1                   0.819394170318156
   t17  0.869333333333333   0.874071251666984
   t18  0.665333333333333   1
   t19  0.656               0.983615926843208
   t20  0.561333333333333   0.936368832158506
   t21  0.565333333333333   0.887597637645266
   t22  0.556               0.809297008954087
   t23  0.724               0.74585635359116
   t24  0.84                0.733473042484283;
Parameter Wcap(i) /8 200, 19 150, 21 100/;
LN(i,j,'x')$(LN(i,j,'x')=0)= LN(j,i,'x');
LN(i,j,'r')$(LN(i,j,'r')=0)= LN(j,i,'r');
LN(i,j,'b')$(LN(i,j,'b')=0)= LN(j,i,'b');
LN(i,j,'Limit')$(LN(i,j,'Limit')=0)= LN(j,i,'Limit');
LN(i,j,'bij')$LN(i,j,'Limit')= 1/LN(i,j,'x');
LN(i,j,'z')$LN(i,j,'Limit')= sqrt(sqr(LN(i,j,'x'))+sqr(LN(i,j,'r')));
LN(i,j,'th')$(LN(i,j,'Limit')and LN(i,j,'x')and LN(i,j,'r'))= arctan(LN(i,j,'x')/(LN(i,j,'r')));
LN(i,j,'th')$(LN(i,j,'Limit')and LN(i,j,'x')and LN(i,j,'r')=0)= pi/2;
LN(i,j,'th')$(LN(i,j,'Limit')and LN(i,j,'r')and LN(i,j,'x')=0)= 0;
Parameter cx(i,j); cx(i,j)$(LN(i,j,'limit')and LN(j,i,'limit'))= 1; cx(i,j)$(cx(j,i))= 1;
Variable OF, Pij(i,j,t), Qij(i,j,t), Pg(i,t), Qg(i,t), Va(i,t), V(i,t), Pw(i,t), lsh(i,t), Pc(i,t);
Equation eq1, eq2, eq3, eq4, eq5, eq6, eq7;
*Equation eq8;
*with wind curtailment
eq1(i,j,t)$cx(i,j).. Pij(i,j,t) =e= (sqr(V(i,t))*cos(LN(j,i,'th'))-V(i,t)*V(j,t)*cos(Va(i,t)-Va(j,t)+LN(j,i,'th')))/LN(j,i,'z');
eq2(i,j,t)$cx(i,j).. Qij(i,j,t) =e= (sqr(V(i,t))*sin(LN(j,i,'th'))-V(i,t)*V(j,t)*sin(Va(i,t)-Va(j,t)+LN(j,i,'th')))/LN(j,i,'z')-LN(j,i,'b')*sqr(V(i,t))/2;
eq3(i,t).. Pw(i,t)$Wcap(i) + Pg(i,t)$GenD(i,'Pmax') - WD(t,'d')*BD(i,'pd')/Sbase =e= sum(j$cx(j,i), Pij(i,j,t));
*eq3(i,t).. lsh(i,t)$BD(i,'pd')+Pw(i,t)$Wcap(i)+Pg(i,t)$GenD(i,'Pmax')-WD(t,'d')*BD(i,'pd')/Sbase =e= sum(j$cx(j,i),Pij(i,j,t));
* with load shedding
eq4(i,t).. Qg(i,t)$GenD(i,'Qmax')-WD(t,'d')*BD(i,'qd')/Sbase =e= sum(j$cx(j,i),Qij(i,j,t));
eq5.. OF =g= sum((i,t)$GenD(i,'Pmax'),sqr(Pg(i,t)*Sbase)*GenD(i,'a')+Pg(i,t)*Sbase*GenD(i,'b')+GenD(i,'c'));
*eq5.. OF =g= sum((i,t),sqr(Pg(i,t)*Sbase)*GenD(i,'a')+Pg(i,t)*Sbase*GenD(i,'b')+GenD(i,'c'))+sum((i,t),VOLL*lsh(i,t)*Sbase$BD(i,'pd'));
*with load shedding
*eq5.. OF =g= sum((i,t),sqr(Pg(i,t)*Sbase)*GenD(i,'a')+Pg(i,t)*Sbase*GenD(i,'b')+GenD(i,'c'))+sum((i,t),VOLW*Pc(i,t)*sbase$Wcap(i));
*with wind curtailment
*eq5.. OF =g= sum((i,t),sqr(Pg(i,t)*Sbase)*GenD(i,'a')+Pg(i,t)*Sbase*GenD(i,'b')+GenD(i,'c'))+sum((i,t),VOLL*lsh(i,t)*Sbase$BD(i,'pd')+VOLW*Pc(i,t)*sbase$Wcap(i));
*with load shedding & wind curtailment
eq6(i,t)$(GenD(i,'Pmax')and ord(t)>1).. Pg(i,t)-Pg(i,t-1) =l= GenD(i,'RU')/Sbase;
eq7(i,t)$(GenD(i,'Pmax')and ord(t)<card(t)).. Pg(i,t)-Pg(i,t+1) =l= GenD(i,'RD')/Sbase;
*eq8(i,t)$Wcap(i).. pc(i,t) =e= WD(t,'w')*Wcap(i)/Sbase-pw(i,t);
*with wind curtailment
Pg.lo(i,t) = GenD(i,'Pmin')/Sbase; Pg.up(i,t) = GenD(i,'Pmax')/Sbase;
Qg.lo(i,t) = GenD(i,'Qmin')/Sbase; Qg.up(i,t) = GenD(i,'Qmax')/Sbase;
Va.up(i,t)= pi/2; Va.lo(i,t)= -pi/2; Va.l(i,t)= 0; Va.fx(slack,t)= 0;
Pij.up(i,j,t)$((cx(i,j)))= 1*LN(i,j,'Limit')/Sbase;
Pij.lo(i,j,t)$((cx(i,j)))= -1*LN(i,j,'Limit')/Sbase;
Qij.up(i,j,t)$((cx(i,j)))= 1*LN(i,j,'Limit')/Sbase;
Qij.lo(i,j,t)$((cx(i,j)))= -1*LN(i,j,'Limit')/Sbase;
V.lo(i,t)= 0.9; V.up(i,t)= 1.1; V.l(i,t)= 1;
Pw.up(i,t)= WD(t,'d')*Wcap(i)/sbase; Pw.lo(i,t)= 0;
*lsh.up(i,t)= WD(t,'d')*BD(i,'pd')/Sbase; lsh.lo(i,t)= 0;
*with load shedding
*Pc.up(i,t)= WD(t,'w')*Wcap(i)/Sbase; Pc.lo(i,t)= 0;
*with wind curtailment
Model loadflow /all/;
Solve loadflow minimizing OF using NLP;
Parameter report(t,i,*), report2(i,t), report3(i,t), Congestioncost, lmp(i,t);
report(t,i,'V')     = V.l(i,t);
report(t,i,'Angle') = Va.l(i,t);
report(t,i,'Pg')    = Pg.l(i,t)*Sbase;
report(t,i,'Qg')    = Qg.l(i,t)*Sbase;
report(t,i,'LMP_P') = eq3.m(i,t)/Sbase;
report(t,i,'LMP_Q') = eq4.m(i,t)/Sbase;
report2(i,t)        = Pg.l(i,t)*Sbase;
report3(i,t)        = Qg.l(i,t)*Sbase;
display LN, cx, report, OF.l, Pij.l, Qij.l, Pg.l, Qg.l, V.l, Va.l, Pw.l;
* OF = 1.812626*e7 on correct execution
*display lsh.l (for load shedding)
*display Pc.l (for wind curtailment)