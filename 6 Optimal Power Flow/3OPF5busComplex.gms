*** Optimal power flow for a Five-bus system
Set bus/1*5/, slack(bus)/1/, Gen/g1*g5/;
Scalar Sbase /100/;
Alias (bus,node);
Table GenData(Gen,*) 'generating units characteristics'
       a     b   c    pmin  pmax
   g1  2.8   14  88   0     40
   g2  2.7   15  90   0     170
   g3  1.5   21  155  0     520
   g4  2.56  16  92   0     200
   g5  3.06  10  80   0     600 ;
Set GBconect(bus,Gen) 'connectivity index of each generating unit to each bus'
/ 1.g1, 1.g2, 3.g3, 4.g4, 5.g5/;
Table BusData(bus,*) 'demands of each bus in MW'
      Pd
   2  300
   3  300
   4  400;
Set conex 'bus connectivity matrix'
/ 1.2, 2.3, 3.4, 4.1, 4.5, 5.1/;
conex(bus,node)$(conex(node,bus)) = 1;
Table branch(bus,node,*) 'network technical characteristics'
        x       Limit
   1.2  0.0281  400
   1.4  0.0304  400
   1.5  0.0064  400
   2.3  0.0108  400
   3.4  0.0297  400
   4.5  0.0297  240;
branch(bus,node,'x')$(branch(bus,node,'x')=0) = branch(node,bus,'x');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0) = branch(node,bus,'Limit');
branch(bus,node,'bij')$conex(bus,node) = 1/branch(bus,node,'x');
Variable OF, Pij(bus,node), Pg(Gen), delta(bus);
Equation const1, const2, const3;
const1(bus,node)$(conex(bus,node)).. Pij(bus,node) =e= branch(bus,node,'bij')*(delta(bus)-delta(node));
const2(bus).. sum(Gen$GBconect(bus,Gen),Pg(Gen))-BusData(bus,'pd')/Sbase =e= sum(node$conex(node,bus),Pij(bus,node));
const3.. OF =g= sum(Gen,sqr(Pg(Gen)*Sbase)*GenData(Gen,'a')+Pg(Gen)*Sbase*GenData(Gen,'b')+GenData(Gen,'c'));
Pg.lo(Gen) = GenData(Gen,'Pmin')/Sbase; Pg.up(Gen) = GenData(Gen,'Pmax')/Sbase;
delta.up(bus) = pi; delta.lo(bus) = -pi; delta.fx(slack) = 0;
Pij.up(bus,node)$((conex(bus,node)))= 1*branch(bus,node,'Limit')/Sbase;
Pij.lo(bus,node)$((conex(bus,node)))=-1*branch(bus,node,'Limit')/Sbase;
Model loadflow / all /;
solve loadflow minimizing OF using QCP;
Parameter report(bus,*), Congestioncost;
report(bus,'Gen(MW)')    = sum(Gen$GBconect(bus,Gen), Pg.l(Gen))*sbase;
report(bus,'Angle')      = delta.l(bus);
report(bus,'load(MW)')   = BusData(bus,'pd');
report(bus,'LMP(Rs/MWh)') = const2.m(bus)/sbase;
* The network is not congested, and the LMP values are same in various buses.
Congestioncost = sum((bus,node), Pij.l(bus,node)*(-const2.m(bus) + const2.m(node)))/2;
display conex, report, Pij.l, Congestioncost;
