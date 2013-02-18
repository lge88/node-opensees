wipe;
model basic -ndm 2 -ndf 3
geomTransf Linear 1;
geomTransf PDelta 2;
geomTransf Corotational 3;
node 1 720 300 -mass 2556 2556 2556;
node 2 720 120 -mass 2556 2556 2556;
element elasticBeamColumn 1 1 2 100 29000 833.3333 3;
fix 2 1 1 1;
timeSeries Path 2 -dt 0.02 -filePath gmotion.txt -factor 1;
pattern UniformExcitation 2 1 -accel 2;
constraints Plain;
numberer Plain;
system BandGeneral;
test NormDispIncr 1e-8 15;
algorithm Newton;
integrator Newmark 0.5 0.25;
analysis Transient;
set counter 1;
while {$counter < 100} {
analyze 1 0.02;
#puts [allNodeDisp];
puts [nodeDisp 1]
incr counter;
}
