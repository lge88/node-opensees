proc __dirname {} {
    return [file normalize [file join [pwd] [file dirname [info script]]]]
}

proc __filename {} {
    return [file normalize [file join [pwd] [info script]]]
}

rename analyze __analyze
proc analyze args {
    puts "you don't run analyze here, haha"
}

rename recorder __recorder
proc recorder args {
    puts "you don't set recorder here, haha"
}

rename print __print
proc print args {
    puts "you don't print here, haha"
}

set command_history [list ]
proc print_cmd_history {} {    
    global command_history
    set i 0
    puts "commands history:"
    foreach cmd $command_history {
        puts "cmd $i:"
        foreach j $cmd {
            puts $j
        }
        incr i
    }
}

proc enable_model_history {} {

    rename model __model
    proc model args {
        eval "__model $args"
        
        global node
        rename node __node
        proc node args {
            global command_history
            lappend command_history [linsert $args 0 "node"]
            eval "__node $args"
        }

        global element
        rename element __element
        proc element args {
            global command_history
            lappend command_history [linsert $args 0 "element"]
            eval "__element $args"
        }

        global fix
        rename fix __fix
        proc fix args {
            global command_history
            lappend command_history [linsert $args 0 "fix"]
            eval "__fix $args"
        }

        global fixX
        rename fixX __fixX
        proc fixX args {
            global command_history
            lappend command_history [linsert $args 0 "fixX"]
            eval "__fixX $args"
        }

        global fixY
        rename fixY __fixY
        proc fixY args {
            global command_history
            lappend command_history [linsert $args 0 "fixY"]
            eval "__fixY $args"
        }

        global fixZ
        rename fixZ __fixZ
        proc fixZ args {
            global command_history
            lappend command_history [linsert $args 0 "fixZ"]
            eval "__fixZ $args"
        }

        global equalDOF
        rename equalDOF __equalDOF
        proc equalDOF args {
            global command_history
            lappend command_history [linsert $args 0 "equalDOF"]
            eval "__equalDOF $args"
        }

        global rigidDiaphragm
        rename rigidDiaphragm __rigidDiaphragm
        proc rigidDiaphragm args {
            global command_history
            lappend command_history [linsert $args 0 "rigidDiaphragm"]
            eval "__rigidDiaphragm $args"
        }

        global rigidLink
        rename rigidLink __rigidLink
        proc rigidLink args {
            global command_history
            lappend command_history [linsert $args 0 "rigidLink"]
            eval "__rigidLink $args"
        }

        global timeSeries
        rename timeSeries __timeSeries
        proc timeSeries args {
            global command_history
            lappend command_history [linsert $args 0 "timeSeries"]
            eval "__timeSeries $args"
        }

        global pattern
        rename pattern __pattern
        proc pattern args {
            global command_history
            lappend command_history [linsert $args 0 "pattern"]
            eval "__pattern $args"
        }

        global mass
        rename mass __mass
        proc mass args {
            global command_history
            lappend command_history [linsert $args 0 "mass"]
            eval "__mass $args"
        }

        global block2D
        rename block2D __block2D
        proc block2D args {
            global command_history
            lappend command_history [linsert $args 0 "block2D"]
            eval "__block2D $args"
        }

        global block3D
        rename block3D __block3D
        proc block3D args {
            global command_history
            lappend command_history [linsert $args 0 "block3D"]
            eval "__block3D $args"
        }

        global region
        rename region __region
        proc region args {
            global command_history
            lappend command_history [linsert $args 0 "region"]
            eval "__region $args"
        }

        global rayleigh
        rename rayleigh __rayleigh
        proc rayleigh args {
            global command_history
            lappend command_history [linsert $args 0 "rayleigh"]
            eval "__rayleigh $args"
        }

        global ShallowFoundationGen
        rename ShallowFoundationGen __ShallowFoundationGen
        proc ShallowFoundationGen args {
            global command_history
            lappend command_history [linsert $args 0 "ShallowFoundationGen"]
            eval "__ShallowFoundationGen $args"
        }

        global uniaxialMaterial
        rename uniaxialMaterial __uniaxialMaterial
        proc uniaxialMaterial args {
            global command_history
            lappend command_history [linsert $args 0 "uniaxialMaterial"]
            eval "__uniaxialMaterial $args"
        }

        global nDMaterial
        rename nDMaterial __nDMaterial
        proc nDMaterial args {
            global command_history
            lappend command_history [linsert $args 0 "nDMaterial"]
            eval "__nDMaterial $args"
        }

        global section
        rename section __section
        proc section args {
            global command_history
            lappend command_history [linsert $args 0 "section"]
            eval "__section $args"
        }

        global geomTransf
        rename geomTransf __geomTransf
        proc geomTransf args {
            global command_history
            lappend command_history [linsert $args 0 "geomTransf"]
            eval "__geomTransf $args"
        }

        global frictionModel
        rename frictionModel __frictionModel
        proc frictionModel args {
            global command_history
            lappend command_history [linsert $args 0 "frictionModel"]
            eval "__frictionModel $args"
        }
        
    }
    

}
