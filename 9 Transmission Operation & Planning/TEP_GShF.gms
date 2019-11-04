*** Transmission Expansion Planning with Generation Shift Sensitivity Factors
Sets bus/1*3/, slack(bus)/1/, Gen/g1*g3/, nonslack(bus)/2*3/;
Scalars Sbase/100/;
Alias(bus,node,shin,knot); Alias(nonslack,nonslackj);
Table branch(bus,node,*) Network technical characteristics
       x     LIMIT  stat
  1.2  0.1   100    1
  1.3  0.2   80     1
  2.3  0.25  100    1;
set conex(bus,node) Bus connectivity matrixl;
conex(bus,node)$(branch(bus,node,'x')) = yes;
conex(bus,node)$conex(node,bus) = yes;
branch(bus,node,'x')$branch(node,bus,'x')=branch(node,bus,'x');
branch(bus,node,'stat')$branch(node,bus,'stat')=branch(node,bus,'stat');
branch(bus,node,'Limit')$(branch(bus,node,'Limit')=0)=branch(node,bus,'Limit');
branch(bus,node,'bij')$conex(bus,node)=1/branch(bus,node,'x');
Parameter Bmatrix(bus,node),Binv(bus,node),Flow(bus,node);
Bmatrix(bus,node)$(conex(node,bus))= -branch(bus,node,'bij');
Bmatrix(bus,bus)=sum(knot$conex(knot,bus), -Bmatrix(bus,knot));
parameter Breduced(nonslack,nonslackj),GSHF(bus,node,knot);
Breduced(nonslack,nonslackj)= Bmatrix(nonslack,nonslackj);
parameter inva(nonslack,nonslackj) 'inverse of a';
execute_unload 'a.gdx', nonslack, Breduced;
execute '=invert.exe a.gdx nonslack Breduced b.gdx inva';
execute_load 'b.gdx',inva;
Binv(nonslack,nonslackj)= inva(nonslack,nonslackj);
GSHF(bus,node,knot)$conex(bus,node)= branch(bus,node,'bij')*(Binv(bus,knot)-Binv(node,knot));
Display Bmatrix, Breduced, Binv, GSHF;
