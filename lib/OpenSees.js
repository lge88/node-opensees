var _ = require('lodash');
var child_process = require('child_process');
var spawn = child_process.spawn;
var exec = child_process.exec;
var fs = require('fs');
var path = require('path');
var net = require('net');
var events = require('events');
var util = require('util');

var mkdirp = require('mkdirp').sync;
var tmpDir = path.resolve(__dirname + '/tmp/');
mkdirp(tmpDir);

var defaults = {
  executable : 'OpenSees',
  executeArgs : ['--no-prompt'],
  autoRestart : true,
  tclDir : path.resolve(__dirname + '/tcl'),
  initScript : 'init.tcl',
  ipcMethod : 'pipe',
  tcpPort : 8124
};

function makePipeForce(name, next) {
  var cb = function(err, stdout, stderr) {
    if (err) {
      console.error(err);
      return;
    } else {
      exec('mkfifo ' + name, next);
    }
  };
  fs.exists(name, function(exists) {
    if (exists) {
      fs.unlink(name, function(err) {
        if(err) {
          console.error(err);
          return;
        }
        cb();
      });
    } else {
      cb();
    }
  });
}

// FIXME: can't capture exit event
process.on('exit', function() {
  fs.unlink('/tmp/ops*', function(err) {
    console.log('clean it up!');
    if (err) {
      console.error(err);
      return;
    }
  });
});

util.inherits(OpenSees, events.EventEmitter);
function OpenSees(config) {
  events.EventEmitter.call(this);
  this.options = _.defaults(config || {}, defaults);
  var self = this;
  this.interpreter = spawn(this.options.executable, this.options.executeArgs);
  this.interpreter.stdout.on('data', function(data){
    self.emit('stdout', data.toString());
  });
  this.interpreter.stderr.on('data', function(data){
    self.emit('stderr', data.toString());
  });
  this.interpreter.on('exit', function(data){
    self.emit('exit', data);
  });
  this.init(this.options.ipcMethod);
};

OpenSees.prototype.init = function() {
  var _this = this;
  this.dataPipe = '/tmp/ops_' + Date.now();
  makePipeForce(this.dataPipe, function(err) {
    if (err) {
      console.error(err);
      return;
    } else {
      _this.interp('source ' + _this.options.tclDir + '/' + _this.options.initScript);

      _this.interp('set __DATA_STREAM_FILE "' + _this.dataPipe + '"');
      _this.interp('set __DATA_STREAM_FD [open "' + _this.dataPipe + '" "w"]');
      _this.dataStream = fs.createReadStream(_this.dataPipe);
      _this.dataStream.on('data', function(d) {
        _this.emit('data', d);
      });
      _this.emit('ready');
    }
  });
};

OpenSees.prototype.exportDomain = function() {
  this.interp('puts [json-echo-domain]');
  this.flushData();
};

OpenSees.prototype.flushData = function() {
  this.interp('flush $__DATA_STREAM_FD');
};

OpenSees.prototype.interp = function(str) {
  this.interpreter.stdin.write(str + '\n');
  this.emit('command', str);
};

OpenSees.prototype.setRecorders = function() {
  this.interp('set ');
};


OpenSees.prototype.formatCommand = formatCommand;
function formatCommand(str) {
  var cmds=[];
  var cmd;
  var result = '';
  str.trim().split(/[\n;]/).forEach(function(s) {
        var cmd = s.trim().replace(/\s+/g, ' ');
    if (cmd !== '' && cmd[0] !== '#') {
      cmds.push(cmd);
    }
  });
  for (var i = -1, len = cmds.length; ++i < len;) {
    cmd = cmds[i].trim();
    result += cmd + ';';
  }
  result += "\n";
  return result;
}

module.exports = OpenSees;