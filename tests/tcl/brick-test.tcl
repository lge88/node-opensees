model BasicBuilder -ndm 3 -ndf 3

nDMaterial ElasticIsotropic3D 1      100  0.2
block3D 3 3 3 1 1 stdBrick 1 {
    1 1.0 1.0 0.0
    2 0.0 1.0 0.0
    3 0.0 0.0 0.0
    4 1.0 0.0 0.0
    5 1.0 1.0 1.0
    6 0.0 1.0 1.0
    7 0.0 0.0 1.0
    8 1.0 0.0 1.0 
}

for {set i 1} {$i < 10} {incr i} {
    fix $i 1 1 1
}


# fix 1   0 0 1
# fix 2   1 0 1
# fix 3   1 1 1
# fix 4   0 1 1
# #fix 5 1 0 1
#fix 6 1 0 1
#fix 7 1 0 1
#fix 8 1 0 1

# linear elastic material     tag		  E		  nu	   rho


#            tag     8 nodes          matID  bforce1 bforce2 bforce3   massdensity
# element Brick8N  1  5 6 7 8 1 2 3 4   1      0.0     0.0     0.0     1.8
# element stdBrick  1  5 6 7 8 1 2 3 4   1      0.0     0.0     0.0     1.8
#element stdBrick  1  1 2 3 4 5 6 7 8   1      0.0     0.0    -9.81    1.8
#element stdBrick  1  5 6 7 8 1 2 3 4   1      0.0     0.0    -9.81    1.8



pattern Plain 1 Linear {
    # load  555      0    0  -1.0
    load  5      0    0  -1.0
    # load  666      0    0  -1.0 
    # load  777      0    0  -1.0 
    # load  888      0    0  -1.0 
}

set lf1 1.0

constraints Penalty 1e9 1e9


integrator LoadControl $lf1 

# # CHOOSE algorithm
# #set different_algorithms  Linear
set different_algorithms  Newton
puts "USING  $different_algorithms ALGORITHM"


# # this is needed by Newton 
# # test NormDispIncr 1.0e-8 30 1
test NormDispIncr 1.0e-8 30
# #test NormUnbalance 1.0e-8 30 1

algorithm $different_algorithms
numberer RCM
system UmfPack
analysis Static


# set fd [open "./tmp/opensees.fifo" "w"]
# fconfigure $fd -blocking 0

set string "recorder Node -file \"./tmp/opensees.fifo\" -node [getNodeTags] -dof 1 2 3 disp";
eval $string
# recorder Node -tcp "127.0.0.1" 3003 -nodeRange 1 29000 -dof 1 2 3 disp

for {set i 1} {$i <= 5} {incr i} {
#     # puts fifo $i
#     # analyze 1 2 3 54
    analyze 1

#     # for {set j 1} {$j <= 10000} {incr j} {
#     #     puts $fd "i: $i, j: $j, val: [eleResponse 1 material 1 strain]"
#     # }

    # foreach j [getNodeTags] {
    #     puts $fd "i: $i, j: $j, val: [nodeDisp $j 1]"
    # }


}

# puts "analyze finished!"
# # puts "blocked: [fblocked $fd]"
# # flush $fd
# # puts "blocked: [fblocked $fd]"
# # close $fifo
# # close $fd

proc sleep {time} {
    after $time set end 1
    vwait end
}

sleep 30
