*** limit(0,1) Numerical Integration of 1-xsin.20x/dx
Scalar Zstimate;
Set counter /c1*c200000/;
parameter report(counter,*);
report(counter,'x') = uniform(0,1);
report(counter,'y') = uniform(0,2);
Zstimate = 2*sum(counter$(report(counter,'y')<1+report(counter,'x')*sin(report(counter,'x')*20)),1)/card(counter);
Display report, Zstimate;

