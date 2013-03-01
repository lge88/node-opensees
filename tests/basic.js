var OpenSees= require('../index.js');
var ops = new OpenSees();

ops.on('stdout', function(str) {
  console.log('stdout:' + str);
});

ops.on('stderr', function(str) {
  console.log('stderr:' + str);
});

console.log('initialized!');
ops.interp('puts "current dir: [pwd]"');
ops.interp('puts "RES: $RES"');
ops.interp('puts "INIT_PATH: $INIT_PATH"');
ops.interp('puts "TMP: $RES"');
ops.interp('disable_recorder');
ops.interp('disable_analyze');
ops.interp('enable_model_history');

ops.interp('cd $RES/projects/truss');
ops.interp('puts "current dir: [pwd]"');
ops.interp('source Truss.tcl');
ops.interp('enable_analyze');
ops.interp('analyze 1 asdf');
ops.interp('puts [nodeDisp 4]');
// ops.interp('print_cmd_history');