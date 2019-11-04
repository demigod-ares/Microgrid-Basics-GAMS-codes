* PMU allocation for IEEE 57 network without considering zero injection nodes
Set bus /1*57/; Alias (bus,node);
Set conex 'Bus connectivity matrix'
/1.2
 2.3
 3.4
 4.5
 4.6
 6.7
 6.8
 8.9
 9.10
 9.11
 9.12
 9.13
 13.14
 13.15
 1.15
 1.16
 1.17
 3.15
 4.18
 5.6
 7.8
 10.12
 11.13
 12.13
 12.16
 12.17
 14.15
 18.19
 19.20
 21.20
 21.22
 22.23
 23.24
 24.25
 24.26
 26.27
 27.28
 28.29
 7.29
 25.30
 30.31
 31.32
 32.33
 34.32
 34.35
 35.36
 36.37
 37.38
 37.39
 36.40
 22.38
 11.41
 41.42
 41.43
 38.44
 15.45
 14.46
 46.47
 47.48
 48.49
 49.50
 50.51
 10.51
 13.49
 29.52
 52.53
 53.54
 54.55
 11.43
 44.45
 40.56
 56.41
 56.42
 39.57
 57.56
 38.49
 38.48
 9.55/;
conex(bus,node)$(conex(node,bus)) = 1;
Variable OF;
Binary Variable PMU(bus);
Equation const1, const2;
const1.. OF =e= sum(bus, PMU(bus));
const2(bus).. PMU(bus)+sum(node$conex(bus,node),PMU(node)) =g= 1;
option optCr = 0, profile = 1;
Model placement / const1, const2 /;
solve placement minimizing OF using MIP;
Display PMU.l, OF.l;
