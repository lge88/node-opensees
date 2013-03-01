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
  ops.interp('disable_analyze');
  
  ops.interp('cd $RES_PATH/projects/truss');
  ops.interp('puts "current dir: [pwd]"');
  ops.interp('source Truss.tcl');
  ops.interp('puts "node 4 displacement: [nodeDisp 4]"');
  
  ops.interp('enable_analyze');
  ops.interp('analyze 1');
  
  ops.interp('puts "node 4 displacement: [nodeDisp 4]"');
});                                

