*** Maximizing the Area of a Right Triangle with Constant Circumference
Positive variables h, b;
Variable OF;
Scalar C /15/; h.up = C; b.up = C;
Equations eq1, eq2;
eq1.. h+b+sqrt(h*h+b*b) =e= C;
eq2.. OF =e= 0.5*h*b;
Model triangle /all/;
Solve triangle using NLP max of;
Display h.l, b.l, OF.l;

