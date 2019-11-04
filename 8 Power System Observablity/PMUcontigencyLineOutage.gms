Set bus/1*14/; alias(bus,node);
Set conex 'Bus connectivity matrix'
/1.2,1.5,2.3,2.4,2.5,3.4,4.5,4.7,4.9,5.6,6.11,6.12,6.13,7.8,7.9,9.10,9.14,10.11,12.13,13.14/;
conex(bus,node)$(conex(node,bus)) = 1;
Variable OF;
Binary Variable PMU(bus), alpha(bus);
Equations const1, const2C, const2D;
const1.. OF =e= sum(bus,PMU(bus));
const2C(bus).. PMU(bus)+alpha(bus) =g= 1;
const2D(bus).. sum(node$conex(bus,node),PMU(node)) =g= 2*alpha(bus);
Option optcr=0;
Model placement4 /const1,const2C,const2D/ ;
Solve placement4 minimizing OF using MIP;
Display pmu.l, alpha.l;

