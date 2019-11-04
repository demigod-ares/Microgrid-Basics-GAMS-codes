*** Transmission Expansion Planning with Network switching
Sets bus/1*118/,slack(bus )/13/,GenNo/Gen1*Gen54/,counter/c0*c10/;
Scalars Sbase/100/;
Alias(bus,totalbus,node);
Table GenDatanew(bus,GenNo,*)
       b     pmin   pmax
1.1    1     1      1    ;

Table BusData(bus,*) bus characteristics
     Pd
1    10           ;

Table branch(bus,totalbus,*)
      x    Ilim
1.1   1    1      ;

set conex(bus,node);
branch(bus, totalbus,'bij')$branch(totalbus,bus,'x')= 1/branch(bus,totalbus,'x');
conex(bus,node)$branch(bus,node,'x')= yes;
parameter branch(bus,totalbus,*),M,NSW,report(counter,*);
M=smax((bus,node)$conex(bus,node),branch(bus,node,'bij')*2*pi/3);
Positive variable Pg(GenNo);
Variables Pij(bus,node),delta(bus),ROF;
BINARY VARIABLE SW(bus,node);
Equations const0, const1, const2, const3, const0A, const0B, const0C, const0D, const0E, cons t0F;
const0(bus,node)$conex(bus,node).. Pij(bus,node) =e= branch(bus,node,'bij')*(delta(bus)-delta(node));
const1(bus).. sum(GenNo$GenDatanew(bus,GenNo,'Pmax'),Pg(GenNo))-BusData(bus,'Pd')/sbase =e= +sum(node$conex(node,bus),Pij(bus,node));
const2.. ROF =g= sum((GenNo,bus)$GenDatanew(bus,GenNo,'Pmax'),GenDatanew(bus,GenNo,'b')*Pg(GenNo)*Sbase);
const0A(bus,node)$conex(bus,node).. Pij(bus,node)-branch(bus,node,'bij')*(delta(bus)-delta(node)) =l= M(1-SW(bus,node));
const0B(bus,node)$conex(bus,node).. Pij(bus,node)-branch(bus,node,'bij')*(delta(bus)-delta(node)) =g= -M(1-SW(bus,node));
const0C(bus,node)$conex(bus,node).. Pij(bus,node) =l= SW(bus,node)*branch(bus,node,'Ilim');
const0D(bus,node)$conex(bus,node).. Pij(bus,node) =g= -SW(bus,node)*branch(bus,node,'Ilim');
const0E(bus,node)$conex(bus,node).. SW(node,bus) =e= SW(bus,node);
const0F(bus,node)$conex(bus,node).. Pij(node,bus) =e= -Pij(bus,node);
const3.. 0.5*sum((bus,node)$conex(bus,node),1-SW(bus,node)) =l= NSW;
Option Optca =0; Option Optcr =0;
BusData(bus,'Pd') = 1.1*BusData(bus,'Pd');
Pg.lo(GenNo) = sum(bus,GenDatanew(bus,GenNo,'Pmin'))/Sbase;
Pg.up(GenNo) = sum(bus,GenDatanew(bus,GenNo,'Pmax'))/Sbase;
delta.up(bus) = pi/3; delta.lo(bus) = -pi/3; delta.l(bus)= 0; delta.fx(slack) = 0;
Pij.up(bus,node)$conex(bus,node) = 1*branch(bus,node,'Ilim');
Pij.lo(bus,node)$conex(bus,node)=-1*branch(bus,node,'Ilim);
model BASE /const0, const1, const2/;
Solve BASE minimizing ROF using LP;
SW.l(bus,node) = 1;
report('c0','OF') = ROF.l;
report('c0','NSW') = 0.5*sum((bus,node)$conex(bus,node),1-SW.l(bus,node));
report('c0','Congestion') = 0.5*sum((bus,node)$conex(bus,node),(-const1.m(bus)+const1.m(node))*Pij.l(bus,node));
loop(    counter$(ord(counter)>1), NSW=ord(counter)-1;
         model Switching /const1,const2,const0A,const0B,const0C,const0D,const0E,const0F,const3/;
         Solve switching minimizing ROF using MIP;
         report(counter,'OF') = ROF.l;
         report(counter,'NSW') = 0.5*sum((bus,node)$conex(bus,node),1-SW.l(bus,node));
         report(counter,'Congestion') = 0.5*sum((bus,node)$conex(bus,node),(-const1.m(bus)+const1.m(node))*Pij.l(bus,node));
);
