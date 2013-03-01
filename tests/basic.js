var OpenSees= require('../index.js');
var ops = new OpenSees();

ops.on('stdout', function(str) {
  console.log('stdout:' + str);
});

ops.on('stderr', function(str) {
  console.log('stderr:' + str);
});

ops.on('ready', function() {
  console.log('initialized!');
  ops.interp('puts "current dir: [pwd]"');
  ops.interp('puts "RES: $RES_PATH"');
  ops.interp('puts "INIT_PATH: $INIT_PATH"');
  ops.interp('puts "TMP: $TMP_PATH"');
  ops.interp('puts "__DATA_STREAM_FILE: $__DATA_STREAM_FILE"');
  ops.interp('puts "__DATA_STREAM_FD: $__DATA_STREAM_FD"');
});
