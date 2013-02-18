wipe;
model basic -ndm 2 -ndf 2;
nDMaterial ElasticIsotropic 2 29000 0.3;
nDMaterial PlaneStrain 3 2;

block2D 4 4 1 1 quad "1 PlaneStrain2D 3" {
    1 0 0
    2 400 0
    3 400 100
    4 0 100
};

fix 1 1 1;
fix 4 1 1;

timeSeries Linear 1;

pattern Plain 1 1 {
    load 2 100 0.0 0.0
}

system BandSPD
numberer RCM
constraints Transformation
integrator LoadControl 1.0
algorithm Linear
analysis Static 
recorder Node -file example.out -time -node 4 -dof 1 2 disp
recorder Element -file eleLocal.out -time -ele 1 2 3  basicForces
analyze 1
