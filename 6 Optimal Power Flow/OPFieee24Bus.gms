*** OPF IEEE Reliability test 24-bus network
Set bus/1*24/, slack(bus)/13/, Gen/g1*g12/;
Scalar Sbase/100/;
Alias (bus,node);
Table GenData(Gen,*) 'generating units characteristics'
        Pmax Pmin   b     CostsD costst RU   RD   SU   SD   UT   DT   uini U0  So
   g1   400  100    5.47  0      0      47   47   105  108  1    1    1    5   0
   g2   400  100    5.47  0      0      47   47   106  112  1    1    1    6   0
   g3   152  30.4   13.32 1430.4 1430.4 14   14   43   45   8    4    1    2   0
   g4   152  30.4   13.32 1430.4 1430.4 14   14   44   57   8    4    1    2   0
   g5   155  54.25  16    0      0      21   21   65   77   8    8    0    0   2
   g6   155  54.25  10.52 312    312    21   21   66   73   8    8    1    10  0
   g7   310  108.5  10.52 624    624    21   21   112  125  8    8    1    10  0
   g8   350  140    10.89 2298   2298   28   28   154  162  8    8    1    5   0
   g9   350  75     20.7  1725   1725   49   49   77   80   8    8    0    0   2
   g10  591  206.85 20.93 3056.7 3056.7 21   21   213  228  12   10   0    0   8
   g11  60   12     26.11 437    437    7    7    19   31   4    2    0    0   1
   g12  300  0      0     0      0      35   35   315  326  0    0    1    2   0;
*  only Pmax, Pmin & b required for the above code
Set GB(bus,Gen) 'connectivity index of each generating unit to each bus'
/18.g1,21.g2,1.g3,2.g4,15.g5,16.g6,23.g7,23.g8,7.g9,13.g10,15.g11,22.g12/;
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
   20  128  26;
Table branch(bus,node,*) 'network technical characteristics'
           r        x        b       limit
   1.2     0.0026   0.0139   0.4611  175
   1.3     0.0546   0.2112   0.0572  175
   1.5     0.0218   0.0845   0.0229  175
   2.4     0.0328   0.1267   0.0343  175
   2.6     0.0497   0.192    0.052   175
   3.9     0.0308   0.119    0.0322  175
   3.24    0.0023   0.0839   0       400
   4.9     0.0268   0.1037   0.0281  175
   5.10    0.0228   0.0883   0.0239  175
   6.10    0.0139   0.0605   2.459   175
   7.8     0.0159   0.0614   0.0166  175
   8.9     0.0427   0.1651   0.0447  175
   8.10    0.0427   0.1651   0.0447  175
   9.11    0.0023   0.0839   0       400
   9.12    0.0023   0.0839   0       400
   10.11   0.0023   0.0839   0       400
   10.12   0.0023   0.0839   0       400
   11.13   0.0061   0.0476   0.0999  500
   11.14   0.0054   0.0418   0.0879  500
   12.13   0.0061   0.0476   0.0999  500
   12.23   0.0124   0.0966   0.203   500
   13.23   0.0111   0.0865   0.1818  500
   14.16   0.005    0.0389   0.0818  500
   15.16   0.0022   0.0173   0.0364  500
   15.21   0.00315  0.0245   0.206   1000
   15.24   0.0067   0.0519   0.1091  500
   16.17   0.0033   0.0259   0.0545  500
   16.19   0.003    0.0231   0.0485  500
   17.18   0.0018   0.0144   0.0303  500
   17.22   0.0135   0.1053   0.2212  500
   18.21   0.00165  0.01295  0.109   1000
   19.20   0.00255  0.0198   0.1666  1000
   20.23   0.0014   0.0108   0.091   1000
   21.22   0.0087   0.0678   0.1424  500 ;
branch(bus,node,'x')$(branch(bus,node,'x')=0) = branch(node,bus,'x');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0) = branch(node,bus,'Limit');
branch(bus,node,'bij')$branch(bus,node,'Limit') = 1/branch(bus,node,'x');
Parameter conex(bus,node);
conex(bus,node)$(branch(bus,node,'limit') and branch(node,bus,'limit')) = 1;
conex(bus,node)$(conex(node,bus)) = 1;
Variable OF, Pij(bus,node), Pg(Gen), delta(bus);
Equation const1, const2, const3;
const1(bus,node)$(conex(bus,node)).. Pij(bus,node) =e= branch(bus,node,'bij')*(delta(bus)-delta(node));
const2(bus).. sum(Gen$GB(bus,Gen),Pg(Gen))-BusData(bus,'pd')/Sbase =e= sum(node$conex(node,bus),Pij(bus,node));
const3.. OF =g= sum(Gen,Pg(Gen)*GenData(Gen,'b')*Sbase);
Pg.lo(Gen) = GenData(Gen,'Pmin')/Sbase; Pg.up(Gen) = GenData(Gen,'Pmax')/Sbase;
delta.up(bus)= pi/2; delta.lo(bus)= -pi/2; delta.fx(slack)= 0;
Pij.up(bus,node)$((conex(bus,node)))= 1*branch(bus,node,'Limit')/Sbase;
Pij.lo(bus,node)$((conex(bus,node)))= -1*branch(bus,node,'Limit')/Sbase;
Model loadflow /all/;
Solve loadflow minimizing OF using LP;
parameter report(bus,*), Congestioncost;
report(bus,'Gen(MW)')= 1*sum(Gen$GB(bus,Gen),Pg.l(Gen))*sbase ;
report(bus,'Angle')= delta.l(bus);
report(bus,'load(MW)')= BusData(bus,'pd');
report(bus,'LMP($/MWh)')=const2.m(bus)/sbase;
Congestioncost= sum((bus,node),Pij.l(bus,node)*(-const2.m(bus)+const2.m(node)))/2;
display report, Pij.l, Congestioncost;
