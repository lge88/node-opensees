var OpenSees= require('../index.js');
var ops = new OpenSees();

ops.on('stdout', function(str) {
  console.log('stdout:' + str);
});

ops.on('stderr', function(str) {
  // console.log('stderr:' + str);
});

ops.on('ready', function() {
  ops.interp('disable_recorder');
  ops.interp('enable_analyze');
  ops.interp('enable_model_history');
  
  ops.interp('cd $RES_PATH/projects/truss');
  ops.interp('puts "current dir: [pwd]"');
  ops.interp('source Truss.tcl');
  ops.interp('puts "node 4 displacement: [nodeDisp 4]"');
  
  ops.interp('puts "command history:"');
  ops.interp('puts $command_history');
});                                
