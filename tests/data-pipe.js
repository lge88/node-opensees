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
  ops.interp('enable_model_history');
  ops.interp('puts "data stream fd: $__DATA_STREAM_FD"');  
  ops.interp('puts "hello"');
  ops.interp('puts $__DATA_STREAM_FD  "world"');
  ops.flushData();
  // ops.interp('flush $__DATA_STREAM_FD');
});
