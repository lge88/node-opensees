proc RCcolumn { SecTag IDConcC IDConcU IDreinf BSec HSec cover numBarsSec barAreaSec} {
# ########################################################################################
# Confined Rectangular Column Procedure
# written: Richard Wood 
# date 15 April 2008
# UC San Diego
# taken from example: Ex9e.build.RCSection.Rect2D
# authored: Silvia Mazzoni & Frank McKenna, 2006
# --------------------------------------------------------------------------------------------

# RCcolumn $SecTag $IDconcC $IDconcU $IDreinf $BSec $HSec $cover $numBarsSec $barAreaSec
# explanations:
# secTag = section id number for element connectivity
# IDconcC = material id for confined concrete
# IDconcU = material id for unconfined concrete
# Bsec = b of the column cross section
# Hsec = height of the column cross section
# cover = cover to the NA of the longitudinal reinforcement
# numBarsSec = number of reinforcing bars in the section (total), equal sides
# barAreaSec = area of the longitudinal bar
# ########################################################################################

set numBarsTop [expr $numBarsSec/4 + 1];		# number of longitudinal-reinforcement bars in steel layer. -- top
set numBarsBot $numBarsTop;				# number of longitudinal-reinforcement bars in steel layer. -- bot
set numBarsIntTot [expr $numBarsSec - $numBarsTop - $numBarsBot];			# number of longitudinal-reinforcement bars in steel layer. -- total intermediate skin reinforcement, symm about y-axis

# FIBER SECTION properties -------------------------------------------------------------
#
#                        y
#                        ^
#                        |     
#             ---------------------    --   --
#             |   o     o     o    |     |    -- coverH
#             |                      |     |
#             |   o            o    |     |
#    z <--- |          +          |     Hsec
#             |   o            o    |     |
#             |                      |     |
#             |   o o o o o o    |     |    -- coverH
#             ---------------------    --   --
#             |-------Bsec------|
#             |---| coverB  |---|
#
#                       y
#                       ^
#                       |    
#             ---------------------
#             |\      cover        /|
#             | \------Top------/ |
#             |c|                   |c|
#             |o|                   |o|
#  z <-----|v|       core      |v|  Hsec
#             |e|                   |e|
#             |r|                    |r|
#             | /-------Bot------\ |
#             |/      cover        \|
#             ---------------------
#                       Bsec
#
# Notes
#    The core concrete ends at the NA of the reinforcement
#    The center of the section is at (0,0) in the local axis system

set coverY [expr $HSec/2.0];	# The distance from the section z-axis to the edge of the cover concrete -- outer edge of cover concrete
set coverZ [expr $BSec/2.0];	# The distance from the section y-axis to the edge of the cover concrete -- outer edge of cover concrete
set coreY [expr $coverY-$cover];	# The distance from the section z-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
set coreZ [expr $coverZ-$cover];	# The distance from the section y-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concreteset nfY 16;			# number of fibers for concrete in y-direction
set nfY 16;			# number of fibers for concrete in y-direction
set nfZ 4;				# number of fibers for concrete in z-direction
set numBarsInt [expr $numBarsIntTot/2];	# number of intermediate bars per side
section fiberSec $SecTag     {;	# Define the fiber section
	patch quadr $IDConcC $nfZ $nfY -$coreY $coreZ -$coreY -$coreZ $coreY -$coreZ $coreY $coreZ; 	# Define the core patch
	patch quadr $IDConcU 1 $nfY -$coverY $coverZ -$coreY $coreZ $coreY $coreZ $coverY $coverZ;	# Define the four cover patches
	patch quadr $IDConcU 1 $nfY -$coreY -$coreZ -$coverY -$coverZ $coverY -$coverZ $coreY -$coreZ
	patch quadr $IDConcU $nfZ 1 -$coverY $coverZ -$coverY -$coverZ -$coreY -$coreZ -$coreY $coreZ
	patch quadr $IDConcU $nfZ 1 $coreY $coreZ $coreY -$coreZ $coverY -$coverZ $coverY $coverZ
	layer straight $IDreinf $numBarsInt $barAreaSec  -$coreY $coreZ $coreY $coreZ;	# intermediate skin reinf. +z
	layer straight $IDreinf $numBarsInt $barAreaSec  -$coreY -$coreZ $coreY -$coreZ;	# intermediate skin reinf. -z
	layer straight $IDreinf $numBarsTop $barAreaSec $coreY $coreZ $coreY -$coreZ;	# top layer reinfocement
	layer straight $IDreinf $numBarsBot $barAreaSec  -$coreY $coreZ  -$coreY -$coreZ;	# bottom layer reinforcement
};	# end of fibersection definition
}
