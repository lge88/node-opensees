proc RCbeam { SecTag IDConcU IDreinf BSec HSec coverSec numBarsSec barAreaSec} {
# ########################################################################################
# UnConfined Rectangular Beam Procedure
# written: Richard Wood 
# date 15 April 2008
# UC San Diego
# taken from example: Ex9d.build.RCSection.RectConfinedSymm2D
# authored: Silvia Mazzoni & Frank McKenna, 2006
# --------------------------------------------------------------------------------------------

# RCbeam $SecTag $IDconcU $IDreinf $BSec $HSec $coverSec $numBarsSec $barAreaSec
# explanations:
# secTag = section id number for element connectivity
# IDconcU = material id for unconfined concrete
# Bsec = b of the beam cross section
# Hsec = height of the beam cross section
# coverSec = cover to the NA of the longitudinal reinforcement
# numBarsSec = number of reinforcing bars in the section, symmetric top and bottom
# barAreaSec = area of the longitudinal bar
# ########################################################################################

#-----------------------------------------------------------------------------------------
# symmetric section
#                        y
#                        ^
#                        |     
#             ---------------------     --   --
#             |   o     o     o    |     |    -- cover
#             |                       |     |
#             |                       |     |
#    z <--- |          +           |     H
#             |                       |     |
#             |                       |     |
#             |   o     o     o    |     |    -- cover
#             ---------------------     --   --
#             |-------- B --------|
# 
#-----------------------------------------------------------------------------------------
#
# RC section: 
   set coverY [expr $HSec/2.0];	# The distance from the section z-axis to the edge of the cover concrete -- outer edge of cover concrete
   set coverZ [expr $BSec/2.0];	# The distance from the section y-axis to the edge of the cover concrete -- outer edge of cover concrete
   set coreY [expr $coverY-$coverSec ];	# The distance from the section z-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
   set coreZ [expr $coverZ-$coverSec ];	# The distance from the section y-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
   set nfY 16;			# number of fibers for concrete in y-direction
   set nfZ 4;			# number of fibers for concrete in z-direction
#set nfY 90;			# number of fibers for concrete in y-direction
#   set nfZ 70;			# number of fibers for concrete in z-direction
   section fiberSec $SecTag   {;	# Define the fiber section
	# Define the core patch
	patch quadr $IDConcU $nfZ $nfY -$coverY $coverZ -$coverY -$coverZ $coverY -$coverZ $coverY $coverZ; 	# Define the concrete patch
	# Define reinfocement layers
	layer straight $IDreinf $numBarsSec $barAreaSec  $coreY $coreZ  $coreY -$coreZ;	# top layer reinforcement
	layer straight $IDreinf $numBarsSec $barAreaSec -$coreY $coreZ -$coreY -$coreZ;	# bottom layer reinfocement
    };	# end of fibersection definition
}
