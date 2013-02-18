var Ops = require('../index.js');
var ops = new Ops();

ops.on('stdout', function(str) {
  console.log('stdout:' + str);
});

ops.on('stderr', function(str) {
  console.log('stderr:' + str);
});

ops.on('initialized', function(str) {
  console.log('initialized!');
  ops.interp('puts "current dir: [pwd]"');
  ops.interp('enable_model_history');
  ops.interp('cd /home/GL/Develop/js/node-opensees/resource/projects/WithSHJ');
  ops.interp('puts "current dir: [pwd]"');
  // ops.interp('read stdin 1');
  ops.interp('set unitsSys "US"');
  ops.interp('source SIUnits.tcl');
  ops.interp('source SystemPara_Yong6.tcl');
  // ops.interp('model basic -ndm 2 -ndf 3');
  // ops.interp('node 2 3 3');
  // ops.interp('puts "try original node:"');
  
  // ops.interp('__node 1 2 3');
  
  ops.interp('print_cmd_history');
  // ops.interp('puts "\nhistory:\n$command_history"');
  // ops.interp('puts "\nhistory:\n[history]"');
});

// ops.interp('puts "current dir: [pwd]"');
// ops.interp('source ./tcl/block2D.tcl');

// ops.interp('print');
