*** pie number estimation
scalar low /0/ , high /1/ , pistimate;
set counter /c1*c200/;
parameter report(counter,*);
report(counter,'x')= uniform(LOW,HIGH);
report(counter,'y')= uniform(LOW,HIGH);
pistimate =4*sum(counter$(power(report(counter,'x')-0.5,2)+power(report(counter,'y')-0.5,2)<=0.25),1)/card(counter);
display report, pistimate;

