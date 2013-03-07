var OpenSees= require('../index.js');
var ops = new OpenSees();

ops.on('stdout', function(str) {
  console.log('stdout:' + str);
});

ops.on('stderr', function(str) {
  console.log('stderr:' + str);
});

ops.on('data', function(d) {
  var i = 0, num;
  console.log('len:' + d.length);
  while (i + 8 < d.length) {
    console.log('i:' + i);
    console.log(d.readDoubleLE(i));
    i += 8;
  }
});

ops.on('ready', function(d) {
  ops.interp('disable_recorder');
  ops.interp('disable_analyze');
  
  ops.interp('cd $RES_PATH/projects/truss');
  ops.interp('puts "current dir: [pwd]"');
  ops.interp('source Truss.tcl');
  
  ops.interp('enable_recorder');
  ops.interp('recorder Node -binary $__DATA_STREAM_FILE -node 1 2 3 4 -dof 1 2 disp');
  
  ops.interp('enable_analyze');
  ops.interp('analyze 1');
  // ops.interp('record');
  
  // ops.interp('puts $__DATA_STREAM_FD "node 4: [nodeDisp 4]"');

  // The recorder doen't work right now. Because the data in the channel doen't get flushed.
  // Opensees provide no way to get fd of a recorder
  // flushData try to flush different channel
  // ops.flushData();

  // Try to hack here, guess the file descriptor is file4, doesn't work
  // ops.interp('flush file4');
  
  // Call exit can flush all data to file
  ops.interp('exit');
  
  // console.log('pid:', ops.interpreter.pid);
  // ops.interp('flush $__DATA_STREAM_FD');
});
