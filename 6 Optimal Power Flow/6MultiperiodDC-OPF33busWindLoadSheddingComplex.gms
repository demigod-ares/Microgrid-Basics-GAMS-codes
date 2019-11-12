*** Multi-period DC-OPF for IEEE 33-bus network considering wind and load shedding
Set bus/1*33/, slack(bus)/19/, Gen/g1*g16/, t/t1*t24/;
Scalar Sbase/100/, VOLL 'value of loss of load($/Mwhr)'/10000/, VOLW 'value of loss of wind($/Mwhr)'/50/;
Alias (bus,node);
Table GD(Gen,*) 'generating units characteristics'
        Pmax Pmin    a     b      c     CostsD costst RU   RD   SU   SD   UT   DT   uini U0  So
   g1   400  100     2.2   5.47   6.1   0      0      47   47   105  108  1    1    1    5   0
   g2   400  100     2.2   5.47   6.1   0      0      47   47   106  112  1    1    1    6   0
   g3   152  30.4    3.1   13.32  14.3  1430.4 1430.4 14   14   43   45   8    4    1    2   0
   g4   152  30.4    3.1   13.32  14.3  1430.4 1430.4 14   14   44   57   8    4    1    2   0
   g5   155  54.25   3.5   16     16.5  0      0      21   21   65   77   8    8    0    0   2
   g6   155  54.25   2.6   10.52  11.3  312    312    21   21   66   73   8    8    1    10  0
   g7   310  108.5   2.6   10.52  11.3  624    624    21   21   112  125  8    8    1    10  0
   g8   350  140     2.3   10.89  11.4  2298   2298   28   28   154  162  8    8    1    5   0
   g9   350  75      3.5   20.7   21.1  1725   1725   49   49   77   80   8    8    0    0   2
   g10  591  206.85  3.5   20.93  21.5  3056.7 3056.7 21   21   213  228  12   10   0    0   8
   g11  60   12      3.5   26.11  28.1  437    437    7    7    19   31   4    2    0    0   1
   g12  300  36      1.1   5.01   5.01  0      0      35   35   315  326  0    0    1    2   0
   g13  155  54.25   2.6   10.52  11.3  312    312    21   21   66   73   8    8    1    10  0
   g14  152  30.4    3.1   13.32  14.3  1430.4 1430.4 14   14   43   45   8    4    1    2   0
   g15  400  100     2.2   5.47   6.1   0      0      47   47   105  108  1    1    1    5   0
   g16  400  100     2.2   5.47   6.1   0      0      47   47   106  112  1    1    1    6   0 ;
Set GB(bus,Gen) 'connectivity index of each generating unit to each bus'
/18.g1, 21.g2, 1.g3, 2.g4, 15.g5, 16.g6, 23.g7, 23.g8, 7.g9, 13.g10, 15.g11, 22.g12, 24.g13, 27.g14, 29.g15, 32.g16/;
Table BusData(bus,*) 'demands of each bus in MW'
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
   13  265  54
   14  194  39
   15  317  64
   16  100  20
   18  333  68
   19  181  37
   20  128  26
   21  124  33
   23  303  24
   26  180  43
   29  100  35
   30  223  28
   33  248  34
;
Table branch(bus,node,*) 'network technical characteristics'
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
Table WD(t,*) 'available wind power & effect of wind on demand'
        w                   d
   t1   0.0786666666666667  0.684511335492475
   t2   0.0866666666666667  0.644122690036197
   t3   0.117333333333333   0.61306915602972
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
Parameter Wcap(bus) / 8 200, 19 150, 21 100, 29 200 /;
* wind turbine at 8, 19, 21
branch(bus,node,'x')$(branch(bus,node,'x')=0) = branch(node,bus,'x');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0) = branch(node,bus,'Limit');
branch(bus,node,'bij')$branch(bus,node,'Limit') = 1/branch(bus,node,'x');
Parameter conex(bus,node);
conex(bus,node)$(branch(bus,node,'limit') and branch(node,bus,'limit')) = 1;
conex(bus,node)$(conex(node,bus)) = 1;
Variable OF, Pij(bus,node,t), Pg(Gen,t), delta(bus,t), lsh(bus,t), Pw(bus,t), Pc(bus,t);
Equation const1, const2, const3, const4, const5, const6;
const1(bus,node,t)$(conex(bus,node)).. Pij(bus,node,t) =e= branch(bus,node,'bij')*(delta(bus,t)-delta(node,t));
const2(bus,t).. lsh(bus,t)$BusData(bus,'pd')+Pw(bus,t)$Wcap(bus)+sum(Gen$GB(bus,Gen),Pg(Gen,t))-WD(t,'d')*BusData(bus,'pd')/Sbase =e= sum(node$conex(node,bus),Pij(bus,node,t));
const3.. OF =g= sum((bus,Gen,t)$GB(bus,Gen),sqr(Pg(Gen,t)*Sbase)*GD(Gen,'a')+Pg(Gen,t)*Sbase*GD(Gen,'b')+GD(Gen,'c'))+sum((bus,t),VOLL*lsh(bus,t)*Sbase$BusData(bus,'pd')+VOLW*Pc(bus,t)*sbase$Wcap(bus));
const4(gen,t).. pg(gen,t+1)-pg(gen,t) =l= GD(gen,'RU')/Sbase;
const5(gen,t).. pg(gen,t-1)-pg(gen,t) =l= GD(gen,'RD')/Sbase;
const6(bus,t)$Wcap(bus).. pc(bus,t) =e= WD(t,'w')*Wcap(bus)/Sbase-pw(bus,t);
Pg.lo(Gen,t) = GD(Gen,'Pmin')/Sbase; Pg.up(Gen,t) = GD(Gen,'Pmax')/Sbase;
delta.up(bus,t)= pi/2; delta.lo(bus,t)= -pi/2; delta.fx(slack,t)= 0;
Pij.up(bus,node,t)$((conex(bus,node)))= 1*branch(bus,node,'Limit')/Sbase;
Pij.lo(bus,node,t)$((conex(bus,node)))= -1*branch(bus,node,'Limit')/Sbase;
lsh.up(bus,t)= WD(t,'d')*BusData(bus,'pd')/Sbase; lsh.lo(bus,t)= 0;
Pw.up(bus,t)= WD(t,'w')*Wcap(bus)/Sbase; Pw.lo(bus,t)= 0;
Pc.up(bus,t)= WD(t,'w')*Wcap(bus)/Sbase; Pc.lo(bus,t)= 0;
Model loadflow /all/;
Solve loadflow minimizing OF using QCP;
Display branch, OF.l, Pij.l, Pg.l, delta.l, lsh.l, Pw.l, Pc.l;
