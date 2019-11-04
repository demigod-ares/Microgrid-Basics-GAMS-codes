$title Multi-period AC-OPF for IEEE 24-bus network considering wind and load shedding
Set
   i        'network buses'    / 1*24   /
   slack(i)                    / 13     /
   t                           / t1*t24 /
   GB(i)    'generating buses' / 1,2,7,15*16,18,21*23 /;

Scalar Sbase/100/, VOLL/10000/, VOLW/50/;
Alias (i,j);
Table GenD(i,*) 'generating units characteristics'
       pmax  pmin    b      Qmax  Qmin  Vg     RU  RD
   1   152   30.4    13.32  192   -50   1.035  21  21
   2   152   30.4    13.32  192   -50   1.035  21  21
   7   350   75      20.7   300   0     1.025  43  43
   13  591   206.85  20.93  591   0     1.02   31  31
   15  215   66.25   21     215   -100  1.014  31  31
   16  155   54.25   10.52  155   -50   1.017  31  31
   18  400   100     5.47   400   -50   1.05   70  70
   21  400   100     5.47   400   -50   1.05   70  70
   22  300   0       0      300   -60   1.05   53  53
   23  360   248.5   10.52  310   -125  1.05   31  31;
Table BD(i,*) 'demands of each bus in MW'
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
   11  0    0
   12  0    0
   13  265  54
   14  194  39
   15  317  64
   16  100  20
   17  0    0
   18  333  68
   19  181  37
   20  128  26
   21  0    0
   22  0    0
   23  0    0
   24  0    0 ;
Table LN(i,j,*) 'network technical characteristics'
          r        x        b       limit
   1.2    0.0026   0.0139   0.4611  175
   1.3    0.0546   0.2112   0.0572  175
   1.5    0.0218   0.0845   0.0229  175
   2.4    0.0328   0.1267   0.0343  175
   2.6    0.0497   0.192    0.052   175
   3.9    0.0308   0.119    0.0322  175
   3.24   0.0023   0.0839   0       400
   4.9    0.0268   0.1037   0.0281  175
   5.10   0.0228   0.0883   0.0239  175
   6.10   0.0139   0.0605   2.459   175
   7.8    0.0159   0.0614   0.0166  175
   8.9    0.0427   0.1651   0.0447  175
   8.10   0.0427   0.1651   0.0447  175
   9.11   0.0023   0.0839   0       400
   9.12   0.0023   0.0839   0       400
   10.11  0.0023   0.0839   0       400
   10.12  0.0023   0.0839   0       400
   11.13  0.0061   0.0476   0.0999  500
   11.14  0.0054   0.0418   0.0879  500
   12.13  0.0061   0.0476   0.0999  500
   12.23  0.0124   0.0966   0.203   500
   13.23  0.0111   0.0865   0.1818  500
   14.16  0.005    0.0389   0.0818  500
   15.16  0.0022   0.0173   0.0364  500
   15.21  0.00315  0.0245   0.206   1000
   15.24  0.0067   0.0519   0.1091  500
   16.17  0.0033   0.0259   0.0545  500
   16.19  0.003    0.0231   0.0485  500
   17.18  0.0018   0.0144   0.0303  500
   17.22  0.0135   0.1053   0.2212  500
   18.21  0.00165  0.01295  0.109   1000
   19.20  0.00255  0.0198   0.1666  1000
   20.23  0.0014   0.0108   0.091   1000
   21.22  0.0087   0.0678   0.1424  500 ;
Table WD(t,*)
        w                   d
*  t1   0                   1
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
*LN(i,j,'b') = 0;
LN(i,j,'x')$(LN(i,j,'x')=0)= LN(j,i,'x');
LN(i,j,'r')$(LN(i,j,'r')=0)= LN(j,i,'r');
LN(i,j,'b')$(LN(i,j,'b')=0)= LN(j,i,'b');
LN(i,j,'Limit')$(LN(i,j,'Limit')=0)= LN(j,i,'Limit');
LN(i,j,'bij')$LN(i,j,'Limit')= 1/LN(i,j,'x');
LN(i,j,'z')$LN(i,j,'Limit')= sqrt(sqr(LN(i,j,'x'))+sqr(LN(i,j,'r')));
LN(j,i,'z')$(LN(i,j,'z')=0)= LN(i,j,'z');
LN(i,j,'th')$(LN(i,j,'Limit')and LN(i,j,'x')and LN(i,j,'r'))= arctan(LN(i,j,'x')/(LN(i,j,'r')));
LN(i,j,'th')$(LN(i,j,'Limit')and LN(i,j,'x')and LN(i,j,'r')=0)= pi/2;
LN(i,j,'th')$(LN(i,j,'Limit')and LN(i,j,'r')and LN(i,j,'x')=0)= 0;
LN(j,i,'th')$LN(i,j,'Limit') = LN(i,j,'th');
Parameter cx(i,j); cx(i,j)$(LN(i,j,'limit')and LN(j,i,'limit'))= 1; cx(i,j)$(cx(j,i))= 1;
Variable OF, Pij(i,j,t), Qij(i,j,t), Pg(i,t), Qg(i,t), Va(i,t), V(i,t), Pw(i,t);
Equation eq1, eq2, eq3, eq4, eq5, eq6, eq7;
eq1(i,j,t)$cx(i,j).. Pij(i,j,t) =e= (V(i,t)*V(i,t)*cos(LN(j,i,'th'))-V(i,t)*V(j,t)*cos(Va(i,t)-Va(j,t)+LN(j,i,'th')))/LN(j,i,'z');
eq2(i,j,t)$cx(i,j).. Qij(i,j,t) =e= (V(i,t)*V(i,t)*sin(LN(j,i,'th'))-V(i,t)*V(j,t)*sin(Va(i,t)-Va(j,t)+LN(j,i,'th')))/LN(j,i,'z')-LN(j,i,'b')*V(i,t)*V(i,t)/2;
eq3(i,t).. Pw(i,t)$Wcap(i) + Pg(i,t)$GenD(i,'Pmax') - WD(t,'d')*BD(i,'pd')/Sbase =e= sum(j$cx(j,i), Pij(i,j,t));
eq4(i,t).. Qg(i,t)$GenD(i,'Qmax')-WD(t,'d')*BD(i,'qd')/Sbase =e= sum(j$cx(j,i),Qij(i,j,t));
eq5.. OF =g= sum((i,t),Pg(i,t)*GenD(i,'b')*Sbase$GenD(i,'Pmax'));
eq6(i,t)$(GenD(i,'Pmax')and ord(t)>1).. Pg(i,t)-Pg(i,t-1) =l= GenD(i,'RU')/Sbase;
eq7(i,t)$(GenD(i,'Pmax')and ord(t)<card(t)).. Pg(i,t)-Pg(i,t+1) =l= GenD(i,'RD')/Sbase;
Pg.lo(i,t) = GenD(i,'Pmin')/Sbase; Pg.up(i,t) = GenD(i,'Pmax')/Sbase;
Qg.lo(i,t) = GenD(i,'Qmin')/Sbase; Qg.up(i,t) = GenD(i,'Qmax')/Sbase;
Va.up(i,t)= pi/2; Va.lo(i,t)= -pi/2; Va.l(i,t)= 0; Va.fx(slack,t)= 0;
Pij.up(i,j,t)$((cx(i,j)))= 1*LN(i,j,'Limit')/Sbase;
Pij.lo(i,j,t)$((cx(i,j)))= -1*LN(i,j,'Limit')/Sbase;
Qij.up(i,j,t)$((cx(i,j)))= 1*LN(i,j,'Limit')/Sbase;
Qij.lo(i,j,t)$((cx(i,j)))= -1*LN(i,j,'Limit')/Sbase;
V.lo(i,t)  = 0.9; V.up(i,t)  = 1.1; V.l(i,t)   = 1;
Pw.up(i,t) = WD(t,'d')*Wcap(i)/sbase; Pw.lo(i,t) = 0;
Model loadflow /all/;
solve loadflow minimizing OF using NLP;
Parameter report(t,i,*), report2(i,t), report3(i,t), Congestioncost, lmp(i,t);
report(t,i,'V')     = V.l(i,t);
report(t,i,'Angle') = Va.l(i,t);
report(t,i,'Pg')    = Pg.l(i,t)*Sbase;
report(t,i,'Gg')    = Qg.l(i,t)*Sbase;
report(t,i,'LMP_P') = eq3.m(i,t)/Sbase;
report(t,i,'LMP_Q') = eq4.m(i,t)/Sbase;
report2(i,t)        = Pg.l(i,t)*Sbase;
report3(i,t)        = Qg.l(i,t)*Sbase;
display report;
