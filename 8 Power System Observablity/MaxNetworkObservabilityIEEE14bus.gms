* Maximizing the network observability using a limited number of PMU for IEEE 14 network without considering zero injection nodes
Set bus /1*14/;
Alias (bus,node);

Set conex 'Bus connectivity matrix'
/
   1.2
   1.5
   2.3
   2.4
   2.5
   3.4
   4.5
   4.7
   4.9
   5.6
   6.11
   6.12
   6.13
   7.8
   7.9
   9.10
   9.14
   10.11
   12.13
   13.14
/;
conex(bus,node)$(conex(node,bus)) = 1;
Variable OF;
Binary Variable PMU(bus), alpha(bus);
*Integer Variable beta(bus);
Scalar NPMU / 10 /;
Equation eq1, eq2, eq3;
eq1..      sum(bus, pmu(bus)) =l= NPMU;
eq2..      OF =e= sum(node, alpha(node));
eq3(bus).. PMU(bus) + sum(node$conex(bus,node), PMU(node)) =g= alpha(bus);
option optCr = 0, profile = 1;
Model placement3 / eq1, eq2, eq3 /;
Set counter / c1*c4 /;
Parameter report(bus,counter), OBIrep(counter);
loop(counter,
   NPMU = ord(counter);
   solve placement3 maximizing OF using MIP;
   report(bus,counter) = pmu.l(bus);
   OBIrep(counter)     = OF.l;
);
display OBIrep;

