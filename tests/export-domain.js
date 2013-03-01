var OpenSees= require('../index.js');
var ops = new OpenSees();

ops.on('stdout', function(str) {
  console.log('stdout:' + str);
});

ops.on('stderr', function(str) {
  console.log('stderr:' + str);
});

ops.on('data', function(d) {
  console.log('data:' + d);
});

ops.on('ready', function(d) {
  ops.interp('disable_recorder');
  ops.interp('disable_analyze');
  
  ops.interp('cd $RES_PATH/projects/truss');  
  ops.interp('puts "current dir: [pwd]"');
  ops.interp('source Truss.tcl');
  ops.exportDomain();

  // FIXME: json-echo-domain command has bug
  // ops.interp('cd $RES_PATH/projects/WithSHJ/json');  
  // ops.interp('puts "current dir: [pwd]"');
  // ops.interp('source build_model.tcl');
  // ops.exportDomain();  

});
