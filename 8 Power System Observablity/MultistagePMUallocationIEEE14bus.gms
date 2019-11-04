* Multi-stage PMU allocation for IEEE 14 network
Set bus/1*14/; alias(bus,node);
Set conex 'Bus connectivity matrix'
/1.2,1.5,2.3,2.4,2.5,3.4,4.5,4.7,4.9,5.6,6.11,6.12,6.13,7.8,7.9,9.10,9.14,10.11,12.13,13.14/;
conex(bus,node)$(conex(node,bus)) = 1;
Variable OF, OBI;
Binary Variable PMU(bus), beta(bus);
Equations const1, const2, const3, const2E, const3A;
const1.. OF =e= sum(bus,PMU(bus));
const2(bus).. PMU(bus)+sum(node$conex(bus,node),PMU(node)) =g= 1;
const2E(bus).. PMU(bus)+sum(node$conex(bus,node),PMU(node)) =g= beta(bus);
const3.. OBI =e= sum(bus,beta(bus));
const3A.. OF =e= sum(bus,PMU(bus));
beta.up(bus)= 1; beta.lo(bus)= 0;
Option optcr=0;
Model placement /const1,const2/;
Model placement8 /const2E,const3,const3A/;
Set cp /cp1*cp3/; Alias(cp,cpp);
Parameter phase_rep(cp,*),phase_pmu(cp,bus);Parameter phase(cp)
/ cp1 2
  cp2 1
  cp3 1 / ;
Solve placement minimizing OF using MIP;
Display Pmu.l; Pmu.fx(bus)$(Pmu.l(bus)=0)=0;
loop(cp,
  OF.up=sum(cpp$(ord(cpp)<=ord(cp)),phase(cpp));
  solve placement8 maximizing OBI using MIP;
  phase_rep(cp,'OBS')= OBI.l;
  phase_rep(cp,'Tpmu')= sum(bus,Pmu.l(bus));
  phase_pmu(cp,bus)= pmu.l(bus);
  Pmu.fx(bus)$(PMU.l(bus))= 1;
  Display pmu.l );
                               
