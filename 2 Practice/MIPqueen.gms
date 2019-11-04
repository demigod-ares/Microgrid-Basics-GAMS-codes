***MIP N-queen example
Sets i /1*4/ , j /1*4/ ;
alias (i,row);
alias (j,col);
variable of ;
binary variable x(i,j) ;
Equations eq1 , eq2 , eq3 , eq4 , eq5 ;
*** j coloumn equations to make sure there is only one piece in that coloumn
eq1(j).. sum(i,x(i,j)) =l= 1;
*** i row equations to make sure there is only one piece in that row
eq2(i).. sum(j,x(i,j)) =l= 1;
*** diagonal (coloumn-row)==(j-i)
eq3(i,j)..sum((row,col)$((ord(row)-ord(i))=(ord(col)-ord(j))),x(row,col))=l= 1;
*** diagonal (coloumn+row)==(j+i)
eq4(i,j)..sum((row,col)$((ord(row)-ord(i))=-(ord(col)-ord(j))),x(row,col))=l= 1;
eq5.. sum((i,j),x(i,j)) =e= OF;
Model MIP /all/;
Solve MIP using MIP max of;
display x.l, of.l;

