proc RCWall { SecTag IDConcC IDConcU IDreinf BSec BCore HSec coverSec numBarsSec1 barAreaSec1 numBarsSec2 barAreaSec2} {
# ########################################################################################
# Confined Rectangular Beam Procedure
# written: Richard Wood 
# date 15 April 2008
# UC San Diego
# --------------------------------------------------------------------------------------------

# RCbeamConf $SecTag $IDconcC $IDconcU $IDreinf $BSec $HSec $coverSec $numBarsSec $barAreaSec
# explanations:
# secTag = section id number for element connectivity
# IDconcC = material id for confined concrete
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
#-----------------------------------------------------------------------------------------
#
# RC section: 
  # set coverY [expr $HSec/2.0];	# The distance from the section z-axis to the edge of the cover concrete -- outer edge of cover concrete
   #set coverZ [expr $BSec/2.0];	# The distance from the section y-axis to the edge of the cover concrete -- outer edge of cover concrete
   #set coreY [expr $coverY-$coverSec ];	# The distance from the section z-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
   #set coreZ [expr $coverZ-$coverSec ];	# The distance from the section y-axis to the edge of the core concrete --  edge of the core concrete/inner edge of cover concrete
   set nfY 10;			# number of fibers for concrete in y-direction -- core concrete
   set nfZ 25;			# number of fibers for concrete in z-direction

   #Defining points of cross section
   set C1y [expr $BSec/2.0-$coverSec-$BCore]
   set C1z [expr $HSec/2.0-$coverSec]
   
   set C2y [expr $BSec/2.0-$coverSec-$BCore]
   set C2z [expr -$HSec/2.0+$coverSec]
   
   set C3y [expr $BSec/2.0-$coverSec]
   set C3z [expr -$HSec/2.0+$coverSec]
 
  
   set C4y [expr $BSec/2.0-$coverSec]
   set C4z [expr $HSec/2.0-$coverSec]
 
  
   set C5y [expr -$BSec/2.0+$coverSec]
   set C5z [expr $HSec/2.0-$coverSec]
 
  
   set C6y [expr -$BSec/2.0+$coverSec]
   set C6z [expr -$HSec/2.0+$coverSec]
 
  
   set C7y [expr -$BSec/2.0+$coverSec+$BCore]
   set C7z [expr -$HSec/2.0+$coverSec]
 
  
   set C8y [expr -$BSec/2.0+$coverSec+$BCore]
   set C8z [expr $HSec/2.0-$coverSec]
  
   set S1y [expr -$BSec/2.0]
   set S1z [expr $HSec/2.0]
  
   set S2y [expr -$BSec/2.0]
   set S2z [expr -$HSec/2.0] 
   
   set S3y [expr $BSec/2.0]
   set S3z [expr -$HSec/2.0]  
  
   set S4y [expr $BSec/2.0]
   set S4z [expr $HSec/2.0]   
   
   
   
  section fiberSec $SecTag   {;	# Define the fiber section  
  #patch quadr $IDConcU 100 100 $S1y $S1z $S2y $S2z $S3y $S3z $S4y $S4z;
  
	# Define the core patch
	patch quadr $IDConcC $nfZ $nfY $C1y $C1z $C2y $C2z $C3y $C3z $C4y $C4z;
	patch quadr $IDConcC $nfZ $nfY $C5y $C5z $C6y $C6z $C7y $C7z $C8y $C8z;
	
	## Define core reinfocement layers
	layer straight $IDreinf $numBarsSec1 $barAreaSec1 $C1y $C1z $C4y $C4z;
	layer straight $IDreinf $numBarsSec1 $barAreaSec1 $C2y $C2z $C3y $C3z;
	
	layer straight $IDreinf $numBarsSec1 $barAreaSec1 $C5y $C5z $C8y $C8z;
	layer straight $IDreinf $numBarsSec1 $barAreaSec1 $C6y $C6z $C7y $C7z;
	
		
	## Define intermediate reinfocement layers
	#layer straight $IDreinf $numBarsSec2 $barAreaSec2  $core2y $core2z $core7y $core7z;	# top layer reinforcement left
	layer straight $IDreinf $numBarsSec2 $barAreaSec2 $C8y $C8z $C1y $C1z;
	layer straight $IDreinf $numBarsSec2 $barAreaSec2 $C7y $C7z $C2y $C2z;

	
	## Define the five unconfined patches
	patch quadr $IDConcU $nfZ $nfY $S1y $S1z $S2y $S2z $C6y $C6z $C5y $C5z;
	patch quadr $IDConcU $nfZ $nfY $C6y $C6z $S2y $S2z $S3y $S3z $C3y $C3z;
	patch quadr $IDConcU $nfZ $nfY $C3y $C3z $C4y $C4z $S3y $S3z $S4y $S4z
	patch quadr $IDConcU $nfZ $nfY $S1y $S1z $C5y $C5z $C4y $C4z $S4y $S4z; 
	patch quadr $IDConcU $nfZ $nfY $C8y $C8z $C7y $C7z $C2y $C2z $C1y $C1z;
	

	};	# end of fibersection definition
}
