proc BoxSection {secID matID D B T nfTBl nfTBt nfSl nfSt} { 
# ################################################################### 
# BoxSection $secID $matID $d $bf $tf $tw $nfTBl $nfTBt $nfSl $nfSt 
# ################################################################### 
# create a simple rectangular section given the nominal section properties 
# WARNING: does not take into account rounded corners. 
# 
# written: Frank McKenna 
# 
# input parameters: 
# secID - section ID number 
# matID - material ID number 
# H = nominal height 
# B = nominal breadth 
# T = thickness 
# nfTBl = number of fibers along Top/Bottom length 
# nfTBt = number of fibers through Top/Bottom thickness 
# nfSl = number of fibers along sides length 
# nfSt = number of fibers through sides thickness 

set y1 [expr $D/2.0] 
set y2 [expr $y1 - $T] 

set z1 [expr $B/2.0] 
set z2 [expr $z1-$T] 

section fiberSec $secID { 
# nfIJ nfJK yI zI yJ zJ yK zK yL zL 
# top and bottom 
patch quadr $matID $nfTBl $nfTBt $y2 $z1 $y2 -$z1 $y1 -$z1 $y1 $z1 
patch quadr $matID $nfTBl $nfTBt -$y1 $z1 -$y1 -$z1 -$y2 -$z1 -$y2 $z1 

# sides 
patch quadr $matID $nfSt $nfSl -$y2 $z1 -$y2 $z2 $y2 $z2 $y2 $z1 
patch quadr $matID $nfSt $nfSl -$y2 -$z2 -$y2 -$z1 $y2 -$z1 $y2 -$z2 
} 
}