## lumping script for four elements in parallel
## Richard Wood 
## UC San Diego
## 7 March 2011 

# basic tcl file determing partition wall classification
# input value: IDPW=[0,1,2]= subgroups [average-stdev,average,average+stdev]
# advanced input value: IDPW=[11,12,13,14]= subgroups [1a,1b,2a,2b]
# output material defined as $matPW

set originalwall 11.5;  # wall length in direction of shaking (ft), excluding return walls

# determination of scaling
# commerical grade (0.0188 in), 24" o.c. for 2ft
if {$PWType == 0} {
set corr_wl [expr [expr [expr ceil([expr $lenwall/2]) + 1] * 0.0188]]
}

# institutional grade (0.0312 in), 16" o.c. for 1.3333ft
if {$PWType == 1} {
set corr_wl [expr [expr [expr ceil([expr $lenwall/1.3333]) + 1] *0.0312]]
puts "total thickness of partition wall studs is:"
}

# use of subgroup models, only consider length of wall
if {$PWType == 10} {
set originalwall 11.5;  # wall length in direction of shaking (ft)
set corr_wl [expr ($lenwall/$originalwall)];
puts "correction factor for wall length is:"
}

puts $corr_wl


if {$IDPW == 0} {
set pForce [list [expr $corr_wl*10.82] [expr $corr_wl*21.07] [expr $corr_wl*8.22] [expr $corr_wl*21.07] [expr $corr_wl*21.07]];
set nForce [list [expr $corr_wl*-10.82] [expr $corr_wl*-21.07] [expr $corr_wl*-8.22] [expr $corr_wl*-21.07] [expr $corr_wl*-21.07]];
set pDisp [list 0.221 0.545 2.291 7.258 200.0];
set nDisp [list -0.221 -0.545 -2.291 -7.258 -200.0];
set rD [list 1.10 0.99 0.60 1.00 1.0];
set rF [list -0.03 0.01 0.55 0.00 0.00];
}

if {$IDPW == 1} {
set pForce [list [expr $corr_wl*13.95] [expr $corr_wl*24.28] [expr $corr_wl*16.04] [expr $corr_wl*24.28] [expr $corr_wl*24.28]];
set nForce [list [expr $corr_wl*-13.95] [expr $corr_wl*-24.28] [expr $corr_wl*-16.04] [expr $corr_wl*-24.28] [expr $corr_wl*-24.28]];
set pDisp [list 0.225 0.637 1.945 4.1 200.0];
set nDisp [list -0.225 -0.637 -1.945 -4.1 -200.0];
set rD [list 0.40 0.95 0.62 0.97 0.97];
set rF [list 0.15 0.01 0.13 0.03 0.03];
}

if {$IDPW == 2} {
set pForce [list [expr $corr_wl*15.92] [expr $corr_wl*26.43] [expr $corr_wl*23.61] [expr $corr_wl*26.43] [expr $corr_wl*26.43]];
set nForce [list [expr $corr_wl*-15.92] [expr $corr_wl*-26.43] [expr $corr_wl*-23.61] [expr $corr_wl*-26.43] [expr $corr_wl*-26.43]];
set pDisp [list 0.212 0.622 1.734 2.338 200.0];
set nDisp [list -0.212 -0.622 -1.734 -2.338 -200.0];
set rD [list 0.40 0.91 0.89 0.93 0.93];
set rF [list 0.15 0.03 0.11 0.07 0.07];
}


if {$IDPW == 11} {
set pForce [list [expr $corr_wl*1.27] [expr $corr_wl*1.68] [expr $corr_wl*1.538] [expr $corr_wl*6.65] [expr $corr_wl*6.65]];
set pDisp [list 0.204 1.196 1.695  4.0 200.0];
set nForce [list [expr $corr_wl*-1.328] [expr $corr_wl*-1.777] [expr $corr_wl*-2.218] [expr $corr_wl*-5.06] [expr $corr_wl*-5.06]];
set nDisp [list -0.214 -0.549 -1.572 -4.0 -200.0];
set rD [list 0.1 0.7 0.9 0.93 0.93];
set rF [list 0.7 0.1 0.15 0.08 0.08];
}

if {$IDPW == 12} {
set pForce [list [expr $corr_wl*1.79] [expr $corr_wl*2.645] [expr $corr_wl*2.008]  [expr $corr_wl*6.62] [expr $corr_wl*6.62]];
set pDisp [list 0.237	0.599	1.098   4.0 200.0];
set nForce [list [expr $corr_wl*-1.666] [expr $corr_wl*-2.81] [expr $corr_wl*-2.756] [expr $corr_wl*-3.08] [expr $corr_wl*-3.08]];
set nDisp [list -0.216 -0.555 -1.451  -4.0 -200];
set rD [list 0.30 0.92 0.86 0.90 0.90];
set rF [list 0.55 0.06 0.09 0.08 0.08];
}

if {$IDPW == 13} {
set pForce [list [expr $corr_wl*1.81] [expr $corr_wl* 2.55] [expr $corr_wl*1.84]  [expr $corr_wl*2.55] [expr $corr_wl*2.55]];
set pDisp [list 0.40 1.10 2.37 6.821 200.0];
set nForce [list [expr $corr_wl*-2.06] [expr $corr_wl*-2.90] [expr $corr_wl*-2.22] [expr $corr_wl*-2.90] [expr $corr_wl*-2.90]];
set nDisp [list -0.3559 -0.93 -1.984 -6.711 -200.0];
set rD [list 0.40 0.85 0.80 0.99 0.99];
set rF [list 0.18 0.18 0.20 0.20 0.20];
}

if {$IDPW == 14} {
set pForce [list [expr $corr_wl*5.807] [expr $corr_wl*6.912] [expr $corr_wl*4.080] [expr $corr_wl*6.6912] [expr $corr_wl*6.6912]];
set pDisp [list 0.412 0.694 2.676 6.912 200.0];
set nForce [list [expr $corr_wl*-5.265] [expr $corr_wl*-6.900] [expr $corr_wl*-4.389] [expr $corr_wl*-6.900] [expr $corr_wl*-6.900]];
set nDisp [list -0.336 -0.65 -2.433 -5.126 -200.0];
set rD [list 0.40 0.90 0.55 0.99 0.99];
set rF [list 0.15 0.01 0.15 0.01 0.01];
}


#source procpwall.tcl
#procpwall $matID $pForce $nForce $pDisp $nDisp $rD $rF


#proc procpwall2 { matID pForce nForce pDisp nDisp rD rF} {

# 5 piece material combination in parallel forumulation
set eps 0.00000001; # essentially zero as much lower than accuracy
set neps -0.00000001;


############################# General Terms #######################################################
#source procUniaxialPinching.tcl
set uForce [list -0.01 -0.01]
set gammaK [list -100.0 -100.0 -100.0 -100.0 -1000.0 ]
set gammaD [list 0.0 0.0 0.0 0.0 0.0]
set gammaD [list 0.0 0.0 0.0 0.0 0.0]
set gammaF [list 0.0 0.0 0.0 0.0 0.0]
set gammaE 100.0;
set damage "cycle";
############################# Material 1 #######################################################
set matID1 9001;
set pEnvelopeStress [list [expr [lindex $pForce 0]] $eps $eps $eps $eps]
set nEnvelopeStress [list [expr [lindex $nForce 0]] $neps $neps $neps $neps]
set rDisp [list [expr [lindex $rD 0]] [expr [lindex $rD 0]]]
set rForce [list [expr [lindex $rF 0]] [expr [lindex $rF 0]]]
set gammaK [list -10000.0 -10000.0 -10000.0 -10000.0 -100000.0 ]
uniaxialMaterial Pinching4 $matID1 [lindex $pEnvelopeStress 0] [lindex $pDisp 0] [lindex $pEnvelopeStress 1] [lindex $pDisp 1] [lindex $pEnvelopeStress 2] [lindex $pDisp 2] [lindex $pEnvelopeStress 3] [lindex $pDisp 3] [lindex $nEnvelopeStress 0] [lindex $nDisp 0] [lindex $nEnvelopeStress 1] [lindex $nDisp 1] [lindex $nEnvelopeStress 2] [lindex $nDisp 2] [lindex $nEnvelopeStress 3] [lindex $nDisp 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage
############################# Material 2 #######################################################
set matID2 9002;
set pEnvelopeStress [list $eps [expr [lindex $pForce 1]] $eps $eps $eps]
set nEnvelopeStress [list $neps [expr [lindex $nForce 1]] $neps $neps $neps]
set rDisp [list [expr [lindex $rD 1]] [expr [lindex $rD 1]]]
set rForce [list [expr [lindex $rF 1]] [expr [lindex $rF 1]]]
uniaxialMaterial Pinching4 $matID2 [lindex $pEnvelopeStress 0] [lindex $pDisp 0] [lindex $pEnvelopeStress 1] [lindex $pDisp 1] [lindex $pEnvelopeStress 2] [lindex $pDisp 2] [lindex $pEnvelopeStress 3] [lindex $pDisp 3] [lindex $nEnvelopeStress 0] [lindex $nDisp 0] [lindex $nEnvelopeStress 1] [lindex $nDisp 1] [lindex $nEnvelopeStress 2] [lindex $nDisp 2] [lindex $nEnvelopeStress 3] [lindex $nDisp 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage
############################# Material 3 #######################################################
set matID3 9003;
set pEnvelopeStress [list $eps $eps [expr [lindex $pForce 2]] $eps $eps]
set nEnvelopeStress [list $neps $neps [expr [lindex $nForce 2]] $neps $neps]
set rDisp [list [expr [lindex $rD 2]] [expr [lindex $rD 2]]]
set rForce [list [expr [lindex $rF 2]] [expr [lindex $rF 2]]]
uniaxialMaterial Pinching4 $matID3 [lindex $pEnvelopeStress 0] [lindex $pDisp 0] [lindex $pEnvelopeStress 1] [lindex $pDisp 1] [lindex $pEnvelopeStress 2] [lindex $pDisp 2] [lindex $pEnvelopeStress 3] [lindex $pDisp 3] [lindex $nEnvelopeStress 0] [lindex $nDisp 0] [lindex $nEnvelopeStress 1] [lindex $nDisp 1] [lindex $nEnvelopeStress 2] [lindex $nDisp 2] [lindex $nEnvelopeStress 3] [lindex $nDisp 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage
############################# Material 4 #######################################################
set matID4 9004;
set pEnvelopeStress [list $eps $eps $eps [expr [lindex $pForce 3]] $eps]
set nEnvelopeStress [list $neps $neps $neps [expr [lindex $nForce 3]] $neps]
set rDisp [list [expr [lindex $rD 3]] [expr [lindex $rD 3]]]
set rForce [list [expr [lindex $rF 3]] [expr [lindex $rF 3]]]
uniaxialMaterial Pinching4 $matID4 [lindex $pEnvelopeStress 0] [lindex $pDisp 0] [lindex $pEnvelopeStress 1] [lindex $pDisp 1] [lindex $pEnvelopeStress 2] [lindex $pDisp 2] [lindex $pEnvelopeStress 3] [lindex $pDisp 3] [lindex $nEnvelopeStress 0] [lindex $nDisp 0] [lindex $nEnvelopeStress 1] [lindex $nDisp 1] [lindex $nEnvelopeStress 2] [lindex $nDisp 2] [lindex $nEnvelopeStress 3] [lindex $nDisp 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage
############################# Material 5 #######################################################
set matID5 9005;
set pEnvelopeStress [list $eps $eps $eps $eps [expr [lindex $pForce 4]]]
set nEnvelopeStress [list $neps $neps $neps $neps [expr [lindex $nForce 4]] ]
set rDisp [list [expr [lindex $rD 4]] [expr [lindex $rD 4]]]
set rForce [list [expr [lindex $rF 4]] [expr [lindex $rF 4]]]
uniaxialMaterial Pinching4 $matID5 [lindex $pEnvelopeStress 0] [lindex $pDisp 0] [lindex $pEnvelopeStress 1] [lindex $pDisp 1] [lindex $pEnvelopeStress 2] [lindex $pDisp 2] [lindex $pEnvelopeStress 3] [lindex $pDisp 3] [lindex $nEnvelopeStress 0] [lindex $nDisp 0] [lindex $nEnvelopeStress 1] [lindex $nDisp 1] [lindex $nEnvelopeStress 2] [lindex $nDisp 2] [lindex $nEnvelopeStress 3] [lindex $nDisp 3] [lindex $rDisp 0] [lindex $rForce 0] [lindex $uForce 0] [lindex $rDisp 1] [lindex $rForce 1] [lindex $uForce 1] [lindex $gammaK 0] [lindex $gammaK 1] [lindex $gammaK 2] [lindex $gammaK 3] [lindex $gammaK 4] [lindex $gammaD 0] [lindex $gammaD 1] [lindex $gammaD 2] [lindex $gammaD 3] [lindex $gammaD 4] [lindex $gammaF 0] [lindex $gammaF 1] [lindex $gammaF 2] [lindex $gammaF 3] [lindex $gammaF 4] $gammaE $damage
############################# Lumped Material #######################################################
uniaxialMaterial Parallel $matID $matID1 $matID2 $matID3 $matID4 $matID5