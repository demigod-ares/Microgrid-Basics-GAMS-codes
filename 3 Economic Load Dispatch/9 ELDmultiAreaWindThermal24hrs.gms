*** Multi-area economic dynamic dispatch Example
Sets t/t1*t24/, Area/A1*A3/, i/g1*g10/, w/w1*w2/;
Set AreaGen(area,i); AreaGen(area,i)=no;
AreaGen('A1',i)$(ord(i)<5)=yes;
AreaGen('A2',i)$(ord(i)>4 and ord(i)<8)=yes;
AreaGen('A3',i)$(ord(i)>7)=yes; alias(area,region);
Table winddata(t,w) wind ratio(to be multiplied by wind capacity) VS time
     w1     w2
t1   0.989  0.515
t2   0.932  0.701
t3   0.890  0.740
t4   0.889  0.676
t5   0.915  0.770
t6   0.937  0.785
t7   0.954  0.849
t8   0.956  0.895
t9   0.952  0.849
t10  0.895  0.924
t11  0.968  0.999
t12  0.971  0.956
t13  0.991  0.960
t14  0.982  0.956
t15  0.999  0.911
t16  0.810  0.975
t17  0.622  0.988
t18  0.611  0.903
t19  0.736  0.844
t20  0.803  0.803
t21  0.732  0.652
t22  0.713  0.721
t23  0.781  0.755
t24  0.937  0.557;
parameter Windcap(w) /w1 250,w2 350/;
parameter AreaWind(area,w); AreaWind('A1','w1')=yes; AreaWind('A3','w2')=yes;
table Tielim(area,region) maximum capacity of the tie line
    a1   a2   a3
a1  0    100  400
a2  100  0    500
a3  400  500  0;
table gendata(i,*) generator cost characteristics and limits
    a       b      c       Pmin  Pmax  RU   RD
g1  0.0056  17.87  601.75  20    150   40   40
g2  0.0079  21.62  480.29  40    200   80   80
g3  0.0070  23.9   471.6   30    300   100  100
g4  0.0043  21.6   958.2   30    350   120  120
g5  0.0095  22.54  692.4   10    70    30   30
g6  0.0090  19.58  455.6   20    80    40   40
g7  0.0063  21.05  1313.6  40    450   150  150
g8  0.0048  23.23  639.4   50    130   50   50
g9  0.0039  20.81  604.97  100   340   100  100
g10 0.0021  16.51  502.7   40    130   60   60;
table demand(t,area) demand for each area for each time slot
     a1   a2   a3
t1   258  292  237
t2   291  237  289
t3   343  214  299
t4   435  267  371
t5   408  295  393
t6   477  293  406
t7   422  311  369
t8   444  352  432
t9   547  391  495
t10  606  422  555
t11  621  415  528
t12  618  420  522
t13  592  405  498
t14  550  393  484
t15  568  382  471
t16  521  360  453
t17  503  355  455
t18  488  344  434
t19  507  341  411
t20  481  352  433
t21  460  324  401
t22  424  302  367
t23  402  284  336
t24  377  251  302;
variables tie(area,region,t), OF, p(i,t), Pw(w,t);
tie.lo(area,region,t)=-Tielim(area,region); tie.up(area,region,t)=+Tielim(area,region);
tie.fx(area,region,t)$(Tielim(area,region)=0)=0; tie.fx(area,area,t)=0;
p.up(i,t)= gendata(i,'Pmax'); p.lo(i,t)= gendata(i,'Pmin');
Pw.up(w,t)= winddata(t,w)*Windcap(w); Pw.lo(w,t)=0;
Equations tieconst, balance, RampUp, RampDn, cost;
*** mod operation of tie exchange
tieconst(area,region,t).. Tie(area,region,t) =e= -Tie(region,area,t);
*** area to region will be considered as positive load
balance(area,t).. sum(i$AreaGen(area,i),p(i,t))+sum(w$AreaWind(area,w),Pw(w,t)) =e= demand(t,area)+sum(region,Tie(area,region,t));
*** Maximum ramp up and ramp down of a generator.
RampUp(i,t).. p(i,t)-p(i,t-1) =l= gendata(i,'RU');
RampDn(i,t).. p(i,t-1)-p(i,t) =l= gendata(i,'RD');
*** Total cost of operating all generators over period of time.
cost.. OF =e= sum((i,t),gendata(i,'a')*p(i,t)*p(i,t)+gendata(i,'b')*p(i,t)+gendata(i,'c'));

Model EDC /all/;
Solve EDC minimum OF using QCP;
Display tie.l, p.l, Pw.l, OF.l;
