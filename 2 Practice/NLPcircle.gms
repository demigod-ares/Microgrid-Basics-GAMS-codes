set i /1*6/ ; alias (i,j);
Positive variables x(i), y(i), w, h; variable of;
parameter radius(i)
/1 2
2 1.2
3 1.8
4 0.9
5 3.2
6 0.7/;
Equations eq1, eq2, eq3, eq4;
eq1.. w*h=e=OF;
eq2(i).. x(i) =l= w-radius(i);
eq3(i).. y(i) =l= h-radius(i);
eq4(i,j)$(ord(i)<>ord(j)).. power(y(j)-y(i), 2)+ power(x(j)-x(i),2) =g= power(radius(i)+radius(j),2);
x.lo(i)= radius(i); y.lo(i)=radius(i);
Model NLP /all/;
Solve NLP using NLP min OF;
parameter report(i,*);
report(i,'x') = x.l(i);
report(i,'y') = y.l(i);
report(i,'R') = radius(i);
display report, of.l, w.l, h.l;

