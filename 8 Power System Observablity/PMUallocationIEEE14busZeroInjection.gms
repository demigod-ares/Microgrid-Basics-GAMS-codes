* Min Cost PMU allocation for IEEE 14 network considering zero injection nodes
Set bus/1*14/; alias(bus,node); alias(bus,shin);
Table BusData(bus,*) bus characteristics
   Pd     gen
1   0     1
2   21.7  1
3   94.2  1
4   47.8
5   7.6
6   11.2  1
8   0     1
9   29.5
10  9
11  3.5
12  6.1
13  13.5
14  14.9    ;
Set conex 'Bus connectivity matrix'
/1.2,1.5,2.3,2.4,2.5,3.4,4.5,4.7,4.9,5.6,6.11,6.12,6.13,7.8,7.9,9.10,9.14,10.11,12.13,13.14/;
conex(bus,node)$(conex(node,bus)) = 1;
Parameters A(bus,node), B(bus,node), Zero(bus), normal(bus), abnormal(bus);
Zero(bus)$(BusData(bus,'Pd')=0 and BusData(bus,'gen')=0) = yes;
A(bus,node)$(Zero(bus) and conex(bus,node)) = yes;
normal(bus)$(Zero(bus)=0 and sum(node$conex(bus,node),Zero(node))=0) = yes;
B(bus,node)$(A(bus,node)) = yes;
B(bus,node)$(Zero(node) and ord(bus)= ord(node)) = yes ;
abnormal(bus)$(normal(bus)=0) = yes ;
Variable OF;
Binary Variable PMU(bus);
Equations const1, eq1, eq2;
const1.. OF =g= sum(bus,PMU(bus));
eq1(bus)$normal(bus).. PMU(bus)+sum(node$conex(bus,node),PMU(node)) =g= 1;
eq2(bus)$abnormal(bus).. sum(shin$conex(bus,shin),PMU(shin)+sum(node$conex(shin,node),PMU(node))) =g= sum(node,B(bus,node))-1;
Model placementWithzeroinjection /const1, eq1, eq2/;
Solve placementWithzeroinjection minimizing OF using MIP;
Display PMU.l, OF.l;

