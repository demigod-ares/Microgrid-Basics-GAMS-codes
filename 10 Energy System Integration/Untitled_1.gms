Sets bus/1*24/, slack(bus)/13/, Gen/g1*g12/, t/t1*t24/, genD(gen)/g1*g2,g5,g7*g11/, genN(gen)/g3,g4,g6,g12/;
scalars Sbase/100/, VOLL/10000/, VOLW/50/; alias(bus,node);
Sets gn NODES /Anderlues, Antwerpen, Arlon, Berneau, Blaregnies, Brugge, Dudzele, Gent, Liege, Loenhout, Mons, Namur, Petange,
     Peronnes, Sinsin, Voeren, Wanze, Warnand, Zeebrugge, Zomergem/, a PIPES/L1*L24/; Alias(gn,gm); set Pnm(a,gn,gm) arc description;
table Ndata(gn,*) Node Data
            slo   sup   Sd    plo   pup    c
Anderlues   0     1.20  0.00  0.00  66.20  0.00
Antwerpen   0     0.00  4.03  1.25  80.00  0.00
Arlon       0     0.00  0.22  0.00  66.20  0.00
Berneau     0     0.00  0.00  0.00  66.20  0.00
Blaregnies  0     0.00  15.62 2.08  66.20  0.00
Brugge      0     0.00  3.92  1.25  80.00  0.00
Dudzele     0     8.40  0.00  0.00  77.00  2.28
Gent        0     0.00  5.26  1.25  80.00  0.00
Liege       0     0.00  6.39  1.25  66.20  0.00
Loenhout    0     4.80  0.00  0.00  77.00  2.28
Mons        0     0.00  6.85  0.00  66.20  0.00
Namur       0     0.00  2.12  0.00  66.20  0.00
Petange     0     0.00  1.92  1.04  66.20  0.00
Peronnes    0     0.96  0.00  0.00  66.20  1.68
Sinsin      0     0.00  0.00  0.00  63.00  0.00
Voeren      0     22.01 0.00  2.08  66.20  1.68
Wanze       0     0.00  0.00  0.00  66.20  0.00
Warnand     0     0.00  0.00  0.00  66.20  0.00
Zeebrugge   0     11.59 0.00  0.00  77.00  2.28
Zomergem    0     0.00  0.00  0.00  80.00  0.00                                  ;

set GElink(gn,gen)/Loenhout.g12, Voeren.g6, Sinsin.g3, Petange.g4/;
table AData(a,gn,gm,*) Arc Data
                         act   C2mn
L1.Zeebrugge.Dudzele           9.07027
L2.Zeebrugge.Dudzele           9.07027
L3.Dudzele.Brugge              6.04685
L4.Dudzele.Brugge              6.04685
L5.Brugge.Zomergem             1.39543
L6.Loenhout.Antwerpen          0.10025
L7.Antwerpen.Gent              0.14865
L8.Gent.Zomergem               0.22689
L9.Zomergem.Peronnes           0.65965
L10.Voeren.Berneau       1     7.25622
L11.Voeren.Berneau       1     0.10803
L12.Berneau.Liege              1.81405
L13.Berneau.Liege              0.02701
L14.Liege.Warnand              1.45124
L15.Liege.Warnand              0.02161
L16.Warnand.Namur              0.86384
L17.Namur.Anderlues            0.90703
L18.Anderlues.Peronnes         7.25622
L19.Peronnes.Mons              3.62811
L20.Mons.Blaregnies            1.45124
L21.Warnand.Wanze              0.05144
L22.Wanze.Sinsin         1     0.00642
L23.Sinsin.Arlon               0.00170
L24.Arlon.Petange              0.02782;
table GD(Gen,*) Generating units characteristics
     Pmax   Pmin   b      Cs      Cd      RU   RD   SU    SD   UT  DT  uit U0 S0
g1   400    100    5.47   0       0       47   47   105   108  1   1   1   5  0
g2   400    100    5.47   0       0       47   47   106   112  1   1   1   6  0
g3   152    30.4   13.32  1430.4  1430.4  14   14   43    45   8   4   1   2  0
g4   152    30.4   13.32  1430.4  1430.4  14   14   44    57   8   4   1   2  0
g5   155    54.25  16     0       0       21   21   65    77   8   8   0   0  2
g6   155    54.25  10.52  312     312     21   21   66    73   8   8   1   10 0
g7   310    108.5  10.52  624     624     21   21   112   125  8   8   1   10 0
g8   350    140    10.89  2298    2298    28   28   154   162  8   8   1   5  0
g9   350    75     20.7   1725    1725    49   49   77    80   8   8   0   0  2
g10  591    206.85 20.93  3056.7  3056.7  21   21   213   228  12  10  0   0  8
g11  60     12     26.11  437     437     7    7    19    31   4   2   0   0  1
g12  300    0      0      0       0       35   35   315   326  0   0   1   2  0;
set GB(bus,Gen) connectivity index of each generating unit to each bus
/18.g1,21.g2,1.g3,2.g4,15.g5,16.g6,23.g7,23.g8,7.g9,13.g10,15.g11,22.g12/;
Table BusData(bus,*) Demands of each bus in MW
       Pd   Qd
   1   108  22
   2   97   20
   3   180  37
   4   74   15
   5   71   14
   6   136  28
   7   125  25
   8   171  35
   9   175  36
   10  195  40
   13  265  54
   14  194  39
   15  317  64
   16  100  20
   18  333  68
   19  181  37
   20  128  26;
Table branch(bus,node,*) Network technical
           r        x        b       limit
   1.2     0.0026   0.0139   0.4611  175
   1.3     0.0546   0.2112   0.0572  175
   1.5     0.0218   0.0845   0.0229  175
   2.4     0.0328   0.1267   0.0343  175
   2.6     0.0497   0.192    0.052   175
   3.9     0.0308   0.119    0.0322  175
   3.24    0.0023   0.0839   0       400
   4.9     0.0268   0.1037   0.0281  175
   5.10    0.0228   0.0883   0.0239  175
   6.10    0.0139   0.0605   2.459   175
   7.8     0.0159   0.0614   0.0166  175
   8.9     0.0427   0.1651   0.0447  175
   8.10    0.0427   0.1651   0.0447  175
   9.11    0.0023   0.0839   0       400
   9.12    0.0023   0.0839   0       400
   10.11   0.0023   0.0839   0       400
   10.12   0.0023   0.0839   0       400
   11.13   0.0061   0.0476   0.0999  500
   11.14   0.0054   0.0418   0.0879  500
   12.13   0.0061   0.0476   0.0999  500
   12.23   0.0124   0.0966   0.203   500
   13.23   0.0111   0.0865   0.1818  500
   14.16   0.005    0.0389   0.0818  500
   15.16   0.0022   0.0173   0.0364  500
   15.21   0.00315  0.0245   0.206   1000
   15.24   0.0067   0.0519   0.1091  500
   16.17   0.0033   0.0259   0.0545  500
   16.19   0.003    0.0231   0.0485  500
   17.18   0.0018   0.0144   0.0303  500
   17.22   0.0135   0.1053   0.2212  500
   18.21   0.00165  0.01295  0.109   1000
   19.20   0.00255  0.0198   0.1666  1000
   20.23   0.0014   0.0108   0.091   1000
   21.22   0.0087   0.0678   0.1424  500;
Table DataWDL(t,*)
        w                   d
   t1   0.0786666666666667  0.684511335492475
   t2   0.0866666666666667  0.644122690036197
   t3   0.117333333333333   0.61306915602972
   t4   0.258666666666667   0.599733282530006
   t5   0.361333333333333   0.588874071251667
   t6   0.566666666666667   0.5980186702229
   t7   0.650666666666667   0.626786054486569
   t8   0.566666666666667   0.651743189178891
   t9   0.484               0.706039245570585
   t10  0.548               0.787007048961707
   t11  0.757333333333333   0.839016955610593
   t12  0.710666666666667   0.852733854067441
   t13  0.870666666666667   0.870642027052772
   t14  0.932               0.834254143646409
   t15  0.966666666666667   0.816536483139646
   t16  1                   0.819394170318156
   t17  0.869333333333333   0.874071251666984
   t18  0.665333333333333   1
   t19  0.656               0.983615926843208
   t20  0.561333333333333   0.936368832158506
   t21  0.565333333333333   0.887597637645266
   t22  0.556               0.809297008954087
   t23  0.724               0.74585635359116
   t24  0.84                0.733473042484283;
Parameters Wcap(bus),conex(bus,node),SD(gn);
branch ( bus , node , ’ b i j ’ ) $branch ( bus , node , ’ Limi t ’ ) =1/ branch ( bus , node , ’x ’ ) ;
conex ( bus , node ) $ ( branch ( bus , node , ’ l imi t ’ ) and branch ( node , bus , ’ l imi t ’ ) ) =1;
conex ( bus , node ) $ ( conex ( node , bus ) ) =1; Va r i a b l e s f ( a , gn , gm, t ) , sg ( gn , t ) , p r e s s u r e ( gn , t )
,
EC, P i j ( bus , node , t ) , Pg (Gen , t ) , d e l t a ( bus , t ) , l s h ( bus , t ) ,Pw( bus , t ) , pc ( bus , t ) ,Gc ,OF ;
Pnm( a , gn ,gm) $adata ( a , gn ,gm, ’c2mn ’ )=yes ;
Equat ions const1 , const2 , const3 , const4 , const5 , const6 ,CG1,CG2,CG3,CG4, Obj e c t ive ;
cons t1 ( bus , node , t ) $conex ( bus , node ) . . P i j ( bus , node , t )=e=
branch ( bus , node , ’ b i j ’ )( d e l t a ( bus , t )d e l t a ( node , t ) ) ;
cons t2 ( bus , t ) . . l s h ( bus , t ) $BusData ( bus , ’ pd ’ )+Pw( bus , t ) $Wcap ( bus )+sum(Gen$GB( bus , Gen )
,
Pg ( Gen , t ) )DataWDL( t , ’ d ’ )BusData ( bus , ’ pd ’ ) / Sbase=e=
+sum( node$conex ( node , bus ) , P i j ( bus , node , t ) ) ;
const3 . . EC=e=sum ( ( bus ,GenD, t )$GB( bus ,GenD) , Pg (GenD, t )GD(GenD , ’ b ’ )Sbase )
+sum ( ( bus , t ) ,VOLLl s h ( bus , t )Sbase$BusData ( bus , ’ pd ’ )+VOLWPc ( bus , t )sbase$Wcap ( bus )
) ;
const4 ( gen , t ) . . pg ( gen , t +1)pg ( gen , t )=l=GD( gen , ’RU’ ) / Sbase ;
const5 ( gen , t ) . . pg ( gen , t1)pg ( gen , t )=l=GD( gen , ’RD’ ) / Sbase ;
c o n s t 6 ( bus , t ) $Wcap ( bus ) . . pc ( bus , t ) =e=DataWDL( t , ’w’ )Wcap( bus ) / Sbasepw( bus , t ) ;
Pg . l o ( Gen , t ) =GD( Gen , ’ Pmin ’ ) / Sbase ; Pg . up ( Gen , t ) =GD( Gen , ’Pmax ’ ) / Sbase ;
d e l t a . up ( bus , t )=pi / 2 ; d e l t a . lo ( bus , t )=pi / 2 ; d e l t a . fx ( slack , t ) =0;
P i j . up ( bus , node , t ) $ ( ( conex ( bus , node ) ) )=1 branch ( bus , node , ’ Limi t ’ ) / Sbase ;
P i j . lo ( bus , node , t ) $ ( ( conex ( bus , node ) ) )=1branch ( bus , node , ’ Limi t ’ ) / Sbase ;
l s h . up ( bus , t ) = DataWDL( t , ’ d ’ )BusData ( bus , ’ pd ’ ) / Sbase ; l s h . lo ( bus , t )= 0;
Pw. up ( bus , t ) =DataWDL( t , ’w’ )Wcap( bus ) / Sbase ; Pw. l o ( bus , t ) =0;
Pc . up ( bus , t ) =DataWDL( t , ’w’ )Wcap( bus ) / Sbase ; Pc . lo ( bus , t ) =0; SD( gn )=Ndata (gn , ’SD’ ) ;
CG1( gn , t ) . . sum(Pnm( a , gn ,gm) , f (Pnm, t ) )=e=sum(Pnm( a ,gm, gn ) , f (Pnm, t ) )
+sg ( gn , t ) $ ( Ndata ( gn , ’Sup ’ ) >0)DataWDL( t , ’G’ )SD( gn )
sum ( ( GenN) $Ge l ink ( gn , GenN) , Pg (GenN , t )GD(GenN , ’ b ’ )Sbase /35315) ;
CG2(Pnm( a , gn , gm) , t ) $ ( AData ( a , gn , gm, ’C2mn ’ ) AND AData ( a , gn , gm, ’ACT’ ) =0)
. . signpower ( f (Pnm, t ) ,2) =e= AData (Pnm, ’C2mn ’ )( pr e s s u r e ( gn , t )p r e s s u r e (gm, t ) ) ;
CG3(Pnm( a , gn , gm) , t ) $ ( AData ( a , gn , gm, ’C2mn ’ ) AND AData ( a , gn , gm, ’ACT’ ) =1)
. . s q r ( f (Pnm, t ) ) =g= AData (Pnm, ’C2mn ’ )( pr e s s u r e ( gn , t )p r e s s u r e (gm, t ) ) ;
CG4 . . Gc =e= sum ( ( gn , t ) , 35315 ndata ( gn , ’ c ’ )sg ( gn , t ) $Ndata ( gn , ’Sup ’ ) ) ;
O b j e c t i v e . .OF=e=EC+Gc ; sg . lo ( gn , t ) =0; sg . up ( gn , t ) = ndata ( gn , ’ sup ’ ) ;
p r e s s u r e . lo ( gn , t ) = sqr ( ndata ( gn , ’ plo ’ ) ) ; p r e s s u r e . up ( gn , t ) = sqr ( ndata ( gn , ’ pup ’ ) ) ;
f . lo (Pnm( a , gn ,gm) , t ) $ (AData ( a , gn ,gm, ’C2mn’ ) ) =
sqrt ( AData ( a , gn , gm, ’C2mn ’ )( pr e s s u r e . up ( gn , t )p r e s s u r e . lo ( gn , t ) ) ) ;
f . up (Pnm( a , gn ,gm) , t ) $ (AData ( a , gn ,gm, ’C2mn’ ) )=
sqrt ( AData ( a , gn , gm, ’C2mn ’ )( pr e s s u r e . up ( gn , t )p r e s s u r e . lo ( gn , t ) ) ) ;
f . lo (Pnm( a , gn , gm) , t ) $ ( AData ( a , gn , gm, ’C2mn ’ ) AND AData ( a , gn , gm, ’ACT’ ) =1) =0;
Model o v e r a l l / a l l / ; Solve ove r a l l using nlp min OF;
