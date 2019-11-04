*** Transmission Expansion Planning with phase shifters as powerflow controller (2 years period)

Set bus/1*6/, slack(bus)/1/, Gen/g1*g3/, k/k1*k4/;
Scalar Sbase/100/, M/1000/, T; T=8760*2;
Alias (bus,node);
Table GenData(Gen,*) 'generating units characteristics'
       b   pmin  pmax
   g1  20  0     400
   g2  30  0     400
   g3  10  0     600;
Set GBconect(bus,Gen) 'connectivity index of each generating unit to each bus' /1.g1,3.g2,6.g3/;
Table BusData(bus,*) 'demands of each bus in MW'
      Pd
   1  80
   2  240
   3  40
   4  160
   5  240;
Table branch(bus,node,*) 'network technical characteristics'
        X    LIMIT  Cost  stat
   1.2  0.4  100    40    1
   1.4  0.6  80     60    1
   1.5  0.2  100    20    1
   2.3  0.2  100    20    1
   2.4  0.4  100    40    1
   2.6  0.3  100    30    0
   3.5  0.2  100    20    1
   4.6  0.3  100    30    0;
Set conex(bus,node) 'Bus connectivity matrixl';
conex(bus,node)$(branch(bus,node,'X')) = yes;
conex(bus,node)$conex(node,bus) = yes;

branch(bus,node,'X')$branch(node,bus,'X') =  branch(node,bus,'X');
branch(bus,node,'cost')$branch(node,bus,'cost') =  branch(node,bus,'cost');
branch(bus,node,'stat')$branch(node,bus,'stat') =  branch(node,bus,'stat');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0) =  branch(node,bus,'Limit');
branch(bus,node,'bij')$conex(bus,node) = 1/branch(bus,node,'X');
branch(bus,node,'bij')$branch(node,bus,'bij') =  branch(node,bus,'bij');
M = smax((bus,node)$conex(bus,node),branch(bus,node,'bij')*3.14*2);

Variable OF, OPC, INVC, Pij(bus,node,k), Pg(Gen), delta(bus), LS(bus), PSHij(bus,node,k);
Binary Variable alpha(bus,node,k), I(bus,node,k);
alpha.l(bus,node,k) = 1;
alpha.fx(bus,node,k)$(conex(bus,node) and ord(k)=1 and branch(node,bus,'stat')) = 1;

Equation const1A, const1B, const1C, const1D, const1E, const2, const3, equ1, equ2, const4, const5, const6, const7;
const1A(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k)-branch(bus,node,'bij')*(delta(bus)-delta(node)+PSHij(bus,node,k)) =l= M*(1-alpha(bus,node,k));
const1B(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k)-branch(bus,node,'bij')*(delta(bus)-delta(node)+PSHij(bus,node,k)) =g= -M*(1-alpha(bus,node,k));
const1C(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k) =l= alpha(bus,node,k)*branch(bus,node,'Limit')/Sbase;
const1D(bus,node,k)$conex(node,bus)..
   Pij(bus,node,k) =g= -alpha(bus,node,k)*branch(bus,node,'Limit')/Sbase;
const1E(bus,node,k)$conex(node,bus)..
   alpha(bus,node,k) =e= alpha(node,bus,k);
const2(bus)..
   LS(bus)+ sum(Gen$GBconect(bus,Gen),Pg(Gen))-BusData(bus,'pd')/Sbase =e= sum((k,node)$conex(node,bus),Pij(bus,node,k));
const3..
*OF =g= 2*8760*OPC + INVC;
OF =g= T*OPC + INVC;
equ1..
   OPC =e= sum(Gen, Pg(Gen)*GenData(Gen,'b')*Sbase)+100000*sum(bus ,LS(bus));
equ2..
   INVC =e= 1e6*sum((bus,node,k)$conex(node,bus),0.5*branch(bus,node,'cost')*alpha(bus,node,k)$(ord(k)>1 or branch(node,bus,'stat')=0))+6e5*0.5*sum((bus,node,k)$conex(node,bus),I(bus,node,k));
const4(bus,node,k)$conex(node,bus).. PSHij(bus,node,k)+PSHij(node,bus,k) =e= 0;
const5(bus,node,k)$conex(node,bus).. PSHij(bus,node,k) =l= I(bus,node,k)*pi/8;
const6(bus,node,k)$conex(node,bus).. PSHij(bus,node,k) =g= -I(bus,node,k)*pi/8;
const7(bus,node,k)$conex(node,bus).. I(bus,node,k) =l= alpha(bus,node,k);

LS.up(bus) = BusData(bus,'pd')/Sbase; LS.lo(bus) = 0;
Pg.lo(Gen) = GenData(Gen,'Pmin')/Sbase; Pg.up(Gen) = GenData(Gen,'Pmax')/Sbase;

delta.up(bus) = pi/3; delta.lo(bus) = -pi/3; delta.fx(slack) = 0;
Pij.up(bus,node,k)$((conex(bus,node))) = 1*branch(bus,node,'Limit')/Sbase;
Pij.lo(bus,node,k)$((conex(bus,node))) = -1*branch(bus,node,'Limit')/Sbase;
PSHij.up(bus,node,k)=pi/8; PSHij.lo(bus,node,k)=-pi/8;
Model loadflow / all /;
Option optCr = 0;
Solve loadflow minimizing OF using MIP;
Display OF.l, OPC.l, INVC.l, alpha.l;
